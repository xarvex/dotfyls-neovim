require("xarvex")

-- use lazy.nvim as plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

require("lazy").setup({
    {
        "https://gitlab.com/xarvex/lazy-load.nvim", -- hey I made this
        lazy = true -- only load once required
    },
    {
        import = "plugin" -- load other plugins after
    }
})
