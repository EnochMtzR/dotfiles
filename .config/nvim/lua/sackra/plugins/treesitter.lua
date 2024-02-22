return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function ()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = { 
				"c",
				"cpp",
				"cmake",
				"make",
				"lua",
				"luadoc",
				"vim",
				"vimdoc",
				"javascript",
				"typescript",
				"tsx",
				"jsdoc",
				"json",
				"html",
				"css",
				"diff",
				"dockerfile",
				"c_sharp",
				"go",
				"python",
				"bash",
				"git_config",
				"git_rebase",
				"gitcommit",
				"gitignore",
				"markdown",
				"sql"
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end
}
