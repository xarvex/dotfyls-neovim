local hidden_files = require("dotfyls.set").into_set({ "..", ".devenv", ".direnv", ".git" })

return {
    "stevearc/oil.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    event = "VimEnter",
    init = function()
        local keymap = require("dotfyls.shortcut").keymap

        keymap("n", "-", vim.cmd.Oil)
        keymap("n", "<leader>-", "<cmd>Oil --float<CR>")
    end,
    opts = {
        watch_for_changes = true,
        view_options = {
            show_hidden = true,
            is_always_hidden = function(name, _) return hidden_files[name] == true end,
        },
    },
}
