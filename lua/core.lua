-- CORE NEOVIM CONFIG

-- MISC
vim.opt.encoding          = 'utf-8'
vim.opt.mouse             = 'a'   -- mouse clicking enabled in all modes
vim.opt.number            = true  -- line numbers
vim.opt.relativenumber    = true  -- rel line numbers
vim.opt.wildmode          = {'longest', 'list'} -- bashlike tab completion
vim.opt.cc                = {80, 140}
vim.opt.ttyfast           = true
vim.opt.compatible        = false -- disable oldvi compatibility
vim.opt.splitright        = true
vim.opt.splitbelow        = true

-- COLORSCHEME
vim.opt.termguicolors     = true
vim.cmd.colorscheme       'kanagawa'

-- SEARCHING
vim.opt.showmatch         = false -- show matching
vim.opt.ignorecase        = true  -- case insensitive search
vim.opt.hlsearch          = true  -- highlight searchterms
vim.opt.incsearch         = true  -- incremental searching

-- FILES AND PASTING
vim.opt.autochdir         = false  -- chg dir to opened file's dir
vim.opt.clipboard         = { 'unnamed', 'unnamedplus' }

-- INDENTATION
vim.opt.tabstop           = 2
vim.opt.softtabstop       = 2
vim.opt.expandtab         = true  -- converts tabs to whitespace
vim.opt.shiftwidth        = 2     -- default autoindent shift amount
vim.opt.autoindent        = true

-- CURSOR: Enables blinkng & highlighting with different cursor shapes per mode.
vim.opt.guicursor         = {
  'n-v-c:block',
  'i-ci-ve:ver25-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor',
  'r-cr:hor20',
  'o:hor50',
  'sm:block-blinkwait175-blinkoff150-blinkon175'
}

-- Disable Comments on Newline
vim.api.nvim_create_autocmd("FileType", {
  command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"
})

vim.g.cssColorVimDoNotMessMyUpdatetime = 1
vim.g.better_whitespace_enabled = 1
vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = 'Cyan' } )

