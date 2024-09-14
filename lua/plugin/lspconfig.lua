return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "williamboman/mason-lspconfig.nvim",
    },
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    event = { "User BufNewFileFiltered", "User BufReadPostFiltered", "User BufWritePreFiltered" },
    config = function()
        local keymap = require("shortcut").keymap

        local servers = {
            astro = { "astro-ls", true },
            bashls = {
                "bash-language-server",
                {
                    filetypes = { "bash", "sh", "zsh" },
                },
            },
            clangd = {
                "clangd",
                {
                    on_attach = function(_, bufnr) keymap("n", "<leader>sh", vim.cmd.ClangdSwitchSourceHeader, { buffer = bufnr }) end,
                },
            },
            cssls = { "vscode-css-language-server", true },
            denols = {
                "deno",
                {
                    root_dir = require("lspconfig").util.root_pattern("deno.json", "deno.jsonc"),
                },
            },
            eslint = { "vscode-eslint-language-server", true },
            gopls = {
                "gopls",
                {
                    settings = { gofumpt = true },
                },
            },
            html = { "vscode-html-language-server", true },
            jsonls = { "vscode-json-language-server", true },
            lua_ls = { "lua-language-server", true },
            nil_ls = { "nil", true },
            pyright = { "pyright-langserver", true },
            rust_analyzer = { "rust-analyzer", true },
            svelte = { "svelteserver", true },
            ts_ls = {
                "typescript-language-server",
                {
                    root_dir = require("lspconfig").util.root_pattern("tsconfig.json"),
                },
            },
            vuels = { "vls", true },
        }

        local function setup_server(name, skip_check)
            local server = servers[name]

            if server ~= nil and (skip_check == true or vim.fn.executable(server[1]) == 1) then
                local setup = require("lspconfig")[name].setup
                local config = server[2]

                local config_type = type(config)
                if config_type == "function" then
                    local result = config()
                    setup(result == true and {} or result)
                else
                    setup(config == true and {} or config)
                end
            end
        end

        require("lsp-zero").extend_lspconfig({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
            sign_text = false,
        })

        if require("env").mason_used then
            require("mason-lspconfig").setup({
                handlers = { function(name) setup_server(name, true) end },
            })
        else
            for name, _ in pairs(servers) do
                setup_server(name)
            end
        end
    end,
}
