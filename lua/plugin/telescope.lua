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
        lazy_telescope:keymap_require("n", "<leader>ff", nil, "find_files"),
        lazy_telescope:keymap_require("n", "<leader>fg", nil, "live_grep"),
        lazy_telescope:keymap_require("n", "<leader>fb", nil, "buffers"),
        lazy_telescope:keymap_require("n", "<leader>fh", nil, "help_tags")
    },
    opts = {
        defaults = {
            mappings = {
                i = {
                    ["<C-j>"] = "move_selection_next",
                    ["<C-k>"] = "move_selection_previous"
                }
            }
        },
        pickers = {
            buffers = { theme = "dropdown" },
            colorscheme = {
                -- currently not working
                -- see https://github.com/nvim-telescope/telescope.nvim/pull/3097
                enable_preview = true,
                previwer = true
            },
            find_files = { theme = "dropdown" },
            help_tags = {
                theme = "dropdown",
                previewer = false
            },
            live_grep = { theme = "dropdown" }
        }
    }
}
