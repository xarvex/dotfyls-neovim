return {
    "nvim-treesitter/nvim-treesitter",
    cmd = {
        "TSBufDisable",
        "TSBufEnable",
        "TSBufToggle",
        "TSConfigInfo",
        "TSDisable",
        "TSEditQuery",
        "TSEditQueryUserAfter",
        "TSEnable",
        "TSInstall",
        "TSInstallFromGrammar",
        "TSInstallInfo",
        "TSInstallSync",
        "TSModuleInfo",
        "TSToggle",
        "TSUninstall",
        "TSUpdate",
        "TSUpdateSync",
    },
    event = { "User BufNewFileFiltered", "User BufReadPostFiltered", "User BufWritePreFiltered" },
    build = function() require("nvim-treesitter.install").update({ with_sync = true })() end,
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {},
            sync_install = false,
            auto_install = true,
            ignore_install = {},
            modules = {},
            highlight = {
                enable = true,
                use_languagetree = true,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
        })
    end,
}
