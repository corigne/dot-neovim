local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
	print("nvim-dap not installed!")
	return
end

vim.api.nvim_create_autocmd("BufWinEnter", {
	desc = "Set options on DAP windows",
	group = vim.api.nvim_create_augroup("set_dap_win_options", { clear = true }),
	pattern = {
		"\\[dap-repl-*\\]",
	},
	callback = function(args)
		local win = vim.fn.bufwinid(args.buf)
		vim.schedule(function()
			if not vim.api.nvim_win_is_valid(win) then
				return
			end
			vim.api.nvim_set_option_value("wrap", true, { win = win })
			vim.api.nvim_set_option_value("number", true, { win = win })
			vim.api.nvim_set_option_value("relativenumber", true, { win = win })
		end)
	end,
})

require("dap-go").setup()
require("nvim-dap-virtual-text").setup()

local dapui = require("dapui")

-- Layout dimensions recomputed at each debug session start to match the current
-- terminal size. Mutable — overwritten by init_dapui() on every session start.
local SIDEBAR_WIDTH = 40
local REPL_HEIGHT = 10
local SIDEBAR_MIN_WIDTH = 30 -- absolute floor enforced by WinResized guard

-- Filetypes used by the dap-ui left sidebar elements.
local DAPUI_SIDEBAR_FTS = {
	dapui_scopes = true,
	dapui_breakpoints = true,
	dapui_stacks = true,
	dapui_watches = true,
}

-- Compute layout dimensions from the current terminal size:
--   sidebar  = max(25% total width,  30 cols)
--   bottom   = max(20% total height, 14 rows)
local function compute_sizes()
	return {
		sidebar = math.max(math.floor(vim.o.columns * 0.25), 30),
		bottom = math.max(math.floor(vim.o.lines * 0.20), 14),
	}
end

-- (Re)initialize dap-ui with sizes derived from the current terminal dimensions.
-- Safe to call repeatedly; dapui.setup is idempotent.
local function init_dapui()
	local sz = compute_sizes()
	SIDEBAR_WIDTH = sz.sidebar
	REPL_HEIGHT = sz.bottom
	dapui.setup({
		layouts = {
			{
				-- Left sidebar: scopes, breakpoints, stacks, watches
				elements = {
					{ id = "scopes", size = 0.25 },
					{ id = "breakpoints", size = 0.25 },
					{ id = "stacks", size = 0.25 },
					{ id = "watches", size = 0.25 },
				},
				position = "left",
				size = SIDEBAR_WIDTH,
			},
			{
				-- Bottom tray: repl only (console removed — dlv dap never sends
				-- runInTerminal so it would always be empty).
				elements = {
					{ id = "repl", size = 1.0 },
				},
				position = "bottom",
				size = REPL_HEIGHT,
			},
		},
	})
end

-- Run once at module load so dapui is configured before any session starts.
init_dapui()

-- Guard against re-entrant WinResized callbacks when we programmatically set widths.
local _sidebar_guard = false

-- Forward declarations so the WinResized closure below can reference them even
-- though they are assigned later in the file (Lua captures upvalues by reference).
local _last_dlv_buf = nil
local _last_dlv_win = nil
local style_dlv_win -- assigned below
local equalize_bottom_layout -- assigned below

-- Enforce SIDEBAR_MIN_WIDTH on dap-ui sidebar windows so vsplitting the REPL (or
-- any other layout event) can never collapse the sidebar below its usable minimum.
-- When triggered, restores to the full computed SIDEBAR_WIDTH.
-- NOTE: does NOT call equalize_bottom_layout here — that would set widths while the
-- dlv window may be displaced, causing the sidebar to balloon (see equalize comment).
vim.api.nvim_create_autocmd("WinResized", {
	group = vim.api.nvim_create_augroup("dapui_sidebar_minwidth", { clear = true }),
	callback = function()
		if _sidebar_guard then
			return
		end
		_sidebar_guard = true
		vim.schedule(function()
			_sidebar_guard = false
			for _, win in ipairs(vim.api.nvim_list_wins()) do
				if not vim.api.nvim_win_is_valid(win) then
					goto continue
				end
				local buf = vim.api.nvim_win_get_buf(win)
				if DAPUI_SIDEBAR_FTS[vim.bo[buf].filetype] then
					if vim.api.nvim_win_get_width(win) < SIDEBAR_MIN_WIDTH then
						vim.api.nvim_win_set_width(win, SIDEBAR_WIDTH)
					end
				end
				::continue::
			end
		end)
	end,
})

-- Raise the adapter response timeout so slow dlv startups don't emit false warnings.
dap.defaults.fallback.request_timeout = 20000

