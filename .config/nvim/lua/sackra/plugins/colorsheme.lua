return {
	"Mofiqul/vscode.nvim",
	config = function()
        vim.o.background = "dark";

        local vscode = require('vscode')

        vscode.setup({
            italic_comments = true,
            underline_links = true,
            disable_nvim_tree_bg = true,
        })

        vscode.load()
	end
}
