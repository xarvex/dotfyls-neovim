return {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    event = "BufWritePre",
    keys = {
        {
            "<leader>fm",
            function()
                require("conform").format({ async = true, lsp_fallback = true })
            end
        },
    },
    opts = {
        formatters_by_ft = {
            go = { { "gofumpt", "goimports", "gofmt" } },
            javascript = { { "prettierd", "prettier" } },
            lua = { "stylua" }
        },
        format_on_save = { lsp_fallback = true }
    }
}
