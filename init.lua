local config = require("helpers.config")

local modules = {
	core = { "plugins", "autocmd", "core", "keymap" },
	optional = {
		{
			modules = { "dap-config" },
			condition = not vim.g.vscode,
		},
	},
}

config.load_modules(modules)
