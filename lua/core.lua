-- CORE NEOVIM CONFIG

-- MISC
vim.opt.encoding            = 'utf-8'
vim.opt.mouse               = 'a'   -- mouse clicking enabled in all modes
vim.opt.ttyfast             = true
vim.opt.compatible          = false -- disable oldvi compatibility

-- VISUAL
vim.opt.termguicolors       = true
vim.cmd.colorscheme         'catppuccin'
vim.opt.number              = true  -- line numbers
vim.opt.relativenumber      = true  -- rel line numbers
vim.opt.wildmode            = {'longest', 'list'} -- bashlike tab completion
vim.opt.cc                  = {80, 140}
vim.opt.linespace           = 1
vim.opt.signcolumn          = 'yes'

-- SEARCHING
vim.opt.showmatch           = false -- show matching
vim.opt.ignorecase          = true  -- case insensitive search
vim.opt.hlsearch            = true  -- highlight searchterms
vim.opt.incsearch           = true  -- incremental searching

-- FOLDING
-- Disabled due to use of UFO. Re-enable if not using UFO.
-- Folding config in plugins.lua
--vim.opt.foldmethod          = 'expr'
--vim.opt.foldexpr            = 'nvim_treesitter#foldexpr()'
--vim.opt.foldcolumn          = '1'
--vim.opt.foldlevel           = 10

-- FILES AND PASTING
vim.opt.autochdir           = false  -- chg dir to opened file's dir
vim.opt.clipboard           = { 'unnamed','unnamedplus' }
vim.opt.splitright          = true
vim.opt.splitbelow          = true


-- INDENTATION
vim.opt.tabstop             = 4
vim.opt.softtabstop         = 4
vim.opt.expandtab           = true  -- converts tabs to whitespace
vim.opt.shiftwidth          = 4     -- default autoindent shift amount
vim.opt.autoindent          = true
vim.opt.list                = false
vim.opt.listchars:append    "space:⋅"
vim.opt.listchars:append    "eol:↴"

-- CURSOR: Enables blinkng & highlighting with different cursor shapes per mode.
vim.opt.guicursor           = {
    'n-v-c:block',
    'i-ci-ve:ver25-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor',
    'r-cr:hor20',
    'o:hor50',
    'sm:block-blinkwait175-blinkoff150-blinkon175'
}

-- Disable Netrw for nvim-tree
vim.g.loaded_netrw          = 1
vim.g.loaded_netrwPlugin    = 1

-- Uncomment Below to Disable Comments on Newline
--vim.api.nvim_create_autocmd("FileType", {
--command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"
--})

-- I don't remember why I put this here.
vim.g.cssColorVimDoNotMessMyUpdatetime = 1

-- Temporarily suppress null-ls offset_encodings error until alternative found
local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end
