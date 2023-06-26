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
            globals = {'vim', 'use', 'require'},
          },
          workspace = {
            -- Make server aware of neovim runtime library
            library = vim.api.nvim_get_runtime_file("", true),
          },
        },
      },
      on_attach = require('settings.lsp.handlers').on_attach,
      capabilities = require('settings.lsp.handlers').capabilities,
    }
  end,
  })

