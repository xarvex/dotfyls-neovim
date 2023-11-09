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
    build = "cd app && yarn install",
    init = function()
        vim.g.mkdp_filetypes = { "markdown" }
    end
}
