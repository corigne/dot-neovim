-- km SETTINGS

local km = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ==================
-- Clear Search HL
km('n', '<leader>\\', ':nohl<CR><C-l>', { silent = true })

-- ==================
-- Buffers
km('n', '<leader>q', ':bdelete<CR>', { noremap = true, silent = true })

-- ==================
-- Clipboard
if not vim.g.vscode then
    km('n', '<leader>y', require('osc52').copy_operator, { expr = true })
    km('v', '<leader>y', require('osc52').copy_visual)
end
km('n', '<leader>yy', '<leader>y_', { remap = true })

-- ==================
-- Autoformat toggle for buffer.
if vim.g.os ~= 'Windows' then
    local toggle_tidy = require('tidy').toggle
    km('n', '<leader>te', toggle_tidy, {})
end

-- ==================
-- Folding
-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
km('n', 'zR', require('ufo').openAllFolds)
km('n', 'zM', require('ufo').closeAllFolds)

-- ==================
-- Telescope
local telescope_builtin = require('telescope.builtin')

km('n', '<leader>tf', ':Telescope file_browser<CR>', {})
km('n', '<leader>tb', telescope_builtin.buffers, {})
km('n', '<leader>ff', telescope_builtin.find_files, {})
km('n', '<leader>fg', telescope_builtin.live_grep, {})
km('n', '<leader>fr', telescope_builtin.lsp_references, {})
km('n', '<leader>fi', telescope_builtin.lsp_implementations, {})
km('n', '<leader>fd', telescope_builtin.lsp_definitions, {})
km('n', '<leader>ft', telescope_builtin.lsp_type_definitions, {})
km('n', '<leader>fh', telescope_builtin.help_tags, {})
--
-- km('n', '<leader>gs', telescope_builtin.git_status, {})
km('n', '<leader>gc', telescope_builtin.git_commits, {})
-- km('n', '<leader>gb', telescope_builtin.git_branches, {})
-- km('n', '<leader>sd', telescope_builtin.diagnostics, {})

-- ==================
-- neogen
local neogen = require('neogen')
km('n', '<leader>ng', neogen.generate, opts)

-- DAP-UI
local dap = require('dap')
local dap_ui = require('dapui')
km('n', '<Leader>dd', dap_ui.toggle, opts)
km('n', '<Leader>b', ':DapToggleBreakpoint<CR>' , opts)
km('n', '<Leader>db', ':DapToggleBreakpoint<CR>', opts)
km('n', '<Leader>dbc', ':DapClearBreakpoints<CR>', opts)
km('n', '<Leader>dc', ':DapContinue<CR>', opts)
km('n', '<F5>', ':DapContinue<CR>', opts)
km('n', '<Leader>ds', ':DapStepOver<CR>', opts)
km('n', '<F10>', ':DapStepOver<CR>', opts)
km('n', '<Leader>di', ':DapStepInto<CR>', opts)
km('n', '<F11>', ':DapStepInto<CR>', opts)
km('n', '<Leader>do', ':DapStepOut<CR>', opts)
km('n', '<F12>', ':DapStepOut<CR>', opts)
km('n', '<Leader>ds', ':DapStop<CR>', opts)
km('n', '<Leader>dr', ':DapRerun<CR>', opts)

km('n', '<Leader>dr', dap.repl.toggle, opts)
km('n', '<Leader>dl', dap.run_last, opts)

km('n', '<Leader>cc', ':CopilotChatToggle<CR>', opts)
km('n', '<Leader>cr', ':CopilotChatReset<CR>', opts)
km('n', '<Leader>cl',':CopilotChatLoad ', opts)
km('n', '<Leader>cs',':CopilotChatSave ', opts)
km('n', '<Leader>cS',':CopilotChatStop<CR>', opts)
km('n', '<Leader>cm', ':CopilotChatModels<CR>', opts)

