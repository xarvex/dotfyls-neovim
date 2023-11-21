return {
    {
        "zaldih/themery.nvim",
        cmd = "Themery",
        keys = {
            { "<C-A-t>", vim.cmd.Themery }
        },
        opts = {
            themes = {
                "fluoromachine",
                "tokyonight",
                "rose-pine",
                "onedark"
            },
            themeConfigFile = vim.fn.stdpath("config") .. "/lua/generated/theme.lua"
        }
    },
    {
        "maxmx03/fluoromachine.nvim",
        opts = {
            theme = "fluoromachine",
            transparent = "full",
            glow = false
        }
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
        opts = {
            variant = "main",
            dark_variant = "main",
            disable_background = true,
            disable_float_background = true,
            disable_italics = true
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
        "folke/tokyonight.nvim",
        lazy = true,
        opts = {
            style = "night",
            transparent = true,
            terminal_colors = true,
            styles = {
                keywords = { italic = false },
                sidebars = "transparent",
                floats = "transparent"
            },
            hide_inactive_statusline = false,
            dim_inactive = false,
            lualine_bold = false
        }
    }
}
