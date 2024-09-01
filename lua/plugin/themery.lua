return {
    "zaldih/themery.nvim",
    cmd = "Themery",
    keys = {
        { "<C-A-t>", vim.cmd.Themery },
    },
    opts = {
        -- stylua: ignore
        themes = {
            "duskfox", "carbonfox",
            "oxocarbon",
            "rose-pine",
            "tokyonight",
        },
    },
}
