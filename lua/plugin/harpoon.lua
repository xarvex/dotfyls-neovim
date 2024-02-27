local lazy_harpoon = require("lazy-load"):require("harpoon")

local keys = {
    lazy_harpoon:keymap_require("n", "<leader>a", nil, function(harpoon) harpoon:list():append() end),
    lazy_harpoon:keymap_require("n", "<leader>h", nil, function(harpoon) harpoon.ui:toggle_quick_menu(harpoon:list()) end)
}

for i = 1, 9 do
    table.insert(keys, lazy_harpoon:keymap_require(
    ---@diagnostic disable-next-line: redefined-local
        "n", string.format("<leader>%s", i), nil, function(harpoon, i) harpoon:list():select(i) end, i
    ))
end

return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = "nvim-lua/plenary.nvim",
    event = "BufLeave",
    keys = keys,
    opts = { settings = { save_on_toggle = true } }
}