-- Interactive Go adapter: runs dlv dap in a vsplit of the dap-ui REPL window so
-- the debuggee inherits dlv's PTY for full interactive stdin/stdout/stderr without
-- consuming extra vertical space. Use type = "go_interactive" in launch configs.

local function get_free_port()
	local server = vim.uv.new_tcp()
	server:bind("127.0.0.1", 0)
	local port = server:getsockname().port
	server:close()
	return port
end

-- Returns the window ID of the dap-ui REPL, or nil if not found.
-- Matches by filetype ("dap-repl") since the buffer is named [dap-repl-{N}]
-- where N is the buffer number — not a fixed string.
local function find_repl_win()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		if vim.bo[buf].filetype == "dap-repl" then
			return win
		end
	end
	return nil
end

-- Returns true if win_a and win_b share the same screen row (vsplit siblings).
local function same_row(a, b)
	if not (vim.api.nvim_win_is_valid(a) and vim.api.nvim_win_is_valid(b)) then
		return false
	end
	return vim.api.nvim_win_get_position(a)[1] == vim.api.nvim_win_get_position(b)[1]
end

-- Registers a WinClosed autocmd that clears _last_dlv_win when the given window closes.
local function register_dlv_winclosed(win)
	vim.api.nvim_create_autocmd("WinClosed", {
		pattern = tostring(win),
		once = true,
		callback = function()
			if _last_dlv_win == win then
				_last_dlv_win = nil
			end
		end,
	})
end

-- Applies dap-ui-matching visual options to the dlv terminal window.
-- Must be defined before equalize_bottom_layout (which can re-create the window).
style_dlv_win = function(win)
	local opts = { win = win }
	vim.api.nvim_set_option_value("number", false, opts)
	vim.api.nvim_set_option_value("relativenumber", false, opts)
	vim.api.nvim_set_option_value("signcolumn", "no", opts)
	vim.api.nvim_set_option_value("winfixwidth", true, opts)
	vim.api.nvim_set_option_value("winfixheight", true, opts)
	vim.api.nvim_set_option_value("winbar", "  dlv terminal  ", opts)
end

-- Ensures the dlv terminal window is a vsplit sibling of the REPL (same screen row).
-- If the dlv window has been displaced out of the REPL row (dap-ui layout enforcement
-- pushes it up into the editor column as a horizontal split), the old window is closed
-- and reopened as a vsplit of the REPL.
--
-- IMPORTANT: always re-create before setting widths.  Setting a width on a displaced
-- dlv window (which is in the same column group as the sidebar) causes the sidebar to
-- balloon to fill the freed horizontal space.
--
-- Width equalization uses the measured combined width of REPL + dlv (not a computed
-- formula) so it works regardless of whether the REPL is full-width or partial-width.
equalize_bottom_layout = function()
	local repl = find_repl_win()
	if not repl then
		return
	end

	-- If dlv terminal exists but is no longer beside the REPL, close it and
	-- reopen as vsplit of the REPL so we're operating on the correct topology.
	if _last_dlv_win and vim.api.nvim_win_is_valid(_last_dlv_win) then
		if not same_row(repl, _last_dlv_win) then
			local dlv_buf = vim.api.nvim_win_get_buf(_last_dlv_win)
			local old_win = _last_dlv_win
			-- Clear before closing so the WinClosed autocmd (which checks _last_dlv_win == win)
			-- sees nil and does nothing — we're about to assign the new window ourselves.
			_last_dlv_win = nil
			vim.api.nvim_win_close(old_win, true)
			local new_win = vim.api.nvim_open_win(dlv_buf, false, {
				win = repl,
				split = "right",
			})
			_last_dlv_win = new_win
			style_dlv_win(new_win)
			register_dlv_winclosed(new_win)
		end
	end

	-- Equalize widths: divide the actual combined width of REPL+dlv evenly.
	-- Using measured widths avoids assumptions about whether the bottom panel is
	-- full-width (botright) or partial-width (editor-column only).
	if _last_dlv_win and vim.api.nvim_win_is_valid(_last_dlv_win) then
		if same_row(repl, _last_dlv_win) then
			local total = vim.api.nvim_win_get_width(repl) + vim.api.nvim_win_get_width(_last_dlv_win)
			local half = math.floor(total / 2)
			vim.api.nvim_win_set_width(repl, half)
			vim.api.nvim_win_set_width(_last_dlv_win, half)
		end
	end
end

