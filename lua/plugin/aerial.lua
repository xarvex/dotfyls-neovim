return {
    "stevearc/aerial.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
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
        "AerialToggle"
    },
    keys = {
        {
            "<leader>o",
            vim.cmd.AerialToggle
        }
    },
    opts = {
        on_attach = function(bufnr)
            vim.keymap.set("n", "{", vim.cmd.AerialPrev, {
                buffer = bufnr
            })
            vim.keymap.set("n", "}", vim.cmd.AerialNext, {
                buffer = bufnr
            })
        end
    }
}
