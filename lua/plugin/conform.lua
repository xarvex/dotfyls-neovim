return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
        {
            "<leader>fr",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end
        },
    },
    opts = {
        formatters_by_ft = {
            go = { "gofmt" },
            javascript = { { "prettierd", "prettier" } },
            lua = { "stylua" }
        },
        format_on_save = { lsp_fallback = true }
    }
}
