local linter = require('lint')

linter.linters_by_ft = {
    cpp = {'clangtidy'},
    javascript = {'eslint'},
    typescript = {'eslint'},
}

vim.api.nvim_create_autocmd({ "BufWritePost" } , {
    callback = function()
        linter.try_lint()
    end,
})
