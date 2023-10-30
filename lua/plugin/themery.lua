return {
    {
        "zaldih/themery.nvim",
        cmd = {
            "Themery"
        },
        keys = {
            {
                "<leader>th",
                vim.cmd.Themery
            }
        },
        opts = {
            themes = {
                "tokyonight",
                "rose-pine",
                "onedark"
            },
            themeConfigFile = vim.fn.stdpath("config") .. "/lua/generated/theme.lua"
        }
    },
    {
        "folke/tokyonight.nvim",
        lazy = true,
        priority = 1000,
        opts = {
            style = "night",
            transparent = true,
            terminal_colors = true,
            styles = {
                keywords = {
                    italic = false
                },
                sidebars = "transparent",
                floats = "transparent"
            },
            hide_inactive_statusline = false,
            dim_inactive = false,
            lualine_bold = false
        }
    },
    {
        "navarasu/onedark.nvim",
        lazy = true,
        opts = {
            style = "darker",
            transparent = true
        }
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
        priority = 1000,
        opts = {
            variant = "main",
            dark_variant = "main",
            disable_background = true,
            disable_float_background = true,
            disable_italics = true
        }
    }
}
