vim.g.mapleader = " "

-- return to file exporer
vim.keymap.set("n", "-", "<cmd>Oil --float<CR>")

-- better up/down (fixes problems with wrapped lines)
vim.keymap.set({ "n", "v", "x" }, "j", "v:count || mode(1)[0:1] == 'no' ? 'j' : 'gj'", { expr = true })
vim.keymap.set({ "n", "v", "x" }, "k", "v:count || mode(1)[0:1] == 'no' ? 'k' : 'gk'", { expr = true })
vim.keymap.set({ "n", "v", "x" }, "<Down>", "v:count || mode(1)[0:1] == 'no' ? 'j' : 'gj'", { expr = true })
vim.keymap.set({ "n", "v", "x" }, "<Up>", "v:count || mode(1)[0:1] == 'no' ? 'k' : 'gk'", { expr = true })

-- navigate insert mode
vim.keymap.set("i", "<C-h>", "<Left>")
vim.keymap.set("i", "<C-l>", "<Right>")
vim.keymap.set("i", "<C-j>", "<Down>")
vim.keymap.set("i", "<C-k>", "<Up>")

-- switch windows
vim.keymap.set("n", "<A-h>", "<C-w>h")
vim.keymap.set("n", "<A-l>", "<C-w>l")
vim.keymap.set("n", "<A-j>", "<C-w>j")
vim.keymap.set("n", "<A-k>", "<C-w>k")

-- close window
vim.keymap.set("n", "<C-c>", "<C-w>c")

-- remove ending newline
vim.keymap.set("n", "J", "mzJ`z")

-- move a section of text up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- move a section of text to top or bottom
vim.keymap.set("v", "<C-J>", ":m $<CR>gv=gv")
vim.keymap.set("v", "<C-K>", ":m 0<CR>gv=gv")

-- yank into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- paste without yanking current selection
vim.keymap.set("x", "<leader>p", [["_dP]])

-- autoindent entire buffer
vim.keymap.set("n", "<leader>=", "mzgg=G`z")

-- set current file as executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod u+x %<CR>", { silent = true })

-- source current buffer
vim.keymap.set("n", "<leader><leader>", vim.cmd.so)

-- removing the crutches
vim.opt.mouse = nil
for _, k in ipairs({
    "Up", "Down", "Right", "Left",
    "Insert", "Home", "End", "PageUp", "PageDown", "Delete",
    "kUp", "kDown", "kLeft", "kRight",
    "kHome", "kOrigin", "kPageUp", "kPageDown", "kDel"
}) do
    vim.keymap.set({ "n", "i", "v", "x" }, string.format("<%s>", k), "<Nop>")
    vim.keymap.set({ "n", "i", "v", "x" }, string.format("<C-%s>", k), "<Nop>")
end
