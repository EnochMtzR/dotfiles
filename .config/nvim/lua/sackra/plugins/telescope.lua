return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function ()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
					}
				}
			}
		})

		telescope.load_extension("fzf");

		local keymap = vim.keymap

		keymap.set("n", "<leader>pf", "<cmd>Telescope find_files<cr>", { desc = "Find files in cwd" })
		keymap.set("n", "<leader>fg", "<cmd>Telescope git_files<cr>", { desc = "Find files in cwd" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string in cwd" })
	end
}
