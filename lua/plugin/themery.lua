local themery = require("generate").path("themery.lua")

return {
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
}
