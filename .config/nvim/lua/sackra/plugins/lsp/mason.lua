return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local mason = require("mason")

        local mason_lspconfig = require("mason-lspconfig")

        mason.setup({
            ui = {
                icons = {
                    package_installed = "✔",
                    package_pending = "⏲",
                    package_uninstalled = "✗",
                }
            }
        })

        mason_lspconfig.setup({
            ensure_installed = {
                "clangd",
                "cmake",
                "ts_ls",
                "rust_analyzer",
                "lua_ls",
                "helm_ls",
                "pylsp",
                "angularls",
                "tailwindcss",
                "cssls",
            },
            automatic_installation = true,
            automatic_enable = {
                exclude = {
                    "clangd",
                    "cmake",
                    "ts_ls",
                    "rust_analyzer",
                    "lua_ls",
                    "helm_ls",
                    "pylsp",
                    "angularls",
                    "tailwindcss",
                    "cssls",
                }
            }
        })
    end,
}
