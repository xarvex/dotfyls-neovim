require("config")

-- use lazy.nvim as plugin manager
local lazypath = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy/lazy.nvim")
if vim.fn.isdirectory(lazypath) == 0 then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

local branch = vim.env.USER == "xarvex" and "main" or "0.1.x"
require("lazy").setup({
    {
        "https://gitlab.com/xarvex/lazy-load.nvim", -- hey I made this
        branch = branch,
        lazy = true                                 -- only load once required
    },
    { import = "plugin" }                           -- load other plugins after
}, {
    performance = {
        rtp = {
            disabled_plugins = {
                "editorconfig",
                "netrwPlugin",
                "osc52",
                "rplugin",
                "spellfile",
                "tohtml",
                "tutor"
            }
        }
    }
})
require("shortcut").keymap("n", "<C-A-l>", vim.cmd.Lazy)
