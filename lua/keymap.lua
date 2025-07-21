-- KEYMAP SETTINGS

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }


-- ==================
-- Clear Search HL
keymap('n', '<leader>\\', ':nohl<CR><C-l>', { silent = true })

-- ==================
-- Buffers
keymap('n', '<leader>q', ':bp|bd #<CR>', {})
keymap('n', '<leader>qq', ':bp|bd #!<CR>', {})

-- ==================
-- Clipboard
if not vim.g.vscode then
    keymap('n', '<leader>y', require('osc52').copy_operator, { expr = true })
    keymap('v', '<leader>y', require('osc52').copy_visual)
end
keymap('n', '<leader>yy', '<leader>y_', { remap = true })

-- ==================
-- Autoformat toggle for buffer.
if vim.g.os ~= "Windows" then
    local toggle_tidy = require("tidy").toggle
    keymap('n', '<leader>te', toggle_tidy, {})
end

-- ==================
-- Folding
-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)


-- ==================
-- Telescope
local telescope_builtin = require('telescope.builtin')

keymap('n', '<leader>tf', ':Telescope file_browser<CR>', {})
keymap('n', '<leader>tb', telescope_builtin.buffers, {})
keymap('n', '<leader>ff', telescope_builtin.find_files, {})
keymap('n', '<leader>fg', telescope_builtin.live_grep, {})
keymap('n', '<leader>fr', telescope_builtin.lsp_references, {})
keymap('n', '<leader>fi', telescope_builtin.lsp_implementations, {})
keymap('n', '<leader>fd', telescope_builtin.lsp_definitions, {})
keymap('n', '<leader>ft', telescope_builtin.lsp_type_definitions, {})
keymap('n', '<leader>fh', telescope_builtin.help_tags, {})

keymap('n', '<leader>gs', telescope_builtin.git_status, {})
keymap('n', '<leader>gc', telescope_builtin.git_commits, {})
keymap('n', '<leader>gb', telescope_builtin.git_branches, {})

keymap('n', '<leader>sd', telescope_builtin.diagnostics, {})

-- ==================
-- neogen
local neogen = require('neogen')
keymap('n', '<leader>ng', neogen.generate, opts)

-- DAP-UI
local dap_ui = require('dapui')
keymap("n", "<Leader>ddd", dap_ui.toggle, opts)
keymap("n", "<Leader>B", ":DapToggleBreakpoint<CR>", opts)
keymap("n", "<Leader>C", ":DapContinue<CR>", opts)
keymap("n", "<Leader>I", ":DapStepInto<CR>", opts)
keymap("n", "<Leader>O", ":DapStepOver<CR>", opts)

if not vim.g.vscode then
    -- ==================
    -- Lspsaga Keybindings --

    -- LSP finder - Find the symbol's definition
    -- If there is no definition, it will instead be hidden
    -- When you use an action in finder like "open vsplit",
    -- you can use <C-t> to jump back
    -- keymap("n", "gh", "<cmd>Lspsaga finder tyd+ref+imp+def <CR>")

    -- Code action
    keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

    -- Rename all occurrences of the hovered word for the entire file
    keymap("n", "<leader>re", "<cmd>Lspsaga rename<CR>")

    -- Peek definition
    -- You can edit the file containing the definition in the floating window
    -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
    -- It also supports tagstack
    -- Use <C-t> to jump back
    keymap("n", "<leader>pd", "<cmd>Lspsaga peek_definition<CR>")

    -- Go to definition
    -- keymap("n","gd", "<cmd>Lspsaga goto_definition<CR>")

    -- Peek type definition
    -- You can edit the file containing the type definition in the floating window
    -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
    -- It also supports tagstack
    -- Use <C-t> to jump back
    keymap("n", "<leader>pt", "<cmd>Lspsaga peek_type_definition<CR>")

    -- Show line diagnostics
    -- You can pass argument ++unfocus to
    -- unfocus the show_line_diagnostics floating window
    keymap("n", "<leader>ss", "<cmd>Lspsaga show_line_diagnostics<CR>")

    -- Show buffer diagnostics
    keymap("n", "<leader>sd", "<cmd>Lspsaga show_buf_diagnostics<CR>")

    -- Show workspace diagnostics
    keymap("n", "<leader>sa", "<cmd>Lspsaga show_workspace_diagnostics<CR>")

    -- Show cursor diagnostics
    keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

    -- Diagnostic jump
    -- You can use <C-o> to jump back to your previous location
    keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
    keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_next<CR>")

    -- Toggle outline
    keymap("n", "<leader>lo", "<cmd>Lspsaga outline<CR>")

    -- Hover Doc
    -- If there is no hover doc,
    -- there will be a notification stating that
    -- there is no information available.
    -- To disable it just use ":Lspsaga hover_doc ++quiet"
    -- Pressing the key twice will enter the hover window
    keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")

    -- Call hierarchy
    keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
    keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

    -- Floating terminal
    keymap({ "n", "t" }, "<D-d>", "<cmd>exe v:count1 . \"ToggleTerm\"<CR>")
    keymap({ "n", "t" }, "<M-d>", "<cmd>exe v:count1 . \"ToggleTerm\"<CR>")
    function SetTerminalKeymaps()
        local termopts = { buffer = 0 }
        vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
        keymap("t", "<esc>", [[<C-\><C-n>]], termopts)
        keymap("t", "<C-h>", [[<Cmd>wincmd h<CR>]], termopts)
        keymap("t", "<C-j>", [[<Cmd>wincmd j<CR>]], termopts)
        keymap("t", "<C-k>", [[<Cmd>wincmd k<CR>]], termopts)
        keymap("t", "<C-l>", [[<Cmd>wincmd l<CR>]], termopts)
        keymap("t", "<C-w>", [[<C-\><C-n><C-w>]], termopts)
    end

    vim.cmd('autocmd! TermOpen term://* lua SetTerminalKeymaps()')
end
