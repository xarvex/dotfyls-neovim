local M = {}

M.filereadable = function(file)
    return vim.fn.filereadable(file) == 1
end

return M
