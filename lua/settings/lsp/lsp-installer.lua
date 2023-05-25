require("nvim-lsp-installer").setup {}
local lspconfig = require("lspconfig")
local opts = {
  on_attach = require('settings.lsp.handlers').on_attach,
  capabilities = require('settings.lsp.handlers').capabilities,
}
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
lspconfig.tsserver.setup(opts)
lspconfig.clangd.setup(opts)
lspconfig.cssls.setup(opts)
lspconfig.jedi_language_server.setup(opts)
lspconfig.svelte.setup(opts)
lspconfig.pylsp.setup(opts)
lspconfig.omnisharp.setup(opts)
lspconfig.remark_ls.setup(opts)

