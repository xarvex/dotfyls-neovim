local themery = require("generate").path("themery.lua")

return {
    "zaldih/themery.nvim",
    cmd = "Themery",
    keys = {
        { "<C-A-t>", vim.cmd.Themery },
    },
    init = function()
        if not require("shortcut").filereadable(themery) then
            require("shortcut").writefile({
                "-- Themery block",
                "-- end themery block",
            }, themery, "")
        end
        pcall(require, "generated.themery") -- not guaranteed to exist
    end,
    opts = {
        -- stylua: ignore
        themes = {
            "duskfox", "carbonfox",
            "oxocarbon",
            "rose-pine",
            "tokyonight",
        },
        themeConfigFile = themery,
    },
}
