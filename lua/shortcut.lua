local M = {}

M.filereadable = function(file)
    return vim.fn.filereadable(file) == 1
end

M.keymap = vim.keymap.set

return M
