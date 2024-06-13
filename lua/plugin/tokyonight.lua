return {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
        style = "night",
        transparent = true,
        terminal_colors = true,
        styles = {
            sidebars = "transparent",
            floats = "transparent",
        },
        hide_inactive_statusline = false,
        dim_inactive = false,
        lualine_bold = false,
    },
}