dap.adapters.go_interactive = function(callback, _config)
	local port = get_free_port()
	local host = "127.0.0.1"

	-- Ensure dap-ui is open (left sidebar + bottom repl) before we add our split.
	dapui.open()

	local orig_win = vim.api.nvim_get_current_win()

	-- Defer window creation by one event-loop tick so dap-ui's open() has time
	-- to finish creating windows (it may schedule window ops via vim.schedule).
	vim.defer_fn(function()
		-- Reuse the existing dlv terminal window if it is still open and valid.
		-- This avoids accumulating new splits on repeated debug runs.
		local term_buf
		local job_id

		if _last_dlv_win and vim.api.nvim_win_is_valid(_last_dlv_win) then
			-- Previous window still open: replace its buffer with a fresh terminal.
			vim.api.nvim_set_current_win(_last_dlv_win)
			vim.cmd("enew")
			term_buf = vim.api.nvim_get_current_buf()
		else
			-- Place the terminal as a vertical split of the REPL window so both share
			-- the same bottom-tray row — zero extra vertical space consumed.
			-- Fallback: botright horizontal split if the REPL still isn't visible.
			local repl_win = find_repl_win()
			if repl_win then
				-- nvim_open_win with split="right" creates a side-by-side window
				-- in the same row as repl_win, regardless of splitright/splitbelow
				-- options or winfixwidth on the REPL. The new window is made current.
				_last_dlv_win = vim.api.nvim_open_win(0, true, {
					win = repl_win,
					split = "right",
				})
			else
				vim.notify(
					"go_interactive: REPL window not found — using botright fallback",
					vim.log.levels.WARN
				)
				vim.cmd("botright 12split")
				_last_dlv_win = vim.api.nvim_get_current_win()
			end
			vim.cmd("enew")
			term_buf = vim.api.nvim_get_current_buf()

			style_dlv_win(_last_dlv_win)

			-- After the vsplit, restore sidebar and equalize REPL/dlv widths.
			vim.schedule(equalize_bottom_layout)

			-- When this window closes, clear the ref so the next run creates a fresh
			-- vsplit rather than trying to reuse a potentially-orphaned window.
			register_dlv_winclosed(_last_dlv_win)
		end

		-- Start dlv dap inside the split. The debuggee inherits dlv's PTY so all
		-- interactive stdin/stdout/stderr is visible here.
		--
		-- DO NOT pass on_stdout: termopen feeds PTY bytes to on_stdout *instead of*
		-- the terminal renderer, leaving the buffer blank.
		--
		-- DO NOT TCP-probe dlv: dlv dap exits with code 0 when any TCP client connects
		-- and closes without sending DAP messages (--accept-multiclient does not apply
		-- to dlv dap mode). Readiness is detected by polling buffer text instead.
		--
		-- on_exit IS supported by termopen (unlike on_stdout/on_stderr).
		job_id = vim.fn.termopen(
			{ "dlv", "dap", "--listen=" .. host .. ":" .. tostring(port) },
			{
				cwd = vim.fn.getcwd(),
				on_exit = function(_, exit_code)
					vim.schedule(function()
						-- Only act on the most recent dlv run.
						if _last_dlv_buf ~= term_buf then
							return
						end
						vim.notify(
							string.format(
								"go_interactive: dlv exited (code %d) — output preserved",
								exit_code
							),
							vim.log.levels.INFO
						)
					end)
				end,
			}
		)

		_last_dlv_buf = term_buf

		-- Return focus to whichever window was current before we opened the split.
		vim.api.nvim_set_current_win(orig_win)

		if not job_id or job_id <= 0 then
			vim.notify(
				string.format(
					"go_interactive: failed to start dlv (termopen returned %s)",
					tostring(job_id)
				),
				vim.log.levels.ERROR
			)
			return
		end

		vim.notify(
			string.format("go_interactive: dlv started (job %d) on %s:%d, waiting …", job_id, host, port),
			vim.log.levels.INFO
		)

		-- Poll the terminal buffer's rendered lines for dlv's ready message every 300ms.
		-- No TCP connection is made until nvim-dap's real connect below.
		local done = false
		local checks = 0
		local function check_ready()
			if done then
				return
			end
			checks = checks + 1
			if checks > 65 then -- ~20 seconds
				vim.notify(
					string.format("go_interactive: timed out waiting for dlv on %s:%d", host, port),
					vim.log.levels.ERROR
				)
				return
			end
			if not vim.api.nvim_buf_is_valid(term_buf) then
				vim.notify("go_interactive: dlv terminal buffer closed unexpectedly", vim.log.levels.ERROR)
				return
			end
			local lines = vim.api.nvim_buf_get_lines(term_buf, 0, -1, false)
			for _, line in ipairs(lines) do
				if line:match("DAP server listening") then
					done = true
					vim.notify(
						string.format(
							"go_interactive: dlv ready on %s:%d (check %d)",
							host,
							port,
							checks
						),
						vim.log.levels.INFO
					)
					callback({ type = "server", host = host, port = port })
					return
				end
			end
			vim.defer_fn(check_ready, 300)
		end
		vim.defer_fn(check_ready, 300)
	end, 50)
end

