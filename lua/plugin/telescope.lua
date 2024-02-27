local lazy_telescope = require("lazy-load"):require("telescope.builtin")

return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    cmd = "Telescope",
    keys = {
        lazy_telescope:keymap_require("n", "<leader>ff", nil, "find_files", {}),
        lazy_telescope:keymap_require("n", "<C-p>", nil, "git_files", {}),
        lazy_telescope:keymap_require("n", "<leader>fs", nil, "live_grep")
    }
}
