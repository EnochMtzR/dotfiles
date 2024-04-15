return {
	"ThePrimeagen/harpoon",
    branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
        local harpoon = require("harpoon")

        harpoon:setup()

		local keymap = vim.keymap

		keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Add file to harpoon" })
        keymap.set("n", "<C-h>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Open harpoon list menu" })

        keymap.set("n", "<leader>sn", function() harpoon:list():replace_at(1) end, { desc = "replace file in position 1" })
        keymap.set("n", "<leader>se", function() harpoon:list():replace_at(2) end, { desc = "replace file in position 2" })
        keymap.set("n", "<leader>si", function() harpoon:list():replace_at(3) end, { desc = "replace file in position 3" })
        keymap.set("n", "<leader>s/", function() harpoon:list():replace_at(4) end, { desc = "replace file in position 4" })

		keymap.set("n", "<C-n>", function () harpoon:list():select(1) end, { desc = "Go to file #1" })
		keymap.set("n", "<C-e>", function () harpoon:list():select(2) end, { desc = "Go to file #2" })
		keymap.set("n", "<C-i>", function () harpoon:list():select(3) end, { desc = "Go to file #3" })
		keymap.set("n", "<C-/>", function () harpoon:list():select(4) end, { desc = "Go to file #4" })
	end
}
