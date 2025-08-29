return {
    "catgoose/nvim-colorizer.lua",
    priority = 2000,
    config = function()
        require("colorizer").setup({
            tailwind = 'both',
            tailwind_opts = {
                update_names = false,
            },
            filetypes = {
                "*",
                cmp_menu = {
                    always_update = true,
                },
                cmp_docs = {
                    always_update = true,
                },
            }
        });
    end,
}