if not vim.g.vscode then
    -- ==================
    -- Lspsaga Keybindings --

    -- LSP finder - Find the symbol's definition
    -- If there is no definition, it will instead be hidden
    -- When you use an action in finder like 'open vsplit',
    -- you can use <C-t> to jump back
    -- km('n', 'gh', '<cmd>Lspsaga finder tyd+ref+imp+def <CR>')

    -- Code action
    km({ 'n', 'v' }, '<leader>ca', '<cmd>Lspsaga code_action<CR>')

    -- Rename all occurrences of the hovered word for the entire file
    km('n', '<leader>re', '<cmd>Lspsaga rename<CR>')

    -- Peek definition
    -- You can edit the file containing the definition in the floating window
    -- It also supports open/vsplit/etc operations, do refer to 'definition_action_keys'
    -- It also supports tagstack
    -- Use <C-t> to jump back
    km('n', '<leader>pd', '<cmd>Lspsaga peek_definition<CR>')

    -- Go to definition
    -- km('n','gd', '<cmd>Lspsaga goto_definition<CR>')

    -- Peek type definition
    -- You can edit the file containing the type definition in the floating window
    -- It also supports open/vsplit/etc operations, do refer to 'definition_action_keys'
    -- It also supports tagstack
    -- Use <C-t> to jump back
    km('n', '<leader>pt', '<cmd>Lspsaga peek_type_definition<CR>')

    -- Show line diagnostics
    -- You can pass argument ++unfocus to
    -- unfocus the show_line_diagnostics floating window
    --     km('n', '<leader>ss', '<cmd>Lspsaga show_line_diagnostics<CR>')
    --
    --     -- Show buffer diagnostics
    --     km('n', '<leader>sd', '<cmd>Lspsaga show_buf_diagnostics<CR>')
    --
    --     -- Show workspace diagnostics
    --     km('n', '<leader>sa', '<cmd>Lspsaga show_workspace_diagnostics<CR>')
    --
    -- Show cursor diagnostics
    km('n', '<leader>sdc', '<cmd>Lspsaga show_cursor_diagnostics<CR>')

    -- Diagnostic jump
    -- You can use <C-o> to jump back to your previous location
    km('n', ']d', '<cmd>Lspsaga diagnostic_jump_prev<CR>')
    km('n', '[d', '<cmd>Lspsaga diagnostic_jump_next<CR>')

    -- Toggle outline
    km('n', '<leader>lo', '<cmd>Lspsaga outline<CR>')

    -- Hover Doc
    -- If there is no hover doc,
    -- there will be a notification stating that
    -- there is no information available.
    -- To disable it just use ':Lspsaga hover_doc ++quiet'
    -- Pressing the key twice will enter the hover window
    km('n', 'K', '<cmd>Lspsaga hover_doc<CR>')

    -- Call hierarchy
    km('n', '<Leader>ci', '<cmd>Lspsaga incoming_calls<CR>')
    km('n', '<Leader>co', '<cmd>Lspsaga outgoing_calls<CR>')

    -- Floating terminal
    km({ 'n', 't' }, '<D-d>', '<cmd>exe v:count1 . \'ToggleTerm\'<CR>')
    km({ 'n', 't' }, '<M-d>', '<cmd>exe v:count1 . \'ToggleTerm\'<CR>')
    function SetTerminalkms()
        local termopts = { buffer = 0 }
        km('t', '<esc>', [[<C-\><C-n>]], termopts)
        km('t', '<C-h>', [[<Cmd>wincmd h<CR>]], termopts)
        km('t', '<C-j>', [[<Cmd>wincmd j<CR>]], termopts)
        km('t', '<C-k>', [[<Cmd>wincmd k<CR>]], termopts)
        km('t', '<C-l>', [[<Cmd>wincmd l<CR>]], termopts)
        km('t', '<C-w>', [[<C-\><C-n><C-w>]], termopts)
    end

    local nvim_tmux_nav = require('nvim-tmux-navigation')
    km('n', '<C-h>', nvim_tmux_nav.NvimTmuxNavigateLeft, opts)
    km('n', '<C-j>', nvim_tmux_nav.NvimTmuxNavigateDown, opts)
    km('n', '<C-k>', nvim_tmux_nav.NvimTmuxNavigateUp, opts)
    km('n', '<C-l>', nvim_tmux_nav.NvimTmuxNavigateRight, opts)
    km('n', '<C-\\>', nvim_tmux_nav.NvimTmuxNavigateLastActive, opts)
    km('n', '<C-Space>', nvim_tmux_nav.NvimTmuxNavigateNext, opts)

    vim.cmd('autocmd! TermOpen term://* lua SetTerminalkms()')
end
