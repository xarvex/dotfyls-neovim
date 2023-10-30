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
        config = true,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            {
                "L3MON4D3/LuaSnip"
            },
            {
                "onsails/lspkind.nvim"
            }
        },
        event = "InsertEnter",
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_cmp()

            local cmp = require("cmp")
            local cmp_select = {
                behavior = cmp.SelectBehavior.Select
            }

            cmp.setup({
                formatting = {
                    format = require("lspkind").cmp_format()
                },
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
            {
                "hrsh7th/cmp-nvim-lsp"
            },
            {
                "williamboman/mason-lspconfig.nvim"
            },
        },
        cmd = {
            "LspInfo",
            "LspInstall",
            "LspStart"
        },
        event = {
            "BufNewFile",
            "BufReadPre"
        },
        config = function()
            local lsp_zero = require("lsp-zero")
            lsp_zero.extend_lspconfig()

            lsp_zero.on_attach(function(_, bufnr)
                local opts = {
                    buffer = bufnr,
                    remap = false
                }

                vim.keymap.set("n", "gd", function()
                    vim.lsp.buf.definition()
                end, opts)
                vim.keymap.set("n", "gD", function()
                    vim.lsp.buf.declaration()
                end, opts)
                vim.keymap.set("n", "K", function()
                    vim.lsp.buf.hover()
                end, opts)
                vim.keymap.set("n", "<leader>vws", function()
                    vim.lsp.buf.workspace_symbol()
                end, opts)
                vim.keymap.set("n", "<leader>vd", function()
                    vim.diagnostic.open_float()
                end, opts)
                vim.keymap.set("n", "[d", function()
                    vim.diagnostic.goto_next()
                end, opts)
                vim.keymap.set("n", "]d", function()
                    vim.diagnostic.goto_prev()
                end, opts)
                vim.keymap.set("n", "<leader>vca", function()
                    vim.lsp.buf.code_action()
                end, opts)
                vim.keymap.set("n", "<leader>vrr", function()
                    vim.lsp.buf.references()
                end, opts)
                vim.keymap.set("n", "<leader>vrn", function()
                    vim.lsp.buf.rename()
                end, opts)
                vim.keymap.set("i", "<C-h>", function()
                    vim.lsp.buf.signature_help()
                end, opts)
            end)

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "gopls",
                    "clangd",
                    -- "java_language_server",
                    "kotlin_language_server",
                    "tsserver",
                    "eslint",
                    "lua_ls",
                    "bashls",
                    "html",
                    "cssls"
                },
                handlers = {
                    lsp_zero.default_setup,
                    clangd = function()
                        local clangd = require("lspconfig").clangd

                        clangd.setup({
                            on_attach = function(_, bufnr)
                                local opts = {
                                    buffer = bufnr,
                                    remap = false
                                }

                                vim.keymap.set("n", "<leader>sh", vim.cmd.ClangdSwitchSourceHeader, opts)
                            end
                        })
                    end,
                    lua_ls = function()
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        lua_opts.on_attach = function(_, bufnr)
                            local opts = {
                                buffer = bufnr,
                                remap = false
                            }

                            vim.keymap.set("n", "<leader><leader>", vim.cmd.so, opts)
                        end

                        require("lspconfig").lua_ls.setup(lua_opts)
                    end
                }
            })
        end
    }
}