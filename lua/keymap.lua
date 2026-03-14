-- km SETTINGS

local km = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ==================
-- KEYMAPS AVAILABLE IN BOTH NEOVIM AND VSCODE
-- ==================

-- Clear Search HL
km("n", "<leader>\\", ":nohl<CR><C-l>", { silent = true })

-- Buffers
km("n", "<leader>q", ":bdelete<CR>", { noremap = true, silent = true })

-- Clipboard
km("n", "<leader>yy", "<leader>y_", { remap = true })

-- Autoformat toggle
km("n", "<leader>af", function()
	vim.g.autoformat_enabled = not vim.g.autoformat_enabled
	local status = vim.g.autoformat_enabled and "enabled" or "disabled"
	vim.notify("Autoformat " .. status)
end, opts)

-- Autoformat toggle for buffer (tidy)
if vim.g.os ~= "Windows" then
	local toggle_tidy = require("tidy").toggle
	km("n", "<leader>te", toggle_tidy, {})
end

-- Git blame toggle
km("n", "<leader>gb", ":GitBlameToggle", {})

-- neogen - Documentation generation
local neogen = require("neogen")
km("n", "<leader>ng", neogen.generate, opts)

-- ==================
-- NEOVIM-ONLY KEYMAPS (Disabled in VSCode)
-- ==================

if not vim.g.vscode then
	-- ==================
	-- Clipboard (OSC52)
	km("n", "<leader>y", require("osc52").copy_operator, { expr = true })
	km("v", "<leader>y", require("osc52").copy_visual)

	-- ==================
	-- Folding (ufo)
	km("n", "zR", require("ufo").openAllFolds)
	km("n", "zM", require("ufo").closeAllFolds)
	km("n", "zr", require("ufo").openFoldsExceptKinds)
	km("n", "zm", require("ufo").closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)

	-- ==================
	-- Telescope
	local telescope_builtin = require("telescope.builtin")

	km("n", "<leader>tb", telescope_builtin.buffers, {})
	km("n", "<leader>tf", ":Telescope file_browser<CR>", {})
	km("n", "<leader>ff", telescope_builtin.find_files, {})
	km("n", "<leader>fg", telescope_builtin.live_grep, {})
	km("n", "<leader>fr", telescope_builtin.lsp_references, {})
	km("n", "<leader>fi", telescope_builtin.lsp_implementations, {})
	km("n", "<leader>fd", telescope_builtin.lsp_definitions, {})
	km("n", "<leader>ft", telescope_builtin.lsp_type_definitions, {})
	km("n", "<leader>fh", telescope_builtin.help_tags, {})
	km("n", "<leader>gc", telescope_builtin.git_commits, {})
	km("n", "<leader>lo", "<cmd>Telescope lsp_document_symbols<CR>", opts)

	-- ==================
	-- Snacks
	local snacks = require("snacks")

	-- ==================
	-- Trouble
	km("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", {})
	km("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", {})
	km("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", {})
	km("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", {})
	km("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", {})
	km("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", {})

	-- ==================
	-- DAP (Debugging)
	local dap = require("dap")
	local dap_ui = require("dapui")

	km("n", "<leader>dd", dap_ui.toggle, opts)
	km("n", "<leader>b", ":DapToggleBreakpoint<CR>", opts)
	km("n", "<leader>db", ":DapToggleBreakpoint<CR>", opts)
	km("n", "<leader>dbc", ":DapClearBreakpoints<CR>", opts)
	km("n", "<leader>dc", ":DapContinue<CR>", opts)
	km("n", "<F5>", ":DapContinue<CR>", opts)
	km("n", "<leader>ds", ":DapStepOver<CR>", opts)
	km("n", "<F10>", ":DapStepOver<CR>", opts)
	km("n", "<leader>di", ":DapStepInto<CR>", opts)
	km("n", "<F11>", ":DapStepInto<CR>", opts)
	km("n", "<leader>do", ":DapStepOut<CR>", opts)
	km("n", "<F12>", ":DapStepOut<CR>", opts)
	km("n", "<leader>dS", ":DapStop<CR>", opts)
	km("n", "<leader>dr", dap.repl.toggle, opts)
	km("n", "<leader>dl", dap.run_last, opts)

	-- ==================
	-- CopilotChat
	km("n", "<leader>cc", ":CopilotChatToggle<CR>", opts)
	km("n", "<leader>cr", ":CopilotChatReset<CR>", opts)
	km("n", "<leader>cl", ":CopilotChatLoad<CR>", opts)
	km("n", "<leader>cs", ":CopilotChatSave<CR>", opts)
	km("n", "<leader>cS", ":CopilotChatStop<CR>", opts)
	km("n", "<leader>cm", ":CopilotChatModels<CR>", opts)
	-- ==================
	-- Native LSP Keybindings

	-- Code action
	km({ "n", "v" }, "<leader>ca", function()
		vim.lsp.buf.code_action()
	end)

	-- Rename all occurrences of the hovered word for the entire file
	km("n", "<leader>re", function()
		vim.lsp.buf.rename()
	end)

	-- Go to definition
	km("n", "gd", function()
		vim.lsp.buf.definition()
	end)

	-- Go to type definition
	km("n", "gt", function()
		vim.lsp.buf.type_definition()
	end)

	-- Show line diagnostics (float)
	km("n", "<leader>sd", function()
		vim.diagnostic.open_float()
	end)

	-- Show cursor diagnostics (float)
	km("n", "<leader>sdc", function()
		vim.diagnostic.open_float()
	end)

	-- Diagnostic jump
	km("n", "]d", function()
		vim.diagnostic.goto_next()
	end)
	km("n", "[d", function()
		vim.diagnostic.goto_prev()
	end)

	-- Hover Doc
	km("n", "K", function()
		vim.lsp.buf.hover()
	end)

	-- ==================
	-- ToggleTerm (Floating terminal)
	km({ "n", "t" }, "<D-d>", "<cmd>exe v:count1 . 'ToggleTerm'<CR>")
	km({ "n", "t" }, "<M-d>", "<cmd>exe v:count1 . 'ToggleTerm'<CR>")

	function SetTerminalkms()
		local termopts = { buffer = 0 }
		km("t", "<esc>", [[<C-\><C-n>]], termopts)
		km("t", "<C-h>", [[<Cmd>wincmd h<CR>]], termopts)
		km("t", "<C-j>", [[<Cmd>wincmd j<CR>]], termopts)
		km("t", "<C-k>", [[<Cmd>wincmd k<CR>]], termopts)
		km("t", "<C-l>", [[<Cmd>wincmd l<CR>]], termopts)
		km("t", "<C-w>", [[<C-\><C-n><C-w>]], termopts)
	end

	vim.cmd("autocmd! TermOpen term://* lua SetTerminalkms()")
end
