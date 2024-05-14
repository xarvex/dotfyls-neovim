local M = {}

local generated = vim.fn.stdpath("config") .. "/lua/generated"

M.path = function(fname)
    return generated .. "/" .. fname
end

M.writefile = function(object, fname, flags)
    if vim.fn.isdirectory(generated) == 0 then vim.fn.mkdir(generated, "p") end
    local path = M.path(fname)
    return vim.fn.writefile(object, path, flags)
end

return M
