local filename_component = {
    "filename",
    newfile_status = true,
    path = 1,
    symbols = {
        unnamed = "",
        newfile = "",
        modified = "●",
        readonly = ""
    },
    fmt = function(name) return vim.fs.basename(name) == "" and "" or name end
}

return {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        options = {
            disabled_filetypes = {
                "help", "qf",
                "aerial", "diff", "fugitive", "noice", "undotree"
            },
            component_separators = "|",
            section_separators = { left = "", right = "" }
        },
        sections = {
            lualine_a = { { "mode", separator = { left = "", right = "" }, right_padding = 2 } },
            lualine_b = { filename_component, "branch" },
            lualine_c = { "diagnostics" },
            lualine_x = { "fileformat" },
            lualine_y = { "filetype", "progress" },
            lualine_z = { { "location", separator = { left = "", right = "" }, left_padding = 2 } }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = { filename_component },
            lualine_c = { "diagnostics" },
            lualine_x = {},
            lualine_y = {},
            lualine_z = { "location" }
        }
    }
}
