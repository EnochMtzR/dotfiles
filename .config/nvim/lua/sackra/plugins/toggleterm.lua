return {
    "akinsho/toggleterm.nvim",
    config = function()
        vim.keymap.set("n", "<leader>t", ":ToggleTerm<CR>", { desc = "Toggle terminal" })

        require("toggleterm").setup {
        }
    end,
}
