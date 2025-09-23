return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = {
        "angular",
        "c",
        "cpp",
        "cmake",
        "make",
        "lua",
        "luadoc",
        "vim",
        "vimdoc",
        "javascript",
        "typescript",
        "tsx",
        "jsdoc",
        "json",
        "html",
        "http",
        "css",
        "diff",
        "dockerfile",
        "c_sharp",
        "go",
        "python",
        "bash",
        "git_config",
        "git_rebase",
        "gitcommit",
        "gitignore",
        "markdown",
        "markdown_inline",
        "sql",
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },
    })

    vim.treesitter.language.register('http', 'http')
  end
}
