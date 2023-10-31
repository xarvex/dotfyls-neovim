vim.g.mapleader = " "

-- return to file exporer
vim.keymap.set("n", "-", vim.cmd.Ex)

-- remove ending newline
vim.keymap.set("n", "J", "mzJ`z")

-- move a section of text up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- move a section of text to top or bottom
vim.keymap.set("v", "<C-J>", ":m 0<CR>gv=gv")
vim.keymap.set("v", "<C-K>", ":m $<CR>gv=gv")

-- yank into system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- paste without yanking current selection
vim.keymap.set("x", "<leader>p", [["_dP]])

-- autoindent entire document
vim.keymap.set("n", "<leader>=", "mzgg=G`z")

-- set file as executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- source current file
vim.keymap.set("n", "<leader><leader>", vim.cmd.so)
