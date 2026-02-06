return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local toggle_lsp_utils = require("sackra.plugins.lsp.utils.toggle-lsp")

		local keymap = vim.keymap

		local opts = { noremap = true, silent = true }

		local function should_attach(client, bufnr)
			return not toggle_lsp_utils.is_manually_detached(client.name, bufnr)
		end

		local on_attach = function(client, bufnr)
			-- Check if this LSP was manually detached for this buffer
			print(client.name .. " attached to buffer " .. bufnr)
			if not should_attach(client, bufnr) then
				vim.lsp.buf_detach_client(bufnr, client.id)
				return
			end

			opts.buffer = bufnr

			keymap.set("n", "<leader>lr", "<cmd>LspRestart<CR>", opts)

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
			keymap.set("n", "<leader>i", function()
				vim.diagnostic.open_float()
				vim.diagnostic.open_float()
			end, opts)

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

			opts.desc = "Show documentation for what is under the cursor"

			vim.api.nvim_create_augroup("lsphover", {})

			keymap.set("n", "<leader>hf", function()
				local cursor = vim.api.nvim_win_get_cursor(0)

				vim.cmd("execute 'normal F(h'")

				vim.lsp.buf.hover()
				vim.lsp.buf.hover()

				vim.api.nvim_create_autocmd("WinLeave", {
					group = "lsphover",
					desc = "On hover window closed",
					pattern = "*",
					callback = function()
						vim.api.nvim_win_set_cursor(0, cursor)

						vim.cmd("au! lsphover")
					end,
				})
			end, opts)

			keymap.set("n", "<leader>ho", function()
				-- call twice to focus window
				vim.lsp.buf.hover()
				vim.lsp.buf.hover()

				vim.api.nvim_create_autocmd("WinEnter", {
					group = "lsphover",
					desc = "On hover window open",
					pattern = "*",
					callback = function()
						vim.cmd("execute 'normal j'")

						vim.cmd("au! lsphover")
					end,
				})
			end, opts)

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rlsp", ":LspRestart<CR>", opts)
		end

		local capabilities = cmp_nvim_lsp.default_capabilities()

		capabilities.textDocument.foldingRange = {
			dynamicRegistration = false,
			lineFoldingOnly = true,
		}

		local signs = { Error = "⊗", Warn = "⚠", Hint = "🗲", Info = "🛈" }

		vim.lsp.enable("clangd", {
			capabilities = capabilities,
			on_attach = on_attach,
			root_dir = vim.fs.root("Makefile", ".git"),
		})

		vim.lsp.enable("asm_lsp", {
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = { "asm-lsp" },
			filetypes = { "asm", "s", "S" },
			root_dir = vim.fs.root(".asm-lsp.toml", "Makefile", ".git"),
			init_options = {},
			settings = {},
		})

		vim.lsp.enable("cmake", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		vim.lsp.enable("ts_ls", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		vim.lsp.enable("angularls", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		vim.lsp.enable("tailwindcss", {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				tailwindCSS = {
					experimental = {
						classRegex = {
							{ "\\w*class:\\s*([^,}]*)[,}]", "['\"`]([^'\"`]*).*?['\"`]" },
							{ "\\w*ngClass:\\s*([^,}]*)[,}]", "['\"`]([^'\"`]*).*?['\"`]" },
							{ "\\w*classList.add([^);]*)[);]", "['\"`]([^'\"`]*).*?['\"`]" },
							{ "\\w*[tT]wStyles\\s*=([^;]*);", "['\"`]([^'\"`]*).*?['\"`]" },
							{ "\\w*[vV]ariants([^;]*);", "['\"`]([^'\"`]*).*?['\"`]" },
							{ "\\w*[aA]nimation([^;,}]*)[,;}]", "['\"`]([^'\"`]*).*?['\"`]" },
							{ "\\w*[tT]wSize([^;,}]*)[,;}]", "['\"`]([^'\"`]*).*?['\"`]" },
						},
					},
				},
			},
		})

		vim.lsp.enable("gopls", {
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = { "gopls" },
			filetypes = { "go", "gomod", "gowork", "gotmpl" },
			root_dir = vim.fs.root("go.work", "go.mod", ".git"),
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
					},
					staticcheck = true,
				},
			},
		})

		vim.lsp.enable("rust_analyzer", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		vim.lsp.enable("helm_ls", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		vim.lsp.enable("pylsp", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		vim.lsp.enable("html", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		vim.lsp.enable("emmet_language_server", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		vim.lsp.enable("cssls", {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				css = {
					validate = true,
					lint = {
						unknownAtRules = "ignore",
					},
				},
				scss = {
					validate = true,
					lint = {
						unknownAtRules = "ignore",
					},
				},
				less = {
					validate = true,
					lint = {
						unknownAtRules = "ignore",
					},
				},
			},
		})

		vim.lsp.enable("bashls", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		require("roslyn").setup({
			log_level = "info",
			dotnet_cmd = "dotnet",
			capabilities = capabilities,
			on_attach = on_attach,
		})

		vim.lsp.enable("lua_ls", {
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
