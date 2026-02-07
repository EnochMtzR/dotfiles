return {
	"EnochMtzR/vscode.nvim",
	config = function()
		vim.o.background = "dark"

		local vscode = require("vscode")

		vscode.setup({
			italic_comments = true,
			underline_links = true,
			disable_nvim_tree_bg = true,
		})

		vim.api.nvim_set_hl(0, "@lsp.typemod.variable.defaultLibrary", { link = "Constant" })

		vscode.load()
	end,
}
