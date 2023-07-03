require('packer').startup(function()
  -- Package management
  use 'wbthomason/packer.nvim'

  -- Color Schemes
  use 'dracula/vim'
  use { 'folke/tokyonight.nvim', branch = 'main' }
  use 'sainnhe/everforest'
  use 'rebelot/kanagawa.nvim'
  use 'ayu-theme/ayu-vim'

  -- Icons
  use 'ryanoasis/vim-devicons'
  use 'nvim-tree/nvim-web-devicons'
  use 'lewis6991/gitsigns.nvim' -- used for GIT status for barbar

  -- Window and Workflow Improvements
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    }
  }
  use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
  use 'gelguy/wilder.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  -- tmux motion integration (requires same plugin for tmux)
  use 'christoomey/vim-tmux-navigator'

  -- Fuzzy Finder
  use 'nvim-lua/plenary.nvim'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
  -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- LSP, Debugging, and LINT
  use {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    run = ":MasonUpdate" -- :MasonUpdate updates registry contents
  }
  use 'mfussenegger/nvim-dap' -- TODO Keybindings required.
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'jay-babu/mason-null-ls.nvim'
  use { 'fatih/vim-go', run = ':GoUpdateBinaries' }

  -- Autocompletion Engine and Extensions
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-nvim-lsp'
  use {
      "glepnir/lspsaga.nvim",
      opt = false,
      branch = "main",
      event = "LspAttach",
      config = function ()
          require("lspsaga").setup({})
    end,
  }
  -- bracketing
  use "windwp/nvim-autopairs"

  -- snippet engine
  use 'l3mon4d3/luasnip'
  use 'rafamadriz/friendly-snippets'
  use 'honza/vim-snippets'

  -- clipboard (requires an osc52 compliant terminal emulator)
  use 'ojroques/vim-oscyank'

  -- comments, whitespace, and highlighting (ts)
  use 'preservim/nerdcommenter'
  use 'ntpeters/vim-better-whitespace'
  use { 'nvim-treesitter/nvim-treesitter', run = ':tsupdatesync' }

end)

-- plugin configuration

---- packer plugins
require('nvim-tree').setup()
require('lualine').setup({})

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

require("bufferline").setup{}
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

require('nvim-treesitter.configs').setup {
  ensure_installed = { "c", "lua", "vim", "query", "cpp", "go", "rust",
    "typescript", "javascript", "svelte", "css" },
  sync_install = true,
  auto_install = true,
  ignore_install = { "" },

  highlight = {
    enable = true,

    disable = function(lang, buf)
        local max_filesize = 200 * 1024 -- 200 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    additional_vim_regex_highlighting = true,
  },
  indent = {
    enable = true
  }
}
require("luasnip.loaders.from_vscode").lazy_load()
require("nvim-autopairs").setup {}

	-- Local Plugins
require('local_plugins/bclose')
require('settings/cmp')
