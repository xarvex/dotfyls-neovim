local lazy_dressing = require("lazy-load"):require("dressing")

vim.ui.select = function(...)
    lazy_dressing:load()
    vim.ui.select(...)
end

vim.ui.input = function(...)
    lazy_dressing:load()
    vim.ui.input(...)
end

return {
    "stevearc/dressing.nvim",
    lazy = true
}
