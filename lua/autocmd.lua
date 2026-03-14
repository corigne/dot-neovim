-- Autocommands and Similar

-- Disable netrw and hijack directory opens with Telescope
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Clear netrw autocommands to prevent conflicts
vim.api.nvim_create_augroup("FileExplorer", { clear = true })

-- Open Telescope find_files when a directory is opened
vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("telescope_hijack_netrw", { clear = true }),
	pattern = "*",
	callback = function()
		local args = vim.fn.argv()
		if #args == 0 then
			return
		end

		local target = args[1]
		if vim.fn.isdirectory(target) == 0 then
			return
		end

		local telescope_ok = pcall(require, "telescope.builtin")
		if telescope_ok then
			vim.defer_fn(function()
				require("telescope.builtin").find_files({ cwd = target })
			end, 10)
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
