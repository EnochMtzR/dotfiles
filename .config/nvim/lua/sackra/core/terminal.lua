function openProjectTerminal()
    local util = require("lspconfig.util")
    --local projectFilePath = vim.fn.findfile("*.csproj", ".;")
    local projectFilePath = util.root_pattern("*csproj")(vim.fn.expand("%:p"))

    vim.cmd("silent !tmux split-window -c " .. projectFilePath)
end

local keymap = vim.keymap


keymap.set("n", "<leader>pt", openProjectTerminal, { desc = "Open terminal in current project" })
