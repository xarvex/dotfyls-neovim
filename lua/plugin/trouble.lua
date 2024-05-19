local lazy_trouble = require("lazy-load"):require("trouble")

return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "Trouble",
    keys = {
        lazy_trouble:keymap_require("n", "<leader>xx", nil, function(trouble) trouble.toggle() end)
    },
    opts = {}
}
