return {
    "mrcjkb/rustaceanvim",
    version = "^5",
    enabled = require("dotfyls.shortcut").executable("rust-analyzer"),
    config = function()
        vim.g.rustaceanvim = {
            tools = {}, -- TODO
            server = {
                on_attach = function(_, bufnr)
                    local keymap = require("dotfyls.shortcut").keymap

                    keymap({ "n", "v" }, "J", function() vim.cmd.RustLsp("joinLines") end, { buffer = bufnr })
                    keymap({ "n", "v" }, "<leader>ca", function() vim.cmd.RustLsp("codeAction") end, { buffer = bufnr })

                    keymap("n", "<leader>re", function() vim.cmd.RustLsp("explainError") end, { buffer = bufnr })
                    keymap("n", "<leader>rC", function() vim.cmd.RustLsp("openCargo") end, { buffer = bufnr })
                    keymap("n", "<leader>rD", function() vim.cmd.RustLsp("openDocs") end, { buffer = bufnr })
                end,
                default_settings = {
                    ["rust-analyzer"] = {},
                },
            },
            dap = {}, -- TODO
        }
    end,
}
