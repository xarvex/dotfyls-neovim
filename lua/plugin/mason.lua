return {
    "williamboman/mason.nvim",
    cmd = {
        "Mason",
        "MasonInstall",
        "MasonLog",
        "MasonUninstall",
        "MasonUninstallAll",
        "MasonUpdate",
    },
    keys = {
        { "<C-A-m>", vim.cmd.Mason },
    },
    build = ":MasonUpdate",
    opts = {},
}
