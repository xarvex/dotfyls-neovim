local M = {}

M.keymap = vim.keymap.set
M.filereadable = function(file)
    return vim.fn.filereadable(file) == 1
end

return M
