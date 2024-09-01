return {
    "iamcco/markdown-preview.nvim",
    cmd = {
        "MarkdownPreview",
        "MarkdownPreviewStop",
        "MarkdownPreviewToggle",
    },
    keys = {
        { "<leader>md", vim.cmd.MarkdownPreviewToggle },
    },
    ft = { "markdown" },
    build = function(plugin)
        if vim.fn.executable("npx") then
            vim.cmd("!cd '" .. plugin.dir .. "'/app && npx -y yarn install")
        else
            vim.cmd("Lazy load markdown-preview.nvim")
            vim.fn["mkdp#util#install"]()
        end
    end,
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
}
