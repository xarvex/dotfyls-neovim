local themery = require("generate").path("themery.lua")

return {
    {
        "zaldih/themery.nvim",
        cmd = "Themery",
        keys = {
            { "<C-A-t>", vim.cmd.Themery }
        },
        init = function()
            local shortcut = require("shortcut")

            if not shortcut.filereadable(themery) then
                shortcut.writefile({
                    "-- Themery block",
                    "-- end themery block"
                }, themery, "")
            end
        end,
        opts = {
            themes = {
                "duskfox", "carbonfox",
                "oxocarbon",
                "rose-pine",
                "tokyonight"
            },
            themeConfigFile = themery
        }
    },
    {
        "EdenEast/nightfox.nvim",
        lazy = true,
        init = function()
            vim.cmd.colorscheme("carbonfox") -- default colorscheme
        end,
        opts = { options = { transparent = true } }
    },
    {
        "nyoom-engineering/oxocarbon.nvim",
        lazy = true
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
            styles = { transparent = true }
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
                sidebars = "transparent",
                floats = "transparent"
            },
            hide_inactive_statusline = false,
            dim_inactive = false,
            lualine_bold = false
        }
    }
}
