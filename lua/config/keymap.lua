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
