local function fmt_nameless(name)
    return name == "[No Name]" and "" or name
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            globalstatus = true,
            component_separators = "|",
            section_separators = { left = "", right = "" }
        },
        sections = {
            lualine_a = { { "mode", separator = { left = "", right = "" }, right_padding = 2 } },
            lualine_b = { { "filename", fmt = fmt_nameless }, "branch" },
            lualine_c = { "diagnostics" },
            lualine_x = { "fileformat" },
            lualine_y = { "filetype", "progress" },
            lualine_z = { { "location", separator = { left = "", right = "" }, left_padding = 2 } }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = { { "filename", fmt = fmt_nameless } },
            lualine_c = { "diagnostics" },
            lualine_x = {},
            lualine_y = {},
            lualine_z = { "location" }
        }
    }
}
