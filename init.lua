require("dotfyls.config")

-- use lazy.nvim as plugin manager
local lazypath = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy/lazy.nvim")
if vim.fn.isdirectory(lazypath) == 0 then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- lazy-load.nvim must be declared first to be able to use in config
    { "https://gitlab.com/xarvex/lazy-load.nvim", branch = "0.1.x", lazy = true },
    { import = "dotfyls.plugin" }, -- load other plugins after
}, {
    dev = {
        path = vim.env.DOTFYLS_PROJECTS_DIR
            or vim.fs.joinpath(vim.env.XDG_DOCUMENTS_DIR or vim.fs.joinpath(assert(vim.env.HOME), "Documents"), "Projects"),
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "editorconfig",
                "netrwPlugin",
                "osc52",
                "rplugin",
                "spellfile",
                "tohtml",
                "tutor",
            },
        },
    },
})
require("dotfyls.shortcut").keymap("n", "<C-A-l>", vim.cmd.Lazy)
