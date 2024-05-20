local keymap = require("shortcut").keymap

return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = true,
    init = function()
        vim.g.lsp_zero_extend_cmp = 0
        vim.g.lsp_zero_extend_lspconfig = 0

        keymap("n", "<leader><leader>", "<Nop>")
    end,
    config = false
}
