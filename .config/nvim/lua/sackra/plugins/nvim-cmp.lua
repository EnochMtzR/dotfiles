return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "rafamadriz/friendly-snippets",
    },
    config = function()
        local cmp = require("cmp")

        local luasnip = require("luasnip")

        local lspkind = require("lspkind")

        local function extract_color(s)
            local base, _, _, r, g, b = 10, s:find("rgba?%((%d+).%s*(%d+).%s*(%d+)")

            if not r then
                base, _, _, r, g, b = 16, s:find("#(%x%x)(%x%x)(%x%x)")
            end

            if r then return tonumber(r, base), tonumber(g, base), tonumber(b, base) end
        end

        local function set_hl_from(red, green, blue, style)
            local suffix = style == "background" and "Bg" or "Fg"
            local color = string.format("%02x%02x%02x", red, green, blue)
            local hl_name = "TailwindColor" .. suffix .. color
            local opts

            if style == "background" then
                -- https://stackoverflow.com/questions/3942878
                local luminance = red * 0.299 + green * 0.587 + blue * 0.114
                local fg = luminance > 186 and "#000000" or "#FFFFFF"
                opts = { fg = fg, bg = "#" .. color }
            else
                opts = { fg = "#" .. color }
            end

            if not vim.api.nvim_get_hl(0, { name = hl_name })[1] then
                vim.api.nvim_set_hl(0, hl_name, opts)
            end

            return hl_name
        end

        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            completion = {
                completeopt = "menu,menuone,preview,noselect",
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-q>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            }),
            formatting = {
                format = lspkind.cmp_format({
                    mode = "symbol_text",
                    maxwidth = 50,
                    ellipsis_char = "...",
                    before = function(entry, vim_item)
                        -- local doc = entry.completion_item.documentation
                        --
                        -- if vim_item.kind == "Color" then
                        -- local content = type(doc) == "string" and doc or (doc and doc.value) or nil
                        -- if content then
                        -- local r, g, b = extract_color(content)
                        -- if r and g and b then
                        -- set_hl_from(r, g, b, "foreground")
                        -- end
                        -- end
                        -- end

                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snippet]",
                            buffer = "[Buffer]",
                            path = "[Path]",
                        })[entry.source.name]
                        return vim_item
                    end,
                }),
            },
        })
    end,
}
