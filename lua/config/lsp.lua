local keymap = require("shortcut").keymap

vim.api.nvim_create_autocmd("Lspattach", {
    callback = function(args)
        local opts = { buffer = args.buf }

        local float = { border = "rounded" }
        keymap("n", "<leader>d", function() vim.diagnostic.open_float(float) end, opts)
        keymap("n", "[d", function() vim.diagnostic.goto_prev({ float = float }) end, opts)
        keymap("n", "]d", function() vim.diagnostic.goto_next({ float = float }) end, opts)

        keymap("n", "gd", function() vim.lsp.buf.definition() end, opts)
        keymap("n", "gD", function() vim.lsp.buf.declaration() end, opts)
        keymap("n", "gT", function() vim.lsp.buf.type_definition() end, opts)
        keymap("n", "gi", function() vim.lsp.buf.implementation() end, opts)
        keymap("n", "gr", function() vim.lsp.buf.references() end, opts)

        keymap("n", "K", function() vim.lsp.buf.hover() end, opts)
        keymap({ "n", "i" }, "<C-;>", function() vim.lsp.buf.signature_help() end, opts)

        keymap({ "n", "v" }, "<leader>ca", function() vim.lsp.buf.code_action() end, opts)
        keymap("n", "<leader>rn", function() vim.lsp.buf.rename() end, opts)

        local client = vim.lsp.get_client_by_id(args.data.client_id)
        keymap("n", "<leader>i", client ~= nil and client.server_capabilities.inlayHintProvider and function()
            local filter = { bufnr = args.buf }
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(filter), filter)
        end or "<Nop>", opts)
    end
})
