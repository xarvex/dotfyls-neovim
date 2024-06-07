local M = {}

local generated = vim.fs.joinpath(vim.fn.stdpath("config"), "lua/generated")

M.path = function(fname) return vim.fs.joinpath(generated, fname) end

return M
