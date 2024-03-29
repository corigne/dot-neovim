-- PLUGIN SETTINGS

-- Installs lazy.nvim if it isn't installed already.
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
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

vim.g.mapleader       = ' '
vim.g.maplocalleader  = ' '

require('lazy').setup({

  -- Color Schemes, can be set to one of these in core.lua
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  'rebelot/kanagawa.nvim',
  'dracula/vim',
  'sainnhe/everforest',
  'ayu-theme/ayu-vim',
  'folke/tokyonight.nvim',

  -- Icons
  'nvim-tree/nvim-web-devicons',
  'lewis6991/gitsigns.nvim', -- used for GIT status for barbar

  -- Window and Workflow Improvements
  {
      "nvim-telescope/telescope-file-browser.nvim",
      dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  -- Tab bar (top)
  {'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  init = function() vim.g.barbar_auto_setup = false end,
  opts = {
    animation = true,
    insert_at_start = true,
    sidebar_filetypes = {
      NvimTree = true,
    },
  },
  version = '^1.0.0', -- optional: only update when a new 1.x version is released
},
{
  "kdheepak/lazygit.nvim",
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
},
'andweeb/presence.nvim',
'gelguy/wilder.nvim',

-- Status line (bottom)
{
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
},
'tiagovla/scope.nvim',

-- Telescope Stuff
'nvim-lua/plenary.nvim',
{
  'nvim-telescope/telescope.nvim', tag = '0.1.4',
  dependencies = { 'nvim-lua/plenary.nvim' }
},

-- LSP, Debugging, and LINT
'neovim/nvim-lspconfig',
{
  'williamboman/mason.nvim',
  build = ':MasonUpdate' -- :MasonUpdate updates registry contents
},
'williamboman/mason-lspconfig.nvim',

'mfussenegger/nvim-dap', -- TODO Keybindings required.
{
  'rcarriga/nvim-dap-ui',
  dependencies = { {'nvim-dap'} },
},

'jose-elias-alvarez/null-ls.nvim',
'jay-babu/mason-null-ls.nvim',
"jay-babu/mason-nvim-dap.nvim",
{
  "ray-x/go.nvim",
  dependencies = {  -- optional packages
  "ray-x/guihua.lua",
  "neovim/nvim-lspconfig",
  "nvim-treesitter/nvim-treesitter",
},
config = function()
  require("go").setup()
end,
event = {"CmdlineEnter"},
ft = {"go", 'gomod'},
build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
},
-- Autocompletion Engine and Extensions
{
  'nvimdev/lspsaga.nvim',
  config = function()
    require('lspsaga').setup({})
  end,
  dependenices = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons'
  }
},

'simrat39/rust-tools.nvim',

'hrsh7th/nvim-cmp',
'hrsh7th/cmp-path',
'hrsh7th/cmp-cmdline',
'hrsh7th/cmp-nvim-lsp',
'hrsh7th/cmp-buffer',
{
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
	-- install jsregexp (optional!).
	build = "make install_jsregexp"
},
{ 'folke/neodev.nvim', opts = {} },

-- bracketing
'windwp/nvim-autopairs',

-- clipboard (dependencies an osc52 compliant terminal emulator)
'ojroques/nvim-osc52',
-- comments, whitespace, and highlighting (ts)
'preservim/nerdcommenter',

{
  'mcauley-penney/tidy.nvim',
  config = {
    filetype_exclude = { 'markdown', 'diff' }
  },
  init = function()
    vim.keymap.set('n', '<leader>te', require('tidy').toggle, {})
  end
},

{
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
},

{
  'nvim-treesitter/nvim-treesitter-textobjects',
  init = function()
    -- disable rtp plugin, as we only need its queries for mini.ai
    -- In case other textobject modules are enabled, we will load them
    -- once nvim-treesitter is loaded
    require('lazy.core.loader').disable_rtp_plugin('nvim-treesitter-textobjects')
    load_textobjects = true
  end,
},
{ 'lukas-reineke/indent-blankline.nvim' },
'yaocccc/nvim-hlchunk',
--{ "shellRaining/hlchunk.nvim", event = { "UIEnter" }, },
'ap/vim-css-color', -- highlight color in css files
})

-- plugin configuration

