local opt = vim.opt

-- remove crutch
opt.mouse = nil

-- behavior
opt.encoding = "UTF-8"
opt.swapfile = false
opt.backup = true
opt.backupdir = vim.fs.joinpath(vim.fn.stdpath("state"), "backup")
opt.undofile = true
opt.undodir = vim.fs.joinpath(vim.fn.stdpath("state"), "undo")
opt.autochdir = false
opt.updatetime = 50
opt.splitright = true
opt.splitbelow = true

-- indentation
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true

-- search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = false

-- visual
opt.number = true
opt.relativenumber = true
opt.wrap = false
opt.scrolloff = 8
opt.isfname:append("@-@")
opt.termguicolors = true
opt.signcolumn = "yes"
opt.colorcolumn = "80"

vim.api.nvim_create_autocmd("FileType", {
    callback = function(event)
        if event.match == "nix" then vim.bo[event.buf].shiftwidth = 2 end
    end,
})
