-- Autocommands and Similar

-- Disable netrw so snacks can hijack directory opens
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Clear netrw autocommands to prevent conflicts
vim.api.nvim_create_augroup("FileExplorer", { clear = true })

-- Open Snacks smart picker when a directory is opened, rooted at project root
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("snacks_hijack_netrw", { clear = true }),
	callback = function(ev)
		local path = ev.file
		if path == "" or vim.fn.isdirectory(path) == 0 then
			return
		end
		local buf = ev.buf
		local cwd = Snacks.git.get_root(path) or vim.fn.getcwd()
		if vim.v.vim_did_enter == 0 then
			-- startup: clear bufname so nvim doesn't try to load it again,
			-- then open picker on UIEnter when the UI is ready
			vim.api.nvim_buf_set_name(buf, "")
			vim.api.nvim_create_autocmd("UIEnter", {
				once = true,
				group = vim.api.nvim_create_augroup("snacks_hijack_netrw_enter", { clear = true }),
				callback = function()
					Snacks.picker.smart({ cwd = cwd })
				end,
			})
		else
			-- mid-session: delete the directory buffer, then open picker
			Snacks.bufdelete.delete(buf)
			Snacks.picker.smart({ cwd = cwd })
		end
	end,
})

-- Autoformat on save
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp_autoformat", { clear = true }),
	callback = function(args)
		local filetype = vim.bo[args.buf].filetype
		if not vim.g.autoformat_enabled or not vim.g.autoformat_filetypes[filetype] then
			return
		end
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = args.buf,
			callback = function()
				-- Get all attached clients for this buffer
				local clients = vim.lsp.get_clients({ bufnr = args.buf })
				if #clients == 0 then
					return
				end

				local formatter = vim.g.formatters[filetype]
				if formatter then
					formatter()
				else
					-- Default: use LSP formatting, preferring native formatters over null-ls
					vim.lsp.buf.format({
						async = false,
						filter = function(client)
							-- Skip null-ls if other formatters are available
							if client.name == "null-ls" then
								local has_other = false
								for _, c in ipairs(clients) do
									if c.name ~= "null-ls" and c:supports_method("textDocument/formatting") then
										has_other = true
										break
									end
								end
								return not has_other
							end
							return true
						end,
					})
				end
			end,
		})
	end,
})
