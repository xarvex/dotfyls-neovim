local lazy_load = require("lazy-load")

return {
    "ThePrimeagen/harpoon",
    lazy = true,
    keys = {
        lazy_load.keymap_require("n", "<leader>a", "harpoon.mark", "add_file"),
        lazy_load.keymap_require("n", "<leader>h", "harpoon.ui", "toggle_quick_menu"),
        lazy_load.keymap_require("n", "<leader>1", "harpoon.ui", "nav_file", 1),
        lazy_load.keymap_require("n", "<leader>2", "harpoon.ui", "nav_file", 2),
        lazy_load.keymap_require("n", "<leader>3", "harpoon.ui", "nav_file", 3),
        lazy_load.keymap_require("n", "<leader>4", "harpoon.ui", "nav_file", 4),
        lazy_load.keymap_require("n", "<leader>5", "harpoon.ui", "nav_file", 5),
        lazy_load.keymap_require("n", "<leader>6", "harpoon.ui", "nav_file", 6),
        lazy_load.keymap_require("n", "<leader>7", "harpoon.ui", "nav_file", 7),
        lazy_load.keymap_require("n", "<leader>8", "harpoon.ui", "nav_file", 8),
        lazy_load.keymap_require("n", "<leader>9", "harpoon.ui", "nav_file", 9),
    }
}
