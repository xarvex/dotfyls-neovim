local writefile = require("shortcut").writefile

local wezterm = (vim.env.XDG_CONFIG_HOME or (assert(vim.env.HOME) .. "/.config")) .. "/wezterm"
if vim.fn.isdirectory(wezterm) then
    local wezterm_colorschemes = {
        ["carbonfox"] = true,
        ["duskfox"] = true,
        ["tokyonight"] = "Tokyo Night",
        ["oxocarbon"] = "Oxocarbon Dark (Gogh)",
        ["rose-pine"] = true
    }

    -- only register once in UI
    vim.api.nvim_create_autocmd("UIEnter", {
        group = vim.api.nvim_create_augroup("WezTermColorscheme"),
        callback = function()
            vim.api.nvim_create_autocmd("ColorScheme", {
                group = vim.api.nvim_create_augroup("WezTermColorscheme"),
                callback = function(args)
                    local colorscheme = wezterm_colorschemes[args.match]
                    if colorscheme then
                        if type(colorscheme) ~= "string" then colorscheme = args.match end
                        writefile({ colorscheme }, wezterm .. "/generated_neovim_colorscheme", "")
                        vim.notify("Setting WezTerm colorscheme to " .. colorscheme, vim.log.levels.INFO)
                    end
                end
            })
        end
    })
end
