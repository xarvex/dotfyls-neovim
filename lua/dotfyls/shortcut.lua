local M = {}

M.group = vim.api.nvim_create_augroup("dotfyls", {})

M.filereadable = function(file) return vim.fn.filereadable(file) == 1 end

M.executable = function(expr) return vim.fn.executable(expr) == 1 end

return M
