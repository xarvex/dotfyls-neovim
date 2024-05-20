local keymap = require("shortcut").keymap

return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "williamboman/mason-lspconfig.nvim"
    },
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "BufNewFile", "BufReadPre" },
    config = function()
        local lsp_zero = require("lsp-zero")
        lsp_zero.extend_lspconfig()

        lsp_zero.on_attach(function(_, bufnr)
            local opts = { buffer = bufnr, remap = false }

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
                            local opts = { buffer = bufnr, remap = false }

                            keymap("n", "<leader>sh", vim.cmd.ClangdSwitchSourceHeader, opts)
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
                    local sourcing = "<Nop>"

                    require("lspconfig").lua_ls.setup({
                        on_init = function(client)
                            local path = client.workspace_folders[1].name
                            if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
                                local plugins = {}
                                for token in string.gmatch(vim.fn.expand(vim.fn.stdpath("data") .. "/lazy/*"), "[^\r\n]+") do
                                    table.insert(plugins, token)
                                end

                                sourcing = vim.cmd.so

                                client.config = vim.tbl_deep_extend("force", client.config, lsp_zero.nvim_lua_ls())
                                client.config.settings.Lua.workspace.library = plugins

                                client.notify("workspace/didChangeConfiguration", {
                                    settings = client.config.settings
                                })
                            end

                            return true
                        end,
                        on_attach = function(_, bufnr)
                            local opts = { buffer = bufnr, remap = false }

                            keymap("n", "<leader><leader>", sourcing, opts)
                        end
                    })
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
