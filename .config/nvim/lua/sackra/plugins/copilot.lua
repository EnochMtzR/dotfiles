vim.keymap.set("n", "<leader>cd", function()
    vim.cmd("Copilot disable")
    print("Copilot disabled");
end, { desc = "Disable Copilot" })

vim.keymap.set("n", "<leader>ce", function()
    vim.cmd("Copilot enable")
    print("Copilot enabled");
end, { desc = "Enable Copilot" })

vim.keymap.set("n", "<leader>cs", function()
    vim.cmd("Copilot status")
end, { desc = "Check Copilot status" })

return {
    "github/copilot.vim"
}
