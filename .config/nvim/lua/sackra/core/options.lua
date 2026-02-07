local opt = vim.opt

vim.cmd.highlight("DiagnosticUnderlineError guisp=#ff0000 gui=undercurl")

opt.number = true
opt.relativenumber = true

opt.autoread = true

opt.expandtab = true

opt.smartindent = true

opt.wrap = false

opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

opt.hlsearch = false
opt.incsearch = true

opt.termguicolors = true

opt.scrolloff = 8
opt.signcolumn = "yes"
opt.isfname:append("@-@")

opt.colorcolumn = "120"

vim.opt.updatetime = 50

opt.cursorline = true
