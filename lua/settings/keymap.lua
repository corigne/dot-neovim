
-- Clear Search HL
vim.api.nvim_set_keymap('n', '<leader>\\', ':nohl<CR><C-l>', { silent = true })

-- Buffers
vim.api.nvim_set_keymap('n', '<leader>bn', ':bn<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>bp', ':bp<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>bd',  '<Cmd>lua CloseBuffer(0)<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>bD', ':ls<CR>:bd<Space>', {})
vim.api.nvim_set_keymap('n', '<leader>bc', ':ls<CR>:b<Space>', {})
vim.api.nvim_set_keymap('n', '<leader>bl', ':ls<CR>', {})

-- Clipboard
vim.api.nvim_set_keymap('n', '<leader>y', '<Plug>OSCYankOperator', {})
vim.api.nvim_set_keymap('n', '<leader>yy', '<leader>y_', {})
vim.api.nvim_set_keymap('v', '<leader>y', '<Plug>OSCYankVisual', {})

-- Tabs
vim.api.nvim_set_keymap('n', '<leader>td', ':tabc<CR>', {})   -- Delete Tab

-- nvim-tree
vim.api.nvim_set_keymap('n', '<leader>tt', ':NvimTreeToggle<CR>', { silent = true})
vim.api.nvim_set_keymap('n', '<leader>tf', ':NvimTreeFindFile<CR>', {})
vim.api.nvim_set_keymap('n', '<leader>tc', ':NvimTreeCollapse<CR>', {})

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
