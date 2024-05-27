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
