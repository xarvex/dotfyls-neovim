return {
    "EdenEast/nightfox.nvim",
    lazy = true,
    init = function()
        if not vim.g.colors_name then
            vim.cmd.colorscheme("carbonfox") -- default colorscheme
        end
    end,
    opts = { options = { transparent = true } },
}
