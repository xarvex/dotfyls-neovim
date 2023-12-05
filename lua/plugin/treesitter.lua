return {
    "nvim-treesitter/nvim-treesitter",
    event = {
        "BufNewFile",
        "BufReadPre"
    },
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
    end,
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "go",
                "c",
                "cpp",
                "java",
                "kotlin",
                "javascript",
                "typescript",
                "lua",
                "bash",
                "html",
                "css"
            },
            ignore_install = {},
            modules = {},
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false
            },
            indent = { enable = true },
            sync_install = false
        })
    end
}
