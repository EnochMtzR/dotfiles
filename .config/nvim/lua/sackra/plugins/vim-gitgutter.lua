return {
    "airblade/vim-gitgutter",
    config = function()
        vim.cmd("GitGutterLineNrHighlightsToggle")

        vim.keymap.set('n', 'gn', ':GitGutterLineNrHighlightsToggle<CR>',
            { desc = "Toggle gitgutter line number highlights" })
        vim.keymap.set('n', 'gh', ':GitGutterLineHighlightsToggle<CR>', { desc = "Toggle gitgutter line highlights" })
    end,
}
