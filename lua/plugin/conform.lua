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
            lua = { "stylua" },
            sql = { "sql_formatter" }
        },
        formatters = {
            sql_formatter = {
                args = { "-c", vim.env.XDG_CONFIG_HOME .. "/sql-formatter/config.json" }
            }
        },
        format_on_save = { lsp_fallback = true }
    }
}
