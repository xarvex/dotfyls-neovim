return {
    "stevearc/aerial.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "nvim-treesitter/nvim-treesitter",
    },
    cmd = {
        "AerialGo",
        "AerialInfo",
        "AerialNavOpen",
        "AerialNavToggle",
        "AerialNext",
        "AerialOpen",
        "AerialOpenAll",
        "AerialPrev",
        "AerialToggle",
    },
    keys = { { "<leader>o", vim.cmd.AerialToggle } },
    init = function()
        -- I should look into making this part of my plugin
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("LazyLoad", {}),
            callback = function()
                local keymap = require("shortcut").keymap

                keymap("n", "{", vim.cmd.AerialPrev, { buffer = true })
                keymap("n", "}", vim.cmd.AerialNext, { buffer = true })
            end,
        })
    end,
    opts = {},
}
