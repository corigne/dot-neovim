local dap_ok, dap = pcall(require, "dap")
if not (dap_ok) then
  print("nvim-dap not installed!")
  return
end

-- for debugging whacky dap stuff, :DapShowLog

require('dap').set_log_level('INFO')
require('dapui').setup()