require("catppuccin").setup({
    flavour = "frappe", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "frappe",
    },
    transparent_background = true, -- disables setting the background color.
    show_end_of_buffer = true, -- shows the '~' characters after the end of buffers
    dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
    },
})

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or 'all' (the five listed parsers should always be installed)
  ensure_installed = {
    'bash',
    'c',
    'cpp',
    'c_sharp',
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
    'tsx',
    'typescript',
    'vim',
    'vimdoc',
    'yaml',  -- Install parsers synchronously (only applied to `ensure_installed`)
  },

  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for 'all')
  ignore_install = { '' },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = '/some/path/to/store/parsers', -- Remember to run vim.opt.runtimepath:append('/some/path/to/store/parsers')!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { '' },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

require('lualine').setup({})
require('mason').setup()
require('mason-lspconfig').setup({
  automatic_installation = true,
})
require('mason-nvim-dap').setup({
  ensure_installed = { "codelldb", "delve", "python" },
  handlers = {
      function(config)
          -- all sources with no handler get passed here

          -- Keep original functionality
          require('mason-nvim-dap').default_setup(config)
      end,
      delve = function(config)
          config.configurations = {
              {
                  type = "delve",
                  name = "Debug File",
                  request = "launch",
                  program = "${file}"
              },
              {
                  type = "delve",
                  name = "Debug Module",
                  request = "launch",
                  program = "./${relativeFileDirname}"
              },
              {
                  type = "delve",
                  name = "Debug Module w/ Args",
                  request = "launch",
                  program = "./${relativeFileDirname}",
                  args = function()
                      local args_string = vim.fn.input("Arguments: ")
                      return vim.split(args_string, " ")
                  end,
              },
              {
                  type = "delve",
                  name = "Debug File Tests",
                  request = "launch",
                  mode = "test",
                  program = "${file}"
              },
              {
                  type = "delve",
                  name = "Debug Module Tests",
                  request = "launch",
                  mode = "test",
                  program = "./${relativeFileDirname}"
              }
          }
          config.adapters = {
              type = "server",
              port = "${port}",
              executable = {
                  command = vim.fn.stdpath("data") .. '/mason/bin/dlv',
                  args = { "dap", "-l", "127.0.0.1:${port}" },
              },
          }
          require('mason-nvim-dap').default_setup(config) -- don't forget this!
      end,
  },
})

require('lspconfig').glslls.setup{}

require('null-ls').setup({
  -- STUFF NOT SUPPORTED BY MASON HERE
})
require('mason-null-ls').setup({
  -- AUTOMATIC SETUP ENABLED
  handlers = {},
})

require('mason-lspconfig').setup_handlers({
  function (server_name) -- automatically handles installed by Mason
    lspconfig[server_name].setup({
      capabilities = capabilities,
    })
  end,

  ['cssls'] = function ()
    --Enable (broadcasting) snippet capability for completion
    capabilities.textDocument.completion.completionItem.snippetSupport = true

    require'lspconfig'.cssls.setup {
      capabilities = capabilities,
    }
  end,

  ["rust_analyzer"] = function ()
    require("rust-tools").setup()
  end,

  ['lua_ls'] = function ()
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = {'vim', 'require'},
          },
        },
      },
    }
  end,

  ['clangd'] = function ()
    lspconfig.clangd.setup {
      cmd = {
        'clangd',
        '--background-index',
        '-j=12',
        '--clang-tidy',
        '--clang-tidy-checks=*',
        '--all-scopes-completion',
        '--cross-file-rename',
        '--completion-style=detailed',
        '--pch-storage=memory',
        '--suggest-missing-includes',
      },
      capabilities = capabilities,
    }
  end,
})

require("presence").setup({ })
local wilder = require('wilder')
wilder.setup({modes = {':', '/', '?'}})
wilder.set_option('renderer', wilder.popupmenu_renderer({
  -- highlighter applies highlighting to the candidates
  highlighter = wilder.basic_highlighter(),
}))
require("luasnip.loaders.from_snipmate").lazy_load()
require('nvim-autopairs').setup {}
require('scope').setup({})
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
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
            theme = "ivy",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            mappings = {
              ["i"] = {
                -- your custom insert mode mappings
              },
              ["n"] = {
                -- your custom normal mode mappings
              },
            },
          },
      -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
      }
    }
    require('telescope').load_extension('scope')
    require("telescope").load_extension('file_browser')
    require('gitsigns').setup()

    vim.g.cssColorVimDoNotMessMyUpdatetime = 1
