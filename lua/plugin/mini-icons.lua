return {
    "echasnovski/mini.icons",
    specs = { { "nvim-tree/nvim-web-devicons", enabled = false, optional = true } },
    lazy = true,
    init = function()
        package.preload["nvim-web-devicons"] = function()
            -- Needed as it will be false when loading and cause failure.
            -- See: https://github.com/echasnovski/mini.nvim/issues/1007#issuecomment-2206571684
            package.loaded["nvim-web-devicons"] = {}
            require("mini.icons").mock_nvim_web_devicons()
            return package.loaded["nvim-web-devicons"]
        end
    end,
    opts = {},
}
