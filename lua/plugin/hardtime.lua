return {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    config = function()
        require("hardtime").setup({ max_count = 4 })
        require("hardtime").enable()
    end,
}
