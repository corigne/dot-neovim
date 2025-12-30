-- PLUGIN SETTINGS
-- Installs lazy.nvim if it isn't installed already.
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader      = ' '
vim.g.maplocalleader = ' '

require('lazy').setup({

	-- Color Schemes, can be set to one of these in core.lua
	{
		'catppuccin/nvim',
		name = 'catppuccin',
		priority = 1000,
		opts =
		{
			flavour = 'frappe', -- latte, frappe, macchiato, mocha
			background = {      -- :h background
				light = 'latte',
				dark = 'frappe',
			},
			transparent_background = false, -- disables setting the background color.
			show_end_of_buffer = true,      -- shows the '~' characters after the end of buffers
			dim_inactive = {
				enabled = false,            -- dims the background color of inactive window
				shade = 'dark',
				percentage = 0.15,          -- percentage of the shade to apply to the inactive window
			},
			integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
				notify = false,
				mini = {
					enabled = true,
					indentscope_color = '',
				},
			},
		}
	},

	-- Icons and Cursor
	{
		'nvim-tree/nvim-web-devicons',
	},
	{
		'lewis6991/gitsigns.nvim', -- used for GIT status for barbar
		opts = {}
	},
	{
		"sphamba/smear-cursor.nvim",
		opts = {},
	},

	-- Window and Workflow Improvements
	{
		'kylechui/nvim-surround',
		version = '*', -- Use for stability; omit to use `main` branch for the latest features
		event = 'VeryLazy',
		opts = {}
	},
	{
		'folke/todo-comments.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		opts = {}
	},
	{
		'kdheepak/lazygit.nvim',
		-- optional for floating window border decoration
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
	},
	{ 'alexghergh/nvim-tmux-navigation' },
	-- 'andweeb/presence.nvim',
	{
		'vyfor/cord.nvim',
		build = ':Cord update',
		opts = {
			display = {
				theme = 'catppuccin',
				flavor = 'dark',
				swap_fields = false,
				swap_icons = false,
			},
		}
	},
	{
		'gelguy/wilder.nvim',
		cond = not vim.g.vscode,
		opts = { modes = { ':', '/', '?' } },
	},
	{
		'vlime/vlime',
		config = function()
			rtp = 'vim/'
		end
	},
	-- Status line (bottom)
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		cond = not vim.g.vscode,
		opts = {}
	},
	{
		'tiagovla/scope.nvim',
		opts = {}
	},
	'nvim-lua/plenary.nvim',
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function(telescope, opts)
			telescope = require('telescope')
			opts = {
				defaults = {
					-- Default configuration for telescope goes here:
					-- config_key = value,
					mappings = {
						i = {
							-- map actions.which_key to <C-h> (default: <C-/>)
							-- actions.which_key shows the mappings for your picker,
							-- e.g. git_{create, delete, ...}_branch for the git_branches picker
							['<C-h>'] = 'which_key'
						}
					}
				},
				pickers = {
					-- Default configuration for builtin pickers goes here:
					-- picker_name = {
						--   picker_config_key = value,
						--   ...
						-- }
						-- Now the picker_config_key will be applied every time you call this
						-- builtin picker
					},
					extensions = {
						-- Your extension configuration goes here:
						file_browser = {
							-- theme = 'ivy',
							-- disables netrw and use telescope-file-browser in its place
							hijack_netrw = true,
							mappings = {
								['i'] = {
									-- your custom insert mode mappings
								},
								['n'] = {
									-- your custom normal mode mappings
								},
							},
							respect_gitignore = false,
						},
						-- extension_name = {
							--   extension_config_key = value,
							-- }
							-- please take a look at the readme of the extension you want to configure
						}
					}
					telescope.setup(opts)
					telescope.load_extension('scope')
					telescope.load_extension('file_browser')
				end
			},
			{
				'nvim-telescope/telescope-file-browser.nvim',
				dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
			},

			-- LSP, Folds, Debugging, and LINT
			{
				"saghen/blink.cmp",
				optional = true,
				dependencies = {
					"rafamadriz/friendly-snippets",
					"fang2hou/blink-copilot",
				},
				version = "1.*",
				---@type blink.cmp.Config
				opts = {
					sources = {
						default = { "lsp", "copilot", "path", "snippets", "buffer" },
						providers = {
							copilot = {
								name = "copilot",
								module = "blink-copilot",
								score_offset = 100,
								async = true,
							},
						},
					},
					keymap = { preset = 'super-tab' },
					completion = {
						accept = {
							auto_brackets = {
								enabled = true,
							},
						},
						documentation = {
							auto_show = true,
							auto_show_delay_ms = 200,
							window = { border = "rounded", },
						},
						ghost_text = {
							enabled = true,
						},
						menu = {
							auto_show = true,
							draw = {
								treesitter = { "lsp", },
							},
						},
						trigger = {
							prefetch_on_insert = true,
							show_on_blocked_trigger_characters = {},
						},
					},
				},
				opts_extend = { "sources.default" },
			},
			{
				'neovim/nvim-lspconfig',
				dependencies = { 'saghen/blink.cmp' },
			},
			{
				'mason-org/mason.nvim',
				build = ':MasonUpdate',
				opts = {}
			},
			{
				'mason-org/mason-lspconfig.nvim',
				opts = {
					automatic_installation = true,
				},
				dependencies = { 'mason-org/mason.nvim', 'nvim-lspconfig' },
				config = function()
					local capabilities = require("blink.cmp").get_lsp_capabilities()
					require("mason-lspconfig").setup({
						ensure_installed = { "gopls", "lua_ls" },
						automatic_installation = true,
						handlers = {
							function(server_name)
								require("lspconfig")[server_name].setup({ capabilities = capabilities })
							end,
						},
					})
				end,
			},
			{
				"nvimtools/none-ls.nvim"
			},
			{
				'mfussenegger/nvim-jdtls'
			},
			{
				'jay-babu/mason-null-ls.nvim',
				opts = {}
			},
			{
				'mfussenegger/nvim-dap',
				dependencies = {
					{
						"rcarriga/nvim-dap-ui",
						"nvim-neotest/nvim-nio",
						"jay-babu/mason-nvim-dap.nvim",
						"theHamsta/nvim-dap-virtual-text",
					}
				}, -- TODO Keybindings required.
			},
			{
				'leoluz/nvim-dap-go'
			},
			{
				'jay-babu/mason-nvim-dap.nvim',
				opts = {
					automatic_installation = true,
					ensure_installed = { 'codelldb', 'delve', 'python' },
					handlers = {
						function(config)
							-- all sources with no handler get passed here

							-- Keep original functionality
							require('mason-nvim-dap').default_setup(config)
						end,
					},
				},
			},
			{
				'ray-x/go.nvim',
				dependencies = { -- optional packages
					'ray-x/guihua.lua',
					'neovim/nvim-lspconfig',
					'nvim-treesitter/nvim-treesitter',
				},
				opts = {},
				event = { 'CmdlineEnter' },
				ft = { 'go', 'gomod' },
				build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
			},
			{
				"kevinhwang91/nvim-ufo",
				dependencies = "kevinhwang91/promise-async",
				opts = {
					provider_selector = function(bufnr, filetype, buftype)
						return { 'treesitter', 'indent' }
					end
				},
				config = function()
					local capabilities = vim.lsp.protocol.make_client_capabilities()
					capabilities.textDocument.foldingRange = {
						dynamicRegistration = false,
						lineFoldingOnly = true
					}
					local language_servers = vim.lsp.get_clients() -- or list servers manually like {'gopls', 'clangd'}
					for _, ls in ipairs(language_servers) do
						require('lspconfig')[ls].setup({
							capabilities = capabilities
							-- you can add other fields for setting up lsp server in this table
						})
					end
					require('ufo').setup()
				end
			},
			-- Autocompletion Engine and Extensions
			{
				'akinsho/toggleterm.nvim',
				version = "*",
				opts = {
					shell = vim.g.os == "Windows" and "powershell" or vim.o.shell,
					direction = 'float',
					border = 'double'
				}
			},
			{
				'simrat39/rust-tools.nvim',
				cond = not vim.g.vscode
			},

			'rafamadriz/friendly-snippets',
			{
				'L3MON4D3/LuaSnip',
				-- follow latest release.
				version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
				-- install jsregexp (optional!).
				build = 'make install_jsregexp',
				dependencies = { 'rafamadriz/friendly-snippets' },
			},
			{
				'folke/neodev.nvim',
				opts = {},
			},
			{
				"folke/snacks.nvim",
				priority = 1000,
				lazy = false,
				---@type snacks.Config
				opts = {
					bigfile = { enabled = true },
					dashboard = { enabled = true },
					explorer = { enabled = false },
					indent = { enabled = true },
					input = { enabled = true },
					notifier = {
						enabled = true,
						timeout = 3000,
					},
					picker = { enabled = true },
					quickfile = { enabled = true },
					scope = { enabled = true },
					scroll = { enabled = true },
					statuscolumn = { enabled = true },
					words = { enabled = true },
					styles = {
						notification = {
							-- wo = { wrap = true } -- Wrap notifications
						}
					}
				},
				keys = {
					-- Top Pickers & Explorer
					{ "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
					{ "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
					{ "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
					{ "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "Command History" },
					{ "<leader>n",       function() Snacks.picker.notifications() end,                           desc = "Notification History" },
					{ "<leader>e",       function() Snacks.explorer() end,                                       desc = "File Explorer" },
					-- find
					{ "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
					{ "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
					{ "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
					{ "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
					{ "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
					{ "<leader>fr",      function() Snacks.picker.recent() end,                                  desc = "Recent" },
					-- git
					{ "<leader>gb",      function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
					{ "<leader>gl",      function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
					{ "<leader>gL",      function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
					{ "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "Git Status" },
					{ "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
					{ "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
					{ "<leader>gf",      function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
					-- gh
					{ "<leader>gi",      function() Snacks.picker.gh_issue() end,                                desc = "GitHub Issues (open)" },
					{ "<leader>gI",      function() Snacks.picker.gh_issue({ state = "all" }) end,               desc = "GitHub Issues (all)" },
					{ "<leader>gp",      function() Snacks.picker.gh_pr() end,                                   desc = "GitHub Pull Requests (open)" },
					{ "<leader>gP",      function() Snacks.picker.gh_pr({ state = "all" }) end,                  desc = "GitHub Pull Requests (all)" },
					-- Grep
					{ "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
					{ "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
					{ "<leader>sg",      function() Snacks.picker.grep() end,                                    desc = "Grep" },
					{ "<leader>sw",      function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word",   mode = { "n", "x" } },
					-- search
					{ '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "Registers" },
					{ '<leader>s/',      function() Snacks.picker.search_history() end,                          desc = "Search History" },
					{ "<leader>sa",      function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
					{ "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
					{ "<leader>sc",      function() Snacks.picker.command_history() end,                         desc = "Command History" },
					{ "<leader>sC",      function() Snacks.picker.commands() end,                                desc = "Commands" },
					{ "<leader>sd",      function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
					{ "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
					{ "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "Help Pages" },
					{ "<leader>sH",      function() Snacks.picker.highlights() end,                              desc = "Highlights" },
					{ "<leader>si",      function() Snacks.picker.icons() end,                                   desc = "Icons" },
					{ "<leader>sj",      function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
					{ "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
					{ "<leader>sl",      function() Snacks.picker.loclist() end,                                 desc = "Location List" },
					{ "<leader>sm",      function() Snacks.picker.marks() end,                                   desc = "Marks" },
					{ "<leader>sM",      function() Snacks.picker.man() end,                                     desc = "Man Pages" },
					{ "<leader>sp",      function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
					{ "<leader>sq",      function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
					{ "<leader>sR",      function() Snacks.picker.resume() end,                                  desc = "Resume" },
					{ "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "Undo History" },
					{ "<leader>uC",      function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
					-- LSP
					{ "gd",              function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
					{ "gD",              function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
					{ "gr",              function() Snacks.picker.lsp_references() end,                          nowait = true,                       desc = "References" },
					{ "gI",              function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
					{ "gy",              function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
					{ "gai",             function() Snacks.picker.lsp_incoming_calls() end,                      desc = "C[a]lls Incoming" },
					{ "gao",             function() Snacks.picker.lsp_outgoing_calls() end,                      desc = "C[a]lls Outgoing" },
					{ "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
					{ "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
					-- Other
					{ "<leader>z",       function() Snacks.zen() end,                                            desc = "Toggle Zen Mode" },
					{ "<leader>Z",       function() Snacks.zen.zoom() end,                                       desc = "Toggle Zoom" },
					{ "<leader>.",       function() Snacks.scratch() end,                                        desc = "Toggle Scratch Buffer" },
					{ "<leader>S",       function() Snacks.scratch.select() end,                                 desc = "Select Scratch Buffer" },
					{ "<leader>n",       function() Snacks.notifier.show_history() end,                          desc = "Notification History" },
					{ "<leader>bd",      function() Snacks.bufdelete() end,                                      desc = "Delete Buffer" },
					{ "<leader>cR",      function() Snacks.rename.rename_file() end,                             desc = "Rename File" },
					{ "<leader>gB",      function() Snacks.gitbrowse() end,                                      desc = "Git Browse",                 mode = { "n", "v" } },
					{ "<leader>gg",      function() Snacks.lazygit() end,                                        desc = "Lazygit" },
					{ "<leader>un",      function() Snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications" },
					{ "<c-/>",           function() Snacks.terminal() end,                                       desc = "Toggle Terminal" },
					{ "<c-_>",           function() Snacks.terminal() end,                                       desc = "which_key_ignore" },
					{ "]]",              function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",             mode = { "n", "t" } },
					{ "[[",              function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",             mode = { "n", "t" } },
					{
						"<leader>N",
						desc = "Neovim News",
						function()
							Snacks.win({
								file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
								width = 0.6,
								height = 0.6,
								wo = {
									spell = false,
									wrap = false,
									signcolumn = "yes",
									statuscolumn = " ",
									conceallevel = 3,
								},
							})
						end,
					}
				},
				init = function()
					vim.api.nvim_create_autocmd("User", {
						pattern = "VeryLazy",
						callback = function()
							-- Setup some globals for debugging (lazy-loaded)
							_G.dd = function(...)
								Snacks.debug.inspect(...)
							end
							_G.bt = function()
								Snacks.debug.backtrace()
							end

							-- Override print to use snacks for `:=` command
							if vim.fn.has("nvim-0.11") == 1 then
								vim._print = function(_, ...)
									dd(...)
								end
							else
								vim.print = _G.dd
							end

							-- Create some toggle mappings
							Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
							Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
							Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
							Snacks.toggle.diagnostics():map("<leader>ud")
							Snacks.toggle.line_number():map("<leader>ul")
							Snacks.toggle.option("conceallevel",
							{ off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
							Snacks.toggle.treesitter():map("<leader>uT")
							Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(
								"<leader>ub")
								Snacks.toggle.inlay_hints():map("<leader>uh")
								Snacks.toggle.indent():map("<leader>ug")
								Snacks.toggle.dim():map("<leader>uD")
							end,
						})
					end,
				},
				{
					"zbirenbaum/copilot.lua",
					cmd = "Copilot",
					event = "InsertEnter",
					opts = {
						suggestion = { enabled = false },
						panel = { enabled = false },
						filetypes = {
							markdown = true,
							help = true,
						},
					},
				},
				{
					"CopilotC-Nvim/CopilotChat.nvim",
					dependencies = {
						{ "nvim-lua/plenary.nvim", branch = "master" },
					},
					build = "make tiktoken",
					opts = {
						model = 'gpt-4.1',
						temperature = 0.1,           -- Lower = focused, higher = creative
						window = {
							-- layout = 'float',
							-- border = 'rounded', -- 'single', 'double', 'rounded', 'solid'
							title = '🤖 Copilot Chat',
							width = 0.33, -- Fixed width in columns
							zindex = 100, -- Ensure window stays on top
						},
						auto_insert_mode = true,     -- Enter insert mode when opening
					}
				},
				{
					'danymat/neogen', opts = {}
				},
				{
					'saghen/blink.pairs',
					version = '*', -- (recommended) only required with prebuilt binaries

					-- download prebuilt binaries from github releases
					dependencies = 'saghen/blink.download',
					-- OR build from source, requires nightly:
					-- https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
					-- build = 'cargo build --release',
					-- If you use nix, you can build from source using latest nightly rust with:
					-- build = 'nix run .#build-plugin',

					--- @module 'blink.pairs'
					--- @type blink.pairs.Config
					opts = {
						mappings = {
							-- you can call require("blink.pairs.mappings").enable()
							-- and require("blink.pairs.mappings").disable()
							-- to enable/disable mappings at runtime
							enabled = true,
							cmdline = true,
							-- or disable with `vim.g.pairs = false` (global) and `vim.b.pairs = false` (per-buffer)
							-- and/or with `vim.g.blink_pairs = false` and `vim.b.blink_pairs = false`
							disabled_filetypes = {},
							-- see the defaults:
							-- https://github.com/Saghen/blink.pairs/blob/main/lua/blink/pairs/config/mappings.lua#L14
							pairs = {},
						},
						highlights = {
							enabled = true,
							-- requires require('vim._extui').enable({}), otherwise has no effect
							cmdline = true,
							groups = {
								'BlinkPairsOrange',
								'BlinkPairsPurple',
								'BlinkPairsBlue',
							},
							unmatched_group = 'BlinkPairsUnmatched',

							-- highlights matching pairs under the cursor
							matchparen = {
								enabled = true,
								-- known issue where typing won't update matchparen highlight, disabled by default
								cmdline = false,
								-- also include pairs not on top of the cursor, but surrounding the cursor
								include_surrounding = false,
								group = 'BlinkPairsMatchParen',
								priority = 250,
							},
						},
						debug = false,
					}
				},
				{
					'saghen/blink.indent',
					--- @module 'blink.indent'
					--- @type blink.indent.Config
					-- opts = {},
				},
				-- clipboard (dependencies an osc52 compliant terminal emulator)
				{
					'ojroques/nvim-osc52',
					cond = not vim.g.vscode
				},
				-- org mode
				{
					'nvim-orgmode/orgmode',
					event = 'VeryLazy',
					ft = { 'org' },
					opts = {
						org_agenda_files = '~/orgfiles/**/*',
						org_default_notes_file = '~/orgfiles/refile.org',
					}
				},
				-- comments, whitespace, and highlighting (ts)
				{
					'numToStr/Comment.nvim',
					opts = {
						-- add any options here
					}
				},
				'mcauley-penney/tidy.nvim',
				'tpope/vim-sleuth',
				{
					'nvim-treesitter/nvim-treesitter',
					branch = 'main',
					lazy = false,
					build = ':TSUpdate',
					opts = {
						-- A list of parser names, or 'all' (the five listed parsers should always be installed)
						ensure_installed = {
							'bash',
							'c',
							'cpp',
							'c_sharp',
							'comment',
							'jsdoc',
							'html',
							'hlsl',
							'glsl',
							'go',
							'javascript',
							'json',
							'lua',
							'luadoc',
							'luap',
							'markdown',
							'markdown_inline',
							'python',
							'query',
							'regex',
							'rust',
							'svelte',
							'tsx',
							'typescript',
							'vim',
							'vimdoc',
							'yaml',
						},
					},
				},
				{
					'nvim-treesitter/nvim-treesitter-textobjects',
					branch = 'main',
					dependencies = { 'nvim-treesitter/nvim-treesitter' },
				},
				'yaocccc/nvim-hlchunk',
				{
					'brenoprata10/nvim-highlight-colors', -- highlight color in css files
					opts = {
						---Render style
						---@usage 'background'|'foreground'|'virtual'
						render = 'background',

						---Set virtual symbol (requires render to be set to 'virtual')
						virtual_symbol = '■',

						---Highlight named colors, e.g. 'green'
						enable_named_colors = true,

						---Highlight tailwind colors, e.g. 'bg-blue-500'
						enable_tailwind = true,

						---Set custom colors
						---Label must be properly escaped with '%' to adhere to `string.gmatch`
						--- :help string.gmatch
						custom_colors = {
						}
					},
				}
			})
