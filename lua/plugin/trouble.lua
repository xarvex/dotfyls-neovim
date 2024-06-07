local lazy_trouble = require("lazy-load"):require("trouble")

return {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = { "Trouble", "TroubleToggle" },
    keys = {
        lazy_trouble:keymap_require("n", "<leader>xx", nil, function(trouble) trouble.toggle() end),
        lazy_trouble:keymap_require("n", "<leader>xw", nil, function(trouble) trouble.toggle("workspace_diagnostics") end),
        lazy_trouble:keymap_require("n", "<leader>xd", nil, function(trouble) trouble.toggle("document_diagnostics") end),
    },
    opts = {},
}
