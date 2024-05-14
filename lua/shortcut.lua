local M = {}

M.keymap = vim.keymap.set

M.filereadable = function(file)
    return vim.fn.filereadable(file) == 1
end
M.writefile = function(object, fname, flags)
    local dir = vim.fs.dirname(fname)
    if vim.fn.isdirectory(dir) == 0 then vim.fn.mkdir(dir, "p") end
    return vim.fn.writefile(object, fname, flags)
end

return M
