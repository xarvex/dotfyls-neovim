return {
    "doctorfree/cheatsheet.nvim",
    dependencies = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
    },
    cmd = { "Cheatsheet", "CheatsheetEdit" },
    keys = {
        { "<leader>?", vim.cmd.Cheatsheet },
    },
    config = function()
        require("cheatsheet").setup({
            bundled_cheetsheets = {
                enabled = {
                    "default",
                    "lua",
                    "markdown",
                    "regex",
                    "netrw",
                    "unicode",
                },
                disabled = { "nerd-fonts" },
            },
            bundled_plugin_cheatsheets = {
                enabled = { "telescope.nvim" },
                disabled = { "gitsigns" },
            },
            include_only_installed_plugins = true,
            telescope_mappings = {
                ["<CR>"] = require("cheatsheet.telescope.actions").select_or_fill_commandline,
                ["<leader><CR>"] = require("cheatsheet.telescope.actions").select_or_execute,
                ["<C-Y>"] = require("cheatsheet.telescope.actions").copy_cheat_value,
                ["<C-E>"] = require("cheatsheet.telescope.actions").edit_user_cheatsheet,
            },
        })
    end,
}
