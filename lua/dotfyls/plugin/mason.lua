return {
    "williamboman/mason.nvim",
    enabled = require("dotfyls.env").mason_used,
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
