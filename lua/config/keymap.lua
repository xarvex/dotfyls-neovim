local keymap = require("shortcut").keymap

-- remove crutches
-- stylua: ignore
for _, k in ipairs({
    "Up", "Down", "Right", "Left",
    "Insert", "Home", "End", "PageUp", "PageDown", "Delete",
    "kUp", "kDown", "kLeft", "kRight",
    "kHome", "kOrigin", "kPageUp", "kPageDown", "kDel",
}) do
    keymap({ "n", "i", "v", "x" }, string.format("<%s>", k), "<Nop>")
    keymap({ "n", "i", "v", "x" }, string.format("<C-%s>", k), "<Nop>")
end

-- better up/down (fixes problems with wrapped lines)
keymap({ "n", "v", "x" }, "j", "v:count || mode(1)[0:1] == 'no' ? 'j' : 'gj'", { expr = true })
keymap({ "n", "v", "x" }, "k", "v:count || mode(1)[0:1] == 'no' ? 'k' : 'gk'", { expr = true })
keymap({ "n", "v", "x" }, "<Down>", "v:count || mode(1)[0:1] == 'no' ? 'j' : 'gj'", { expr = true })
keymap({ "n", "v", "x" }, "<Up>", "v:count || mode(1)[0:1] == 'no' ? 'k' : 'gk'", { expr = true })

-- navigate insert mode
keymap("i", "<C-h>", "<Left>")
keymap("i", "<C-l>", "<Right>")
keymap("i", "<C-j>", "<Down>")
keymap("i", "<C-k>", "<Up>")

-- switch windows
keymap("n", "<A-h>", "<C-w>h")
keymap("n", "<A-l>", "<C-w>l")
keymap("n", "<A-j>", "<C-w>j")
keymap("n", "<A-k>", "<C-w>k")

-- close window
keymap("n", "<C-c>", "<C-w>c")

-- remove ending newline
keymap("n", "J", "mzJ`z")

-- move a section of text up or down
keymap("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
keymap("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- move a section of text to top or bottom
keymap("v", "<C-J>", ":m $<CR>gv=gv", { silent = true })
keymap("v", "<C-K>", ":m 0<CR>gv=gv", { silent = true })

-- system clipboard operations
keymap({ "n", "v" }, "<leader>y", [["+y]])
keymap("n", "<leader>Y", [["+Y]])
keymap({ "n", "v" }, "<leader>d", [["+d]])
keymap("n", "<leader>p", [["+p]])
keymap("v", "<leader>p", [[c<Esc>"+p]])
-- paste without yanking current selection
keymap("x", "<A-p>", [["_dP]])

-- autoindent entire buffer
keymap("n", "<leader>=", "mzgg=G`z")

-- set current file as executable
keymap("n", "<leader>x", "<cmd>!chmod u+x %<CR>", { silent = true })

vim.api.nvim_create_autocmd("LspAttach", {
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
    end,
})
