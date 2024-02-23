return {
    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
        lazy = true,
        init = function()
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0

            vim.keymap.set("n", "<leader><leader>", "<Nop>")
        end,
        config = false
    },
    {
        "williamboman/mason.nvim",
        lazy = false,
        keys = {
            { "<C-A-m>", vim.cmd.Mason }
        },
        config = true
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "onsails/lspkind.nvim"
        },
        event = "InsertEnter",
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_cmp()

            local cmp = require("cmp")
            local cmp_select = { behavior = cmp.SelectBehavior.Select }

            cmp.setup({
                formatting = { format = require("lspkind").cmp_format() },
                ["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
                ["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),
                ["<C-b>"] = cmp.mapping.complete()
            })
        end
    },
    {
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

                vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
                vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
                vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
                vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
                vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
                vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev() end, opts)
                vim.keymap.set("n", "]d", function() vim.diagnostic.goto_next() end, opts)
                vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
                vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
                vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
                vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
            end)

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "gopls",
                    "clangd",
                    -- "java_language_server",
                    "kotlin_language_server",
                    "denols",
                    "tsserver",
                    "eslint",
                    "lua_ls",
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

                                vim.keymap.set("n", "<leader>sh", vim.cmd.ClangdSwitchSourceHeader, opts)
                            end
                        })
                    end,
                    denols = function()
                        local lsp = require("lspconfig")
                        lsp.denols.setup({
                            root_dir = lsp.util.root_pattern("deno.json", "deno.jsonc")
                        });
                    end,
                    tsserver = function()
                        local lsp = require("lspconfig")
                        lsp.tsserver.setup({
                            root_dir = lsp.util.root_pattern("tsconfig.json")
                        });
                    end,
                    lua_ls = function()
                        local sourcing = "<Nop>"

                        require("lspconfig").lua_ls.setup({
                            on_init = function(client)
                                if client.workspace_folders[1].name:gsub("/$", "") == vim.fn.stdpath("config") .. "/lua" then
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

                                vim.keymap.set("n", "<leader><leader>", sourcing, opts)
                            end
                        })
                    end
                }
            })
        end
    }
}
