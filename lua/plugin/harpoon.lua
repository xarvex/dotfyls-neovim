local lazy_harpoon = require("lazy-load"):require("harpoon")
local lazy_harpoon_ui = lazy_harpoon:require("ui")

return {
    "ThePrimeagen/harpoon",
    lazy = true,
    keys = {
        lazy_harpoon:keymap_require("n", "<leader>a", "mark", "add_file"),
        lazy_harpoon_ui:keymap_require("n", "<leader>h", nil, "toggle_quick_menu"),
        lazy_harpoon_ui:keymap_require("n", "<leader>1", nil, "nav_file", 1),
        lazy_harpoon_ui:keymap_require("n", "<leader>2", nil, "nav_file", 2),
        lazy_harpoon_ui:keymap_require("n", "<leader>3", nil, "nav_file", 3),
        lazy_harpoon_ui:keymap_require("n", "<leader>4", nil, "nav_file", 4),
        lazy_harpoon_ui:keymap_require("n", "<leader>5", nil, "nav_file", 5),
        lazy_harpoon_ui:keymap_require("n", "<leader>6", nil, "nav_file", 6),
        lazy_harpoon_ui:keymap_require("n", "<leader>7", nil, "nav_file", 7),
        lazy_harpoon_ui:keymap_require("n", "<leader>8", nil, "nav_file", 8),
        lazy_harpoon_ui:keymap_require("n", "<leader>9", nil, "nav_file", 9),
    }
}
