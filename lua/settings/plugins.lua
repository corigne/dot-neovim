require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'dracula/vim'
  use { 'folke/tokyonight.nvim', branch = 'main' }
  use 'sainnhe/everforest'
  use 'ayu-theme/ayu-vim'
  use 'ryanoasis/vim-devicons'
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional
    },
    config = function()
      require("nvim-tree").setup {}
    end
  }
  use 'nvim-tree/nvim-web-devicons'
  use 'honza/vim-snippets'
  use 'preservim/nerdcommenter'
  use 'ntpeters/vim-better-whitespace'
  use { 'fatih/vim-go', run = ':GoUpdateBinaries' }
  use 'christoomey/vim-tmux-navigator'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdateSync' }
  use 'nvim-lua/plenary.nvim'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
  -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'

  -- Autocompletion Engine and Extensions
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'saadparwaiz1/cmp_luasnip'
  use 'hrsh7th/cmp-nvim-lsp'

  -- Snippet Engine
  use 'L3MON4D3/LuaSnip'
  use 'rafamadriz/friendly-snippets'

end)

-- Plugin Configuration
require('nvim-tree').setup()
require('lualine').setup()
require('nvim-treesitter.configs').setup {
  ensure_installed = { "c", "lua", "vim", "query", "cpp", "go", "rust",
    "typescript", "javascript", "svelte", "css" },
  sync_install = false,
  auto_install = false,
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
}

require('settings/cmp')
