local dap_ok, dap = pcall(require, "dap")
if not (dap_ok) then
  print("nvim-dap not installed!")
  return
end

-- for debugging whacky dap stuff, :DapShowLog
--

-- Auto-load project-local dap config if it exists
local project_dap = vim.fn.getcwd() .. '/.nvim/dap.lua'
if vim.fn.filereadable(project_dap) == 1 then
  dofile(project_dap)
end

-- Wrapping in Dap Windows
vim.api.nvim_create_autocmd("BufWinEnter", {
  desc = "Set options on DAP windows",
  group = vim.api.nvim_create_augroup("set_dap_win_options", { clear = true }),
  pattern = { 
    "\\[dap-repl\\]", 
    "\\[dap-repl-*\\]"
  --, "DAP *"
},
  callback = function(args)
    local win = vim.fn.bufwinid(args.buf)
    vim.schedule(function()
      if not vim.api.nvim_win_is_valid(win) then return end
      vim.api.nvim_set_option_value("wrap", true, { win = win })
      vim.api.nvim_set_option_value("number", true, { win = win })
      vim.api.nvim_set_option_value("relativenumber", true, { win = win })
    end)
  end,
})

require('dap-go').setup()
require("nvim-dap-virtual-text").setup()

local dapui = require('dapui')
dapui.setup()

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
