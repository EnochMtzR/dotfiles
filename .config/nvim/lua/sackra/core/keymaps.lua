vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("v", "<leader>(", "c()<Esc>Pf)%", { desc = "Surround selection in parenthesis and set cursor at beginning" })
keymap.set("v", "<leader>)", "c()<Esc>Pf)", { desc = "Surround selection in parenthesis and set cursor at end" })
keymap.set("v", "<leader>\"", "c\"\"<Esc>Pf\"", { desc = "Surround selection in quotes" })
keymap.set("v", "<leader>[", "c[]<Esc>Pf]%", { desc = "Surround selection in brackets and set cursor at beginning" })
keymap.set("v", "<leader>]", "c[]<Esc>Pf]", { desc = "Surround selection in brackets and set cursor at end" })
keymap.set("v", "<leader>{", "c{}<Esc>Pf}%", { desc = "Surround selection in braces and set cursor at beginning" })
keymap.set("v", "<leader>}", "c{}<Esc>Pf}", { desc = "Surround selection in braces and set cursor at end" })

keymap.set("n", "<leader>y", "\"+y", { desc = "Yank to clipboard" })
keymap.set("v", "<leader>y", "\"+y", { desc = "Yank to clipboard" })
keymap.set("n", "<leader>Y", "\"+y", { desc = "Yank to clipboard" })

keymap.set("n", "<leader>d", "\"_d", { desc = "delete without afecting paste buffer" })
keymap.set("v", "<leader>d", "\"_d", { desc = "delete without afecting paste buffer" })

keymap.set("v", "<leader>p", "\"_dP", { desc = "Paste but keep current paste buffer" })

keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line down" })
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line up" })

keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Control + d but always centered" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Control + u but always centered" })
keymap.set("n", "n", "nzzzv", { desc = "keep search selection in the middle when searching" })
keymap.set("n", "N", "Nzzzv", { desc = "keep search selection in the middle when searching" })

keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { silent= true, desc = "Open tmux sessionizer" })

keymap.set("n", "<leader>x", "<cmd>silent !chmod +x %<CR>", { silent= true, desc = "Make file executable" })

-- Open bottom terminal and set input mode
keymap.set("n", "<leader>t", function()
	vim.cmd("belowright sp")
	vim.cmd("resize 10")
	vim.cmd("terminal")
	vim.cmd("startinsert!")
end, { desc = "Open terminal in horizontal split"})

keymap.set("t", "<C-q>", function()
	vim.api.nvim_input("<C-\\><C-n>")
	vim.cmd("q")
end, { desc = "Close terminal in terminal mode" })

keymap.set("n", "Q", "<nop>")
