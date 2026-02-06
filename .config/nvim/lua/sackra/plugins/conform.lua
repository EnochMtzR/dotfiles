return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				yaml = { "yamlfmt" },
				javascript = { "prettier", lsp_format = "fallback" },
				typescript = { "prettier", lsp_format = "fallback" },
			},
		})
	end,
}
