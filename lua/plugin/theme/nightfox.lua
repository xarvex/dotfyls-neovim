return {
    "EdenEast/nightfox.nvim",
    lazy = true,
    init = function()
        vim.cmd.colorscheme("carbonfox") -- default colorscheme
    end,
    opts = { options = { transparent = true } }
}
