return {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = { "BufNewFile", "BufReadPost" },
    opts = function()
        vim.diagnostic.config({
            virtual_text = false,
            virtual_lines = { highlight_whole_line = false },
        })

        vim.diagnostic.config({
            virtual_text = true,
            virtual_lines = false,
        }, vim.api.nvim_get_namespaces().lazy)
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "oil",
            group = require("dotfyls.shortcut").group,
            callback = function()
                vim.diagnostic.config({
                    virtual_text = true,
                    virtual_lines = false,
                }, vim.api.nvim_get_namespaces().Oil)
            end,
            once = true,
            desc = "lsp_lines unloading (Oil)",
        })

        return {}
    end,
}
