local api = vim.api

api.nvim_create_autocmd(
    "TextYankPost",
    {
        group = vim.api.nvim_create_augroup("highlight_yank", {}),
        desc = "Highlight yanked text",
        pattern = "*",
        callback = function()
            vim.highlight.on_yank({higroup = "IncSearch", timeout = 200})
        end,
    })

