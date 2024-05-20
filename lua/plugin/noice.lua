return {
    "folke/noice.nvim",
    dependencies = {
        "MunifTanjim/nui.nvim",
        {
            "rcarriga/nvim-notify",
            opts = {
                background_colour = "#000000",
                render = "wrapped-compact",
                stages = "fade"
            }
        }
    },
    event = "VeryLazy",
    opts = {
        lsp = {
            override = {
                ["cmp.entry.get_documentation"] = true,
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true -- requires hrsh7th/nvim-cmp
            }
        },
        presets = {
            command_palette = true,
            long_message_to_split = true
        },
        views = {
            cmdline_popup = {
                border = {
                    style = "none",
                    padding = { 2, 3 }
                },
                filter_options = {},
                win_options = {
                    winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder"
                }
            }
        }
    }
}
