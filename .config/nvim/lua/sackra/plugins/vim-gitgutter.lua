return {
    "airblade/vim-gitgutter",
    config = function()
        vim.cmd("GitGutterLineNrHighlightsToggle")

        vim.keymap.set('n', 'gl', ':GitGutterLineNrHighlightsToggle<CR>',
            { desc = "Toggle gitgutter line number highlights" })
        vim.keymap.set('n', 'gh', ':GitGutterLineHighlightsToggle<CR>', { desc = "Toggle gitgutter line highlights" })
        vim.keymap.set('n', 'gn', ':GitGutterNextHunk<CR>', { desc = "Go to next git hunk" })
        vim.keymap.set('n', 'gp', ':GitGutterPrevHunk<CR>', { desc = "Go to previous git hunk" })
    end,
}
