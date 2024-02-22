return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local lspconfig = require("lspconfig")

		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap

		local opts = { noremap = true, silent = true }
		local on_attach = function(clent, bufnr)
			opts.buffer = bufnr

			opts.desc = "Show LSP references"
			keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", function ()
				vim.diagnostic.open_float();
				vim.diagnostic.open_float();
			end, opts)

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

			opts.desc = "Show documentation for what is under the cursor"
			keymap.set("n", "<leader>h", function()
				-- call twice to focus window
				vim.lsp.buf.hover();
				vim.lsp.buf.hover();

				vim.defer_fn(function ()
					vim.cmd('norm! j') -- move cursor down to prevent the header from showing
				end, 30)
			end, opts)

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rlsp", ":LspRestart<CR>", opts)
		end

		local capabilities = cmp_nvim_lsp.default_capabilities()

		local signs = { Error = "⊗", Warn = "⚠", Hint = "🗲", Info = "🛈"  }

		lspconfig["clangd"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["cmake"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["tsserver"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["gopls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig["rust_analyzer"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

        lspconfig["helm_ls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig["pylsp"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig["html"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        lspconfig["cssls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})
	end,
}