-- Only call init_dapui() (which runs dapui.setup() and closes all layouts)
-- when dap-ui is not already open. Closing layouts while the dlv vsplit
-- exists displaces the dlv window, causing equalize to corrupt the sidebar.
local function on_session_start()
	if not find_repl_win() then
		init_dapui()
	end
	dapui.open()
end
dap.listeners.before.attach.dapui_config = on_session_start
dap.listeners.before.launch.dapui_config = on_session_start

-- Clear the cached dlv buffer ref when a session ends.
-- _last_dlv_win is cleared by the WinClosed autocmd when the user closes the window;
-- it is intentionally NOT cleared here so the window persists showing dlv output.
-- The next go_interactive run will reuse it (enew replaces its buffer).
local function on_session_end()
	_last_dlv_buf = nil
end
dap.listeners.after.event_terminated.go_interactive_cleanup = on_session_end
dap.listeners.after.event_exited.go_interactive_cleanup = on_session_end

-- When dlv connects and sends `initialized`, dap-ui fires its own listener which
-- calls open() and enforces its managed layout, displacing our unmanaged vsplit.
-- Re-equalize after a short delay to put everything back in place.
-- Also hook event_stopped (fires on every breakpoint hit) for the same reason.
local function on_dap_event_layout()
	if _last_dlv_win and vim.api.nvim_win_is_valid(_last_dlv_win) then
		vim.defer_fn(equalize_bottom_layout, 150)
	end
end
dap.listeners.after.event_initialized.go_interactive_layout = on_dap_event_layout
dap.listeners.after.event_stopped.go_interactive_layout = on_dap_event_layout

-- Divides sidebar element windows into equal heights after a VimResized reset.
-- dap-ui's resize() computes round(0.25 × distorted_total) using heights measured
-- BEFORE resize, so the first (topmost) element ends up squished. We fix this by
-- re-measuring the actual post-reset total and forcing equal heights directly.
-- Set from bottom to top so Neovim gives any remainder row to the topmost element
-- rather than the bottommost one.
local function equalize_sidebar_elements()
	local wins = {}
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_is_valid(win) then
			local ft = vim.bo[vim.api.nvim_win_get_buf(win)].filetype
			if DAPUI_SIDEBAR_FTS[ft] then
				table.insert(wins, win)
			end
		end
	end
	if #wins < 2 then
		return
	end
	-- Sort top to bottom so we can iterate in reverse.
	table.sort(wins, function(a, b)
		return vim.api.nvim_win_get_position(a)[1] < vim.api.nvim_win_get_position(b)[1]
	end)
	local total = 0
	for _, w in ipairs(wins) do
		total = total + vim.api.nvim_win_get_height(w)
	end
	local per = math.floor(total / #wins)
	-- Iterate bottom-to-top: each set takes space from the window above, so the
	-- topmost element ends up with total - (n-1)*per (absorbs any remainder).
	for i = #wins, 1, -1 do
		vim.api.nvim_win_set_height(wins[i], per)
	end
end

-- When the Neovim window is resized (zellij pane resize, fullscreen toggle, etc.)
-- recompute layout sizes and restore the dap-ui arrangement so the debug UI
-- stays usable at the new terminal dimensions.
vim.api.nvim_create_autocmd("VimResized", {
	group = vim.api.nvim_create_augroup("dapui_vimresized", { clear = true }),
	callback = function()
		-- Only act when dap-ui is open (REPL visible).
		if not find_repl_win() then
			return
		end
		-- Recompute sizes for the new terminal dimensions.
		local sz = compute_sizes()
		SIDEBAR_WIDTH = sz.sidebar
		REPL_HEIGHT = sz.bottom
		vim.schedule(function()
			-- dapui.open({ reset = true }) resets all element proportions to their
			-- configured init_size values (0.25 each for sidebar), restores sidebar
			-- width to SIDEBAR_WIDTH, and restores the REPL height if it was collapsed.
			dapui.open({ reset = true })
			-- Force REPL to the freshly computed height (reset may have used old init).
			local repl = find_repl_win()
			if repl then
				vim.api.nvim_win_set_height(repl, REPL_HEIGHT)
			end
			-- dap-ui's reset uses distorted pre-resize totals, leaving the topmost
			-- sidebar element squished. Re-equalize element heights explicitly.
			equalize_sidebar_elements()
			-- Re-equalize and re-position the dlv terminal window.
			if _last_dlv_win then
				vim.defer_fn(equalize_bottom_layout, 50)
			end
		end)
	end,
})

-- Load project-local dap config after all adapters and global configs are set up.
-- This lets project configs safely reference dap.configurations.go and custom adapters.
local project_dap = vim.fn.getcwd() .. "/.nvim/dap.lua"
if vim.fn.filereadable(project_dap) == 1 then
	dofile(project_dap)
end
