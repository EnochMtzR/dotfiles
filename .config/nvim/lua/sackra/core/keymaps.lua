vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("v", "<leader>(", "c()<Esc>Pf)%", { desc = "Surround selection in parenthesis and set cursor at beginning" })
keymap.set("v", "<leader>)", "c()<Esc>Pf)", { desc = "Surround selection in parenthesis and set cursor at end" })
keymap.set("v", "<leader>\"", "c\"\"<Esc>Pf\"", { desc = "Surround selection in quotes" })
keymap.set("v", "<leader>[", "c[]<Esc>Pf]%", { desc = "Surround selection in brackets and set cursor at beginning" })
keymap.set("v", "<leader>]", "c[]<Esc>Pf]", { desc = "Surround selection in brackets and set cursor at end" })
keymap.set("v", "<leader>{", "c{}<Esc>Pf}%", { desc = "Surround selection in braces and set cursor at beginning" })
keymap.set("v", "<leader>}", "c{}<Esc>Pf}", { desc = "Surround selection in braces and set cursor at end" })

keymap.set("n", "<leader>y", "\"+y", { desc = "Yank to clipboard with motions" })
keymap.set("v", "<leader>y", "\"+y", { desc = "Yank to clipboard" })

keymap.set("n", "<leader>d", "\"_d", { desc = "delete without afecting paste buffer" })
keymap.set("v", "<leader>d", "\"_d", { desc = "delete without afecting paste buffer" })

keymap.set("v", "<leader>p", "\"_dP", { desc = "Paste but keep current paste buffer" })

keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line down" })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line up" })

keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Control + d but always centered" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Control + u but always centered" })
keymap.set("n", "n", "nzzzv", { desc = "keep search selection in the middle when searching" })
keymap.set("n", "N", "Nzzzv", { desc = "keep search selection in the middle when searching" })

keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { silent = true, desc = "Open tmux sessionizer" })
keymap.set("n", "<leader>w", "<cmd>silent !tmux neww tmux-windowizer<CR>",
    { silent = true, desc = "Open tmux windowizer" })

keymap.set("n", "<leader>x", "<cmd>silent !chmod +x %<CR>", { silent = true, desc = "Make file executable" })

keymap.set("n", "<leader>e", "<cmd>NvimTreeFindFile<CR>", { desc = "Toggle file explorer on current file" })

keymap.set("n", "<C-j>", "<cmd>cnext<CR>", { desc = "Next quickfix" })
keymap.set("n", "<C-k>", "<cmd>cprev<CR>", { desc = "Next quickfix" })

keymap.set("n", "Q", "<nop>")

keymap.set("n", "<leader>so", function()
    print("Sourcing init.lua")

    local initFile = vim.fn.stdpath("config") .. "/init.lua"
    vim.cmd.source(initFile)
end, { desc = "Source init.lua" })

keymap.set("n", "<C-q>", ":q<CR>", { desc = "Quit" })

keymap.set("n", "<A-k>", "<C-w>+", { desc = "Increase window height" })
keymap.set("n", "<A-j>", "<C-w>-", { desc = "Decrease window height" })
keymap.set("n", "<A-h>", "<C-w><", { desc = "Decrease window width" })
keymap.set("n", "<A-l>", "<C-w>>", { desc = "Increase window width" })

keymap.set("t", "<C-Esc>", "<C-\\><C-n>", { desc = "Normal mode in terminal" })
