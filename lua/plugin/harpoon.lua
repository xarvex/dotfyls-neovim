local lazy_harpoon = require("lazy-load"):require("harpoon")
local lazy_harpoon_ui = lazy_harpoon:require("ui")

local keys = {
    lazy_harpoon:keymap_require("n", "<leader>a", "mark", "add_file"),
    lazy_harpoon_ui:keymap_require("n", "<leader>h", nil, "toggle_quick_menu")
}

for i = 1, 9 do
    table.insert(keys, lazy_harpoon_ui:keymap_require("n", string.format("<leader>%s", i), nil, "nav_file", i))
end

return {
    "ThePrimeagen/harpoon",
    lazy = true,
    keys = keys
}
