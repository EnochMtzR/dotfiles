return {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
        vim.keymap.set('n', 'zO', require('ufo').openAllFolds)
        vim.keymap.set('n', 'zC', require('ufo').closeAllFolds)

        require('ufo').setup({
            close_fold_kinds_for_ft = {
                default = { 'imports', 'comment' }
            },
        })
    end,
}
