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
            long_message_to_split = true
        },
        views = {
            cmdline_popup = {
                border = {
                    style = "none",
                    padding = { 1, 2 }
                },
                filter_options = {},
                win_options = {
                    winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder"
                },
                position = {
                    row = 5,
                    col = "70%"
                },
            },
            popupmenu = {
                relative = "editor",
                border = {
                    style = "none",
                    padding = { 0, 1 }
                },
                win_options = {
                    winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder"
                }
            }
        }
    }
}
