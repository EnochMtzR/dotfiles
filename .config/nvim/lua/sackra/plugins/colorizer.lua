return {
    "chrisbra/Colorizer",
    priority = 2000,
    config = function()
        print("Loading Colorizer")
        vim.cmd.ColorHighlight()
    end,
}
