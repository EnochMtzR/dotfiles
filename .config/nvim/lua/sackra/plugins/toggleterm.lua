return {
	"akinsho/toggleterm.nvim",
	config = function()
		vim.keymap.set("n", "<leader>to", ":ToggleTerm<CR>", { desc = "Toggle terminal" })
		vim.keymap.set("n", "<leader>tc", ":ToggleTerm<CR>", { desc = "Toggle terminal" })
		vim.keymap.set("n", "<A-t>", ":TermNew<CR>", { desc = "New terminal" })
		vim.keymap.set("n", "<C-A-t>", ":TermSelect<CR>", { desc = "Select terminal" })
		vim.keymap.set("n", "<leader>tn", ":ToggleTermSetName<CR>", { desc = "Set terminal name" })

		local Terminal = require("toggleterm.terminal").Terminal
		local agent = Terminal:new({
			cmd = "gemini",
			display_name = "agent",
			hidden = true,
		})

		function agent_toggle()
			agent:toggle(60, "vertical")
		end

		-- Agent keymaps
		vim.keymap.set("n", "<leader>ao", "<cmd>lua agent_toggle()<CR>", { desc = "Toggle agent terminal" })
		vim.keymap.set("n", "<leader>ac", "<cmd>lua agent_toggle()<CR>", { desc = "Toggle agent terminal" })

		require("toggleterm").setup({
			close_on_exit = true,
		})
	end,
}
