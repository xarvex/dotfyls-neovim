vim.ui.select = function(...)
    require("dressing")
    vim.ui.select(...)
end

vim.ui.input = function(...)
    require("dressing")
    vim.ui.input(...)
end

return {
    "stevearc/dressing.nvim",
    lazy = true
}
