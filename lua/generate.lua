local M = {}

local generated = vim.fn.stdpath("config") .. "/lua/generated"

M.path = function(fname)
    return generated .. "/" .. fname
end

return M
