return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local lualine = require('lualine')
        local vscode_theme = require('lualine.themes.vscode')
        local function get_tabsize()
            return "⭾ " .. vim.opt.tabstop:get()
        end


        lualine.setup {
            options = {
                section_separators = { left = '', right = '' },
                component_separators = { left = '|', right = '|' },
                theme = vscode_theme,
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = { 'filename' },
                lualine_x = { 'encoding', 'fileformat', 'filetype', get_tabsize },
                lualine_y = { 'progress' },
                lualine_z = { 'location' }
            },
        }
    end
}
