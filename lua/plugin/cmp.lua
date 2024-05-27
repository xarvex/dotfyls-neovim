return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "onsails/lspkind.nvim",
        "rafamadriz/friendly-snippets",
        "saadparwaiz1/cmp_luasnip"
    },
    event = { "CmdlineEnter", "InsertEnter" },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()

        require("lsp-zero").extend_cmp()

        require("cmp").setup({
            entries = { name = "custom", selection_order = "near_cursor" },
            formatting = { format = require("lspkind").cmp_format() },
            mapping = {
                ["<C-k>"] = require("cmp").mapping.select_prev_item(),
                ["<C-j>"] = require("cmp").mapping.select_next_item(),
                ["<CR>"] = require("cmp").mapping({
                    i = function(fallback)
                        local opts

                        if require("cmp").visible() then
                            if #require("cmp").get_entries() == 1 then
                                opts = { select = true }
                            elseif require("cmp").get_selected_entry() then
                                opts = { select = false, behavior = require("cmp").ConfirmBehavior.Replace }
                            end
                        end

                        if opts then require("cmp").confirm(opts) else fallback() end
                    end,
                    s = require("cmp").mapping.confirm({ select = true }),
                    c = require("cmp").mapping.confirm({
                        select = true,
                        behavior = require("cmp").ConfirmBehavior.Replace
                    })
                })
            },
            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "path" },
                { name = "buffer" }
            },
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end
            }
        })
    end
}
