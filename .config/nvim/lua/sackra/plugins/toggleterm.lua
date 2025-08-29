return {
    "akinsho/toggleterm.nvim",
    config = function()
        vim.keymap.set("n", "<leader>to", ":ToggleTerm<CR>", { desc = "Toggle terminal" })
        vim.keymap.set("n", "<leader>tc", ":ToggleTerm<CR>", { desc = "Toggle terminal" })
        vim.keymap.set("n", "<A-t>", ":TermNew<CR>", { desc = "New terminal" })
        vim.keymap.set("n", "<C-A-t>", ":TermSelect<CR>", { desc = "Select terminal" })
        vim.keymap.set("n", "<leader>tn", ":ToggleTermSetName<CR>", { desc = "Set terminal name" })

        require("toggleterm").setup {
            close_on_exit = true,
        }
    end,
}
