return {
    "stevearc/conform.nvim",
    cmd = "ConformInfo",
    event = "User BufWritePreFiltered",
    keys = {
        {
            "<leader>fm",
            function() require("conform").format({ async = true }) end,
        },
    },
    opts = {
        formatters_by_ft = {
            go = { "gofumpt", "goimports", "gofmt" },
            javascript = { "prettierd", "prettier" },
            lua = { "stylua" },
            nix = { "nixfmt", "nixpkgs_fmt" },
            python = { "ruff_format" },
            sql = { "sql_formatter" },
        },
        default_format_opts = {
            lsp_format = "fallback",
            stop_after_first = true,
        },
        format_after_save = {},
        formatters = {
            sql_formatter = {
                args = {
                    "-c",
                    vim.fs.joinpath(vim.env.XDG_CONFIG_HOME or vim.fs.joinpath(vim.env.HOME, ".config"), "sql-formatter/config.json"),
                },
            },
        },
    },
}
