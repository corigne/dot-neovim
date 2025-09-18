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
    {
        'rebelot/kanagawa.nvim',
    },
    {
        'dracula/vim',
    },
    {
        'ayu-theme/ayu-vim',
    },
    {
        'folke/tokyonight.nvim',
    },
    {
        'sainnhe/everforest',
    },
    {
        'nvim-tree/nvim-web-devicons',
    },

    -- Icons and Cursor
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
        'nvim-telescope/telescope-file-browser.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
    },
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
        tag = '0.1.4',
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

    -- LSP, Folds, Debugging, and LINT
    {
        'neovim/nvim-lspconfig',
        init = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        end
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
        dependencies = { 'mason-org/mason.nvim', 'nvim-lspconfig' }
    },
    'nvim-neotest/nvim-nio',
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            { 'nvim-neotest/nvim-nio' }
        }, -- TODO Keybindings required.
    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = { { 'nvim-dap' } },
    },
    'theHamsta/nvim-dap-virtual-text',
    {
        'nvimtools/none-ls.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        'jay-babu/mason-null-ls.nvim',
        opts = {}
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
                delve = function(config)
                    config.configurations = {
                        {
                            type = 'delve',
                            name = 'Debug File',
                            request = 'launch',
                            program = '${file}'
                        },
                        {
                            type = 'delve',
                            name = 'Debug Module',
                            request = 'launch',
                            program = './${relativeFileDirname}'
                        },
                        {
                            type = 'delve',
                            name = 'Debug Module w/ Args',
                            request = 'launch',
                            program = './${relativeFileDirname}',
                            args = function()
                                local args_string = vim.fn.input('Arguments: ')
                                return vim.split(args_string, ' ')
                            end,
                        },
                        {
                            type = 'delve',
                            name = 'Debug File Tests',
                            request = 'launch',
                            mode = 'test',
                            program = '${file}'
                        },
                        {
                            type = 'delve',
                            name = 'Debug Module Tests',
                            request = 'launch',
                            mode = 'test',
                            program = './${relativeFileDirname}'
                        }
                    }
                    config.adapters = {
                        type = 'server',
                        port = '${port}',
                        executable = {
                            command = vim.fn.stdpath('data') .. '/mason/bin/dlv',
                            args = { 'dap', '-l', '127.0.0.1:${port}' },
                        },
                    }
                    require('mason-nvim-dap').default_setup(config) -- don't forget this!
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
        }
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
        'nvimdev/lspsaga.nvim',
        cond = not vim.g.vscode,
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons'
        },
        opts = {}
    },

    {
        'simrat39/rust-tools.nvim',
        cond = not vim.g.vscode
    },

    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'rafamadriz/friendly-snippets',
    'saadparwaiz1/cmp_luasnip',
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
        'folke/trouble.nvim',
        opts = {
            auto_close = true,
            warn_no_results = false,
            modes = {
                test = {
                    mode = "diagnostics",
                    preview = {
                        type = "split",
                        relative = "win",
                        position = "right",
                        size = 0.3,
                    },
                },
            },
        }, -- for default options, refer to the configuration section for custom setup.
        cmd = 'Trouble',
        keys = {
            {
                '<leader>xx',
                '<cmd>Trouble diagnostics toggle<cr>',
                desc = 'Diagnostics (Trouble)',
            },
            {
                '<leader>xX',
                '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
                desc = 'Buffer Diagnostics (Trouble)',
            },
            {
                '<leader>cs',
                '<cmd>Trouble symbols toggle focus=false<cr>',
                desc = 'Symbols (Trouble)',
            },
            {
                '<leader>cl',
                '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
                desc = 'LSP Definitions / references / ... (Trouble)',
            },
            {
                '<leader>xL',
                '<cmd>Trouble loclist toggle<cr>',
                desc = 'Location List (Trouble)',
            },
            {
                '<leader>xQ',
                '<cmd>Trouble qflist toggle<cr>',
                desc = 'Quickfix List (Trouble)',
            },
        },
        cond = not vim.g.vscode
    },
    {
        'danymat/neogen', opts = {}
    },

    -- bracketing
    {
        'windwp/nvim-autopairs', opts = {},
    },
    {
        'windwp/nvim-ts-autotag',
        opts = {
            opts = {
                -- Defaults
                enable_close = true,          -- Auto close tags
                enable_rename = true,         -- Auto rename pairs of tags
                enable_close_on_slash = false -- Auto close on trailing </
            },
            -- Also override individual filetype configs, these take priority.
            -- Empty by default, useful if one of the "opts" global settings
            -- doesn't work well in a specific filetype
            per_filetype = {
            }
        }
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
    'tpope/vim-sleuth',
    'preservim/nerdcommenter',
    {
        'mcauley-penney/tidy.nvim',
        cond = vim.g.os ~= "Windows",
        branch = "main",
        opts = {
            filetype_exclude = { 'markdown', 'diff', 'svelte' }
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
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
                'yaml', -- Install parsers synchronously (only applied to `ensure_installed`)
            },
            modules = {},

            sync_install = false,
            auto_install = true,
            ignore_install = { 'org' },

            highlight = {
                enable = true,
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
                additional_vim_regex_highlighting = false,

            },
            indent = { enable = true },
        },
        config = function(nvim_ts, opts)
            local parser_config = require 'nvim-treesitter.parsers'.get_parser_configs()
            parser_config.openscad = {
                install_info = {
                    url = 'https://github.com/bollian/tree-sitter-openscad',
                    files = { 'src/parser.c' },
                    generate_requires_npm = true,
                    requires_generate_from_grammar = false
                },
                filetype = 'scad'
            }
            nvim_ts = require('nvim-treesitter.configs')
            nvim_ts.setup { opts }
        end
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
    },
    { 'lukas-reineke/indent-blankline.nvim' },
    'yaocccc/nvim-hlchunk',
    --{ 'shellRaining/hlchunk.nvim', event = { 'UIEnter' }, },
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
    },
    {
        'mikesmithgh/kitty-scrollback.nvim',
        enabled = true,
        lazy = true,
        cmd = { 'KittyScrollbackGenerateKittens', 'KittyScrollbackCheckHealth' },
        event = { 'User KittyScrollbackLaunch' },
        -- version = '*', -- latest stable version, may have breaking changes if major version changed
        -- version = '^5.0.0', -- pin major version, include fixes and features that do not have breaking changes
        opts = {},
        cond = not vim.g.vscode
    },
})
