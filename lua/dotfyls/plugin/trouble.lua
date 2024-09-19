return {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    cmd = "Trouble",
    keys = {
        { "<leader>xx", function() vim.cmd.Trouble("diagnostics toggle") end },
        { "<leader>xX", function() vim.cmd.Trouble("diagnostics toggle filter.buf=0") end },
        { "<leader>xs", function() vim.cmd.Trouble("symbols toggle") end },
        { "<leader>xl", function() vim.cmd.Trouble("lsp toggle") end },
        { "gd", function() vim.cmd.Trouble("lsp_definitions toggle focus=true") end },
        { "gD", function() vim.cmd.Trouble("lsp_declarations toggle focus=true") end },
        { "gT", function() vim.cmd.Trouble("lsp_type_definitions toggle focus=true") end },
        { "gi", function() vim.cmd.Trouble("lsp_implementations toggle focus=true") end },
        { "gr", function() vim.cmd.Trouble("lsp_references toggle focus=true") end },
    },
    opts = {},
}
