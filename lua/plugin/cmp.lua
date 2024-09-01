return {
    "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "onsails/lspkind.nvim",
        "rafamadriz/friendly-snippets",
        "saadparwaiz1/cmp_luasnip",
    },
    event = { "CmdlineEnter", "InsertEnter" },
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()

        local cmp_action = require("lsp-zero").cmp_action()

        local function fallback_confirm(fallback)
            local opts

            if require("cmp").visible() then
                if #require("cmp").get_entries() == 1 then
                    opts = { select = true }
                elseif require("cmp").get_selected_entry() then
                    opts = { select = false, behavior = require("cmp").ConfirmBehavior.Replace }
                end
            end

            if opts then
                require("cmp").confirm(opts)
            else
                fallback()
            end
        end
        local mapping = {
            ["<C-k>"] = require("cmp").mapping(require("cmp").mapping.select_prev_item(), { "i", "c" }),
            ["<C-j>"] = require("cmp").mapping(require("cmp").mapping.select_next_item(), { "i", "c" }),
            ["<CR>"] = require("cmp").mapping({
                i = fallback_confirm,
                c = fallback_confirm,
                s = require("cmp").mapping.confirm({ select = true }),
            }),
            ["<S-Tab>"] = cmp_action.luasnip_jump_backward(),
            ["<Tab>"] = cmp_action.luasnip_jump_forward(),
        }
        require("cmp").setup({
            entries = { name = "custom", selection_order = "near_cursor" },
            formatting = { format = require("lspkind").cmp_format() },
            sources = require("cmp").config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
            }, {
                { name = "buffer", keyword_length = 3 },
            }),
            mapping = mapping,
            snippet = {
                expand = function(args) require("luasnip").lsp_expand(args.body) end,
            },
        })
        require("cmp").setup.cmdline({ "/", "?" }, {
            sources = { { name = "buffer", keyword_length = 3 } },
            mapping = mapping,
        })
        require("cmp").setup.cmdline(":", {
            sources = require("cmp").config.sources({
                { name = "path", keyword_length = 3 },
            }, {
                { name = "cmdline", keyword_length = 3 },
            }),
            mapping = mapping,
            matching = { disallow_symbol_nonprefix_matching = false },
        })
    end,
}
