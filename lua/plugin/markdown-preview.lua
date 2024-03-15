return {
    "iamcco/markdown-preview.nvim",
    cmd = {
        "MarkdownPreview",
        "MarkdownPreviewStop",
        "MarkdownPreviewToggle"
    },
    keys = {
        { "<leader>md", vim.cmd.MarkdownPreviewToggle }
    },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
    init = function()
        vim.g.mkdp_filetypes = { "markdown" }
    end
}
