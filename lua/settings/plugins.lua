-- Installs lazy.nvim if it isn't installed already.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader       = ' '
vim.g.maplocalleader  = ' '

require('lazy').setup({

  -- Color Schemes
  'rebelot/kanagawa.nvim',
  'dracula/vim',
  'sainnhe/everforest',
  'ayu-theme/ayu-vim',
  'folke/tokyonight.nvim',

  -- Icons
  'ryanoasis/vim-devicons',
  'nvim-tree/nvim-web-devicons',
  'lewis6991/gitsigns.nvim', -- used for GIT status for barbar

  -- Window and Workflow Improvements
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional
    }
  },
  'romgrk/barbar.nvim',
  'gelguy/wilder.nvim',
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
  },
  "tiagovla/scope.nvim",

  -- tmux motion integration (dependencies same plugin for tmux)
  'christoomey/vim-tmux-navigator',

  -- Fuzzy Finder
  'nvim-lua/plenary.nvim',
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
  -- or                            , branch = '0.1.x',
    dependencies = { {'nvim-lua/plenary.nvim'} }
  },

  -- LSP, Debugging, and LINT
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    build = ":MasonUpdate" -- :MasonUpdate updates registry contents
  },
  'mfussenegger/nvim-dap', -- TODO Keybindings required.
  'jose-elias-alvarez/null-ls.nvim',
  'jay-babu/mason-null-ls.nvim',
  { 'fatih/vim-go', build = ':GoUpdateBinaries' },

  -- Autocompletion Engine and Extensions
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'saadparwaiz1/cmp_luasnip',
  'hrsh7th/cmp-nvim-lsp',
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
  -- bracketing
  "windwp/nvim-autopairs",

  -- snippet engine
  'rafamadriz/friendly-snippets',
  {
    'l3mon4d3/luasnip',
    wants = 'friendly-snippets',
    dependencies = {
      'rafamadriz/friendly-snippets',
    }
  },

  -- clipboard (dependencies an osc52 compliant terminal emulator)
  'ojroques/vim-oscyank',

  -- comments, whitespace, and highlighting (ts)
  'preservim/nerdcommenter',
  'ntpeters/vim-better-whitespace',
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = {
        "bash",
        "c",
        "html",
        "javascript",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    }
  },

  'ap/vim-css-color', -- highlight color in css files

})

-- plugin configuration

local lspconfig = require("lspconfig")
require("mason-lspconfig").setup_handlers({

  function (server_name) -- automatically handles installed by Mason
    lspconfig[server_name].setup({
    })
  end,

  ["lua_ls"] = function ()
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
})

---- packer Plugins
require('scope').setup({})
require('nvim-tree').setup()
require('lualine').setup({})
require('barbar').setup({
  sidebar_filetypes = {
    -- Use the default values: {event = 'BufWinLeave', text = nil}
    NvimTree = true
  },
})

require("mason").setup()
require("mason-lspconfig").setup()
require("null-ls").setup({
  -- STUFF NOT SUPPORTED BY MASON HERE
})
require("mason-null-ls").setup({
  -- AUTOMATIC SETUP ENABLED
  handlers = {},
})

local wilder = require('wilder')
wilder.setup({modes = {':', '/', '?'}})
wilder.set_option('renderer', wilder.popupmenu_renderer({
  -- highlighter applies highlighting to the candidates
  highlighter = wilder.basic_highlighter(),
}))

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  disable_netrw=false,
  hijack_netrw=true,
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

require("telescope").load_extension("scope")
require("luasnip.loaders.from_vscode").lazy_load()
require("nvim-autopairs").setup {}
require('gitsigns').setup()

vim.g.cssColorVimDoNotMessMyUpdatetime = 1

	-- Local Plugins
require('local_plugins/bclose')
require('settings/cmp')
