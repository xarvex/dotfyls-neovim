local group = vim.api.nvim_create_augroup("UserEvent", {})
local filtered_filetypes = require("dotfyls.set").into_set({
    "oil",
})
local function filter(bufnr) return filtered_filetypes[vim.bo[bufnr].filetype] == nil end

-- stylua: ignore
vim.api.nvim_create_autocmd({
    "BufNewFile",
    "BufRead", "BufReadPre", "BufReadPost",
    "BufWrite", "BufWritePre", "BufWritePost",
}, {
    group = group,
    callback = function(event)
        if filter(event.buf) then vim.api.nvim_exec_autocmds("User", { pattern = event.event .. "Filtered" }) end
    end,
})
