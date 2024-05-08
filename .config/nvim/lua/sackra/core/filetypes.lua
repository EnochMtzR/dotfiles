local api = vim.api

api.nvim_create_autocmd(
    { "BufEnter", "BufRead" },
    {
        pattern = { "*.component.html" },
        command = "set filetype=angular"
    })
