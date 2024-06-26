return {
    "folke/zen-mode.nvim",
    dependencies = {
        {
            "folke/twilight.nvim",
            cmd = {
                "Twilight",
                "TwilightDisable",
                "TwilightEnable",
            },
            opts = {
                dimming = { inactive = true },
                context = 10,
                expand = {
                    "function",
                    "function_definition",
                    "method",
                    "table",
                },
            },
        },
    },
    cmd = "ZenMode",
    keys = {
        require("lazy-load"):keymap_require("n", "<leader>zz", "zen-mode", function(zen_mode)
            zen_mode.toggle()
            vim.wo.wrap = false
        end),
    },
    opts = {
        window = {
            options = { number = true, relativenumber = true },
        },
    },
}
