return {
    "folke/lazydev.nvim",
    dependencies = { { "Bilal2453/luvit-meta", lazy = true } },
    ft = "lua",
    opts = {
        library = { "luvit-meta/library" },
        enabled = function(root_dir) return not vim.uv.fs_stat(root_dir .. "/.luarc.json") end,
    },
}
