return {
    "rest-nvim/rest.nvim",
    ft = "http",
    dependencies = {
        {
            "vhyrro/luarocks.nvim",
            priority = 1000,
            config = true,
        },
    },
    rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
    config = function()
        local rest = require("rest-nvim")
        local keymap = vim.keymap

        rest.setup()

        keymap.set("n", "<leader>rr", "<cmd>Rest run<cr>", { desc = "Run request under cursor" })
    end
}
