require("generated.theme") -- require the theme selected by Themery

-- fallback (default) colorscheme
if vim.g.colors_name == nil then
    vim.cmd.colorscheme("carbonfox")
end
