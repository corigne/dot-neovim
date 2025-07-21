-- CORE NEOVIM CONFIG
if vim.fn.exists('g:os') == 0 then
    local is_windows = vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1
    if is_windows then
        vim.g.os = "Windows"

        vim.o.shell = "powershell"
        local powershell_options = {
            shell = vim.fn.executable "pwsh" == 1 and "pwsh" or "powershell",
            shellcmdflag =
            "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
            shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
            shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
            shellquote = "",
            shellxquote = "",
        }

        for option, value in pairs(powershell_options) do
            vim.opt[option] = value
        end
    else
        local uname_output = vim.fn.system('uname')
        vim.g.os = string.gsub(uname_output, '\n', '')
    end
end

if vim.g.os == "Windows" then
    -- windows specific shit here
end

-- Autoformat on save.
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp", { clear = true }),
    callback = function(args)
        -- 2
        vim.api.nvim_create_autocmd("BufWritePre", {
            -- 3
            buffer = args.buf,
            callback = function()
                -- 4 + 5
                vim.lsp.buf.format { async = false, id = args.data.client_id }
            end,
        })
    end
})

-- MISC
if vim.g.vscode then
    vim.g.cmdheight = 3
    return
end
vim.opt.encoding           = 'utf-8'
vim.opt.mouse              = 'a'   -- mouse clicking enabled in all modes
vim.opt.ttyfast            = true
vim.opt.compatible         = false -- disable oldvi compatibility

-- PROVIDERS
vim.g.perl_host_prog       = '/usr/bin/perl'
vim.g.loaded_perl_provider = 0

-- VISUAL
vim.opt.termguicolors      = true
vim.cmd.colorscheme 'catppuccin'
vim.opt.number         = true                  -- line numbers
vim.opt.relativenumber = true                  -- rel line numbers
vim.opt.wildmode       = { 'longest', 'list' } -- bashlike tab completion
vim.opt.cc             = { 79, 139 }
vim.opt.linespace      = 1
vim.opt.signcolumn     = 'yes'
vim.opt.wrap           = true
vim.opt.linebreak      = true

-- SEARCHING
vim.opt.showmatch      = false -- show matching
vim.opt.ignorecase     = true  -- case insensitive search
vim.opt.hlsearch       = true  -- highlight searchterms
vim.opt.incsearch      = true  -- incremental searching

-- Setup Folding
vim.o.foldcolumn       = '1' -- '0' is not bad
vim.o.foldlevel        = 99  -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart   = 99
vim.o.foldenable       = true

-- FILES AND PASTING
vim.opt.autochdir      = false -- chg dir to opened file's dir
vim.opt.clipboard      = { 'unnamed', 'unnamedplus' }
vim.opt.splitright     = true
vim.opt.splitbelow     = true

-- INDENTATION
vim.opt.tabstop        = 4
vim.opt.softtabstop    = 4
vim.opt.expandtab      = true -- converts tabs to whitespace
vim.opt.shiftwidth     = 4 -- default autoindent shift amount
vim.opt.autoindent     = true
vim.opt.list           = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

-- CURSOR: Enables blinkng & highlighting with different cursor shapes per mode.
vim.opt.guicursor = {
    'n-v-c:block',
    'i-ci-ve:ver25-blinkwait700-blinkoff400-blinkon250-Cursor/lCursor',
    'r-cr:hor20',
    'o:hor50',
    'sm:block-blinkwait175-blinkoff150-blinkon175'
}

-- Uncomment Below to Disable Comments on Newline
vim.api.nvim_create_autocmd("FileType", {
    command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o"
})

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
