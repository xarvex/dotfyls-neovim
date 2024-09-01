return {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    opts = {
        max_count = 5,
        disabled_keys = {
            ["<Up>"] = { "i", "v", "x" },
            ["<Down>"] = { "i", "v", "x" },
            ["<Left>"] = { "i", "v", "x" },
            ["<Right>"] = { "i", "v", "x" },
        },
    },
}
