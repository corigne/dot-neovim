require('settings/plugins')
require('settings/core')
require('settings/keymap')
require('settings/lsp')

-- Plugin Configuration
require('nvim-tree').setup()
require('lualine').setup()
require('nvim-treesitter.configs').setup {
  ensure_installed = { "c", "lua", "vim", "query", "cpp", "go", "rust",
    "typescript", "javascript", "svelte", "css" },
  sync_install = false,
  auto_install = false,
  ignore_install = { "" },

  highlight = {
    enable = true,

    disable = function(lang, buf)
        local max_filesize = 200 * 1024 -- 200 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    additional_vim_regex_highlighting = true,
  },
}

print 'All configurations loaded successfully.'
