require("xarvex")

-- use lazy.nvim as plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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

local generatedpath = vim.fn.stdpath("config") .. "/lua/generated"
local generatedtheme = generatedpath .. "/theme.lua"
if vim.fn.filereadable(generatedtheme) == 0 then
    if vim.fn.isdirectory(generatedpath) == 0 then
        vim.fn.mkdir(generatedpath, "p")
    end
    vim.fn.writefile({
        "-- Themery block",
        "-- This block will be replaced by Themery.",
        "-- end themery block"
    }, generatedtheme, "b")
end

require("lazy").setup({
    {
        "https://gitlab.com/xarvex/lazy-load.nvim", -- hey I made this
        branch = "0.0.x",
        lazy = true -- only load once required
    },
    {
        import = "plugin" -- load other plugins after
    }
})
