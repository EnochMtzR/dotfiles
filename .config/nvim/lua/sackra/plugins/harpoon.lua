return {
	"ThePrimeagen/harpoon",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local mark = require("harpoon.mark")
		local ui = require("harpoon.ui")
		local keymap = vim.keymap

		keymap.set("n", "<leader>a", mark.add_file, { desc = "Add file to harpoon" })
		keymap.set("n", "<C-h>", ui.toggle_quick_menu, { desc = "Add file to harpoon" })

		keymap.set("n", "<C-n>", function () ui.nav_file(1) end, { desc = "add file to harpoon" })
		keymap.set("n", "<C-e>", function () ui.nav_file(2) end, { desc = "Add file to harpoon" })
		keymap.set("n", "<C-i>", function () ui.nav_file(3) end, { desc = "Add file to harpoon" })
		keymap.set("n", "<C-;>", function () ui.nav_file(1) end, { desc = "Add file to harpoon" })
	end
}
