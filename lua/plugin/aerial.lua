-- I should look into making this part of my plugin
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("LazyLoad", { clear = true }),
    callback = function()
        vim.keymap.set("n", "{", vim.cmd.AerialPrev, { buffer = 0 })
        vim.keymap.set("n", "}", vim.cmd.AerialNext, { buffer = 0 })
    end
})

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
    keys = { { "<leader>o", vim.cmd.AerialToggle } },
    config = true
}
