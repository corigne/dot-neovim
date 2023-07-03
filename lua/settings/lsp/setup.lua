local status_ok, _ = pcall(require, "lspconfig")

if not status_ok then
  return
end

local lspconfig = require("lspconfig")
require("mason-lspconfig").setup_handlers({

  function (server_name) -- automatically handles installed by Mason
    lspconfig[server_name].setup({
    })
  end,

  ["lua_ls"] = function ()
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = {'vim', 'use', 'require'},
          },
        },
      },
    }
  end,
  })

