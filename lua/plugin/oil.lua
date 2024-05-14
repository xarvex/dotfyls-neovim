return {
    "stevearc/oil.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    init = function()
        local keymap = require("shortcut").keymap

        keymap("n", "-", vim.cmd.Oil)
        keymap("n", "<leader>-", "<cmd>Oil --float<CR>")
    end,
    opts = {}
}
