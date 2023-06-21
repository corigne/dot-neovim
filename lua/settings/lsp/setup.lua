local status_ok, _ = pcall(require, "lspconfig")

if not status_ok then
  return
end

local lspconfig = require("lspconfig")
require("settings.lsp.handlers").setup()
require("mason-lspconfig").setup_handlers({
  function (server_name) -- automatically handles installed by Mason
    lspconfig[server_name].setup({
      on_attach = require('settings.lsp.handlers').on_attach,
      capabilities = require('settings.lsp.handlers').capabilities,
    })
  end,
  ["lua_ls"] = function ()
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
        },
      },
      on_attach = require('settings.lsp.handlers').on_attach,
      capabilities = require('settings.lsp.handlers').capabilities,
    }
  end,
})

