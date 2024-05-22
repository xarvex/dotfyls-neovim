local keymap = require("shortcut").keymap

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "williamboman/mason-lspconfig.nvim"
    },
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "User BufNewFileFiltered", "User BufReadPostFiltered", "User BufWritePreFiltered" },
    config = function()
        local lsp_zero = require("lsp-zero")
        lsp_zero.extend_lspconfig()

        lsp_zero.on_attach(function(client, bufnr)
            local opts = { buffer = bufnr }

            keymap("n", "[d", function() vim.diagnostic.goto_prev({ float = { border = "rounded" } }) end, opts)
            keymap("n", "]d", function() vim.diagnostic.goto_next({ float = { border = "rounded" } }) end, opts)

            keymap("n", "gd", function() vim.lsp.buf.definition() end, opts)
            keymap("n", "gD", function() vim.lsp.buf.declaration() end, opts)
            keymap("n", "gT", function() vim.lsp.buf.type_definition() end, opts)
            keymap("n", "gi", function() vim.lsp.buf.implementation() end, opts)
            keymap("n", "gr", function() vim.lsp.buf.references() end, opts)

            keymap("n", "K", function() vim.lsp.buf.hover() end, opts)
            keymap("n", "<leader>d", function() vim.diagnostic.open_float({ border = "rounded" }) end, opts)
            keymap({ "n", "i" }, "<C-;>", function() vim.lsp.buf.signature_help() end, opts)

            keymap({ "n", "v" }, "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
            keymap("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)

            if client.server_capabilities.inlayHintProvider then
                keymap("n", "<leader>i", function()
                    local filter = { bufnr = bufnr }
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(filter), filter)
                end, opts)
            end
        end)

        require("mason-lspconfig").setup({
            ensure_installed = {
                "rust_analyzer",
                "gopls",
                "clangd",
                -- "java_language_server",
                "kotlin_language_server",
                "denols",
                "tsserver",
                "eslint",
                "lua_ls",
                "pyright",
                "bashls",
                "html",
                "cssls"
            },
            handlers = {
                lsp_zero.default_setup,
                gopls = function()
                    require("lspconfig").gopls.setup({
                        settings = { gofumpt = true }
                    })
                end,
                clangd = function()
                    require("lspconfig").clangd.setup({
                        on_attach = function(_, bufnr)
                            keymap("n", "<leader>sh", vim.cmd.ClangdSwitchSourceHeader, { buffer = bufnr })
                        end
                    })
                end,
                denols = function()
                    local lsp = require("lspconfig")
                    lsp.denols.setup({
                        root_dir = lsp.util.root_pattern("deno.json", "deno.jsonc")
                    })
                end,
                tsserver = function()
                    local lsp = require("lspconfig")
                    lsp.tsserver.setup({
                        root_dir = lsp.util.root_pattern("tsconfig.json")
                    })
                end,
                lua_ls = function()
                    require("neodev")
                    require("lspconfig").lua_ls.setup({})
                end,
                bashls = function()
                    require("lspconfig").bashls.setup({
                        filetypes = { "bash", "sh", "zsh" }
                    })
                end
            }
        })
    end
}
