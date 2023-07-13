-- KEYMAP SETTINGS

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Clear Search HL
keymap('n', '<leader>\\', ':nohl<CR><C-l>', { silent = true })

-- Strip Whitespace
keymap('n', '<leader>ss', ':StripWhitespace<CR>', {})

-- Buffers
keymap('n', '<leader>bn', ':bn<CR>', {})
keymap('n', '<leader>bp', ':bp<CR>', {})
keymap('n', '<leader>q', ':BufferClose<CR>', {})
keymap('n', '<leader>bD', ':ls<CR>:bd<Space>', {})
keymap('n', '<leader>bc', ':ls<CR>:b<Space>', {})
keymap('n', '<leader>bl', ':ls<CR>', {})

-- Clipboard
keymap('n', '<leader>y', '<Plug>OSCYankOperator', {})
keymap('n', '<leader>yy', '<leader>y_', {})
keymap('v', '<leader>y', '<Plug>OSCYankVisual', {})

-- Tabs
keymap('n', '<leader>td', ':tabc<CR>', {})   -- Delete Tab

-- nvim-tree
keymap('n', '<leader>tt', ':NvimTreeToggle<CR>', { silent = true})
keymap('n', '<leader>tf', ':NvimTreeFindFile<CR>', {})
keymap('n', '<leader>tc', ':NvimTreeCollapse<CR>', {})

-- Telescope
local builtin = require('telescope.builtin')
keymap('n', '<leader>ff', builtin.find_files, {})
keymap('n', '<leader>fg', builtin.live_grep, {})
keymap('n', '<leader>fb', builtin.buffers, {})
keymap('n', '<leader>fh', builtin.help_tags, {})

-- barbar Keybindings

-- Move to previous/next
keymap('n', ',', '<Cmd>BufferPrevious<CR>', opts)
keymap('n', '.', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next
keymap('n', '<M-,>', '<Cmd>BufferMovePrevious<CR>', opts)
keymap('n', '<M-.>', '<Cmd>BufferMoveNext<CR>', opts)
-- Goto buffer in position...
keymap('n', '<M-1>', '<Cmd>BufferGoto 1<CR>', opts)
keymap('n', '<M-2>', '<Cmd>BufferGoto 2<CR>', opts)
keymap('n', '<M-3>', '<Cmd>BufferGoto 3<CR>', opts)
keymap('n', '<M-4>', '<Cmd>BufferGoto 4<CR>', opts)
keymap('n', '<M-5>', '<Cmd>BufferGoto 5<CR>', opts)
keymap('n', '<M-6>', '<Cmd>BufferGoto 6<CR>', opts)
keymap('n', '<M-7>', '<Cmd>BufferGoto 7<CR>', opts)
keymap('n', '<M-8>', '<Cmd>BufferGoto 8<CR>', opts)
keymap('n', '<M-9>', '<Cmd>BufferGoto 9<CR>', opts)
keymap('n', '<M-0>', '<Cmd>BufferLast<CR>', opts)
-- Pin/unpin buffer
keymap('n', '<M-p>', '<Cmd>BufferPin<CR>', opts)
-- Close buffer
keymap('n', '<M-c>', '<Cmd>BufferClose<CR>', opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
keymap('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)

-- Lspsaga Keybindings --

-- LSP finder - Find the symbol's definition
-- If there is no definition, it will instead be hidden
-- When you use an action in finder like "open vsplit",
-- you can use <C-t> to jump back
keymap("n", "gh", "<cmd>Lspsaga finder tyd+ref+imp+def <CR>")

-- Code action
keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

-- Rename all occurrences of the hovered word for the entire file
keymap("n", "gr", "<cmd>Lspsaga rename<CR>")

-- Peek definition
-- You can edit the file containing the definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>")

-- Go to definition
keymap("n","gd", "<cmd>Lspsaga goto_definition<CR>")

-- Peek type definition
-- You can edit the file containing the type definition in the floating window
-- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
-- It also supports tagstack
-- Use <C-t> to jump back
keymap("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")

-- Show line diagnostics
-- You can pass argument ++unfocus to
-- unfocus the show_line_diagnostics floating window
keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

-- Show buffer diagnostics
keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

-- Show workspace diagnostics
keymap("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>")

-- Show cursor diagnostics
keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

-- Diagnostic jump
-- You can use <C-o> to jump back to your previous location
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

-- Toggle outline
keymap("n","<leader>o", "<cmd>Lspsaga outline<CR>")

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
keymap({"n", "t"}, "<M-d>", "<cmd>Lspsaga term_toggle<CR>")

-- DAP-UI
local dap_ui = require('dapui')
keymap("n", "<Leader>ddd", dap_ui.toggle, opts)
keymap("n", "<Leader>db", ":DapToggleBreakpoint<CR>", opts)
keymap("n", "<Leader>dc", ":DapContinue<CR>", opts)
keymap("n", "<Leader>ds", ":DapStepInto<CR>", opts)
keymap("n", "<Leader>dn", ":DapStepOver<CR>", opts)
