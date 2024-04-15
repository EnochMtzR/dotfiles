return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
        local lualine = require('lualine')
        local vscode_theme = require('lualine.themes.vscode')

        lualine.setup {
            options = {
                -- section_separators = { left = '', right = '' },
                -- component_separators = { left = '|', right = '|' },
                theme = vscode_theme,
            },
        }
    end
}
