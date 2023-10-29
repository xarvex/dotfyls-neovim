local lazy_load = require("lazy-load")

return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        {
            "nvim-lua/plenary.nvim"
        },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make"
        },
        {
            "nvim-treesitter/nvim-treesitter"
        },
        {
            "nvim-tree/nvim-web-devicons"
        }
    },
    cmd = "Telescope",
    keys = {
        lazy_load.keymap_require("n", "<leader>ff", "telescope.builtin", "find_files", {}),
        lazy_load.keymap_require("n", "<C-p>", "telescope.builtin", "git_files", {}),
        lazy_load.keymap_require("n", "<leader>fs", "telescope.builtin", "live_grep")
    }
}
