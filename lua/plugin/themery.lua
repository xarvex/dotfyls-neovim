local generate = require("generate")

if not require("shortcut").filereadable(generate.path("themery.lua")) then
    generate.writefile({
        "-- Themery block",
        "-- end themery block"
    }, "themery.lua", "")
end

return {
    {
        "zaldih/themery.nvim",
        cmd = "Themery",
        keys = {
            { "<C-A-t>", vim.cmd.Themery }
        },
        opts = {
            themes = {
                "duskfox", "carbonfox",
                "oxocarbon",
                "rose-pine",
                "tokyonight"
            },
            themeConfigFile = generate.path("themery.lua")
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
