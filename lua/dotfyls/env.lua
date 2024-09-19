local M = {}

M.mason_used = vim.env.DOTFYLS_NEOVIM_MASON ~= nil and vim.env.DOTFYLS_NEOVIM_MASON == "1"
    or not require("dotfyls.shortcut").executable("nix")

return M
