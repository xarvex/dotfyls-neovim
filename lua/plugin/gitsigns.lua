return {
    "lewis6991/gitsigns.nvim",
    event = { "User BufNewFileFiltered", "User BufReadPostFiltered", "User BufWritePreFiltered" },
    opts = {
        on_attach = function(bufnr)
            local gitsigns = require("gitsigns")

            local keymap = require("shortcut").keymap
            local opts = { buffer = bufnr }

            keymap("n", "[g", function()
                if vim.wo.diff then return "[c" end
                vim.schedule(function() gitsigns.prev_hunk() end)
                return "<Ignore>"
            end, { buffer = bufnr, expr = true })
            keymap("n", "]g", function()
                if vim.wo.diff then return "]c" end
                vim.schedule(function() gitsigns.next_hunk() end)
                return "<Ignore>"
            end, { buffer = bufnr, expr = true })

            keymap("n", "<leader>Hs", gitsigns.stage_hunk, opts)
            keymap("v", "<leader>Hs", function()
                gitsigns.stage_hunk { vim.fn.line("."), vim.fn.line("v") }
            end, opts)
            keymap("n", "<leader>HS", gitsigns.stage_buffer, opts)

            keymap("n", "<leader>Hu", gitsigns.undo_stage_hunk, opts)

            keymap("n", "<leader>Hr", gitsigns.reset_hunk, opts)
            keymap("v", "<leader>Hr", function()
                gitsigns.reset_hunk { vim.fn.line("."), vim.fn.line("v") }
            end, opts)
            keymap("n", "<leader>HR", gitsigns.reset_buffer, opts)

            keymap("n", "<leader>Hp", gitsigns.preview_hunk, opts)

            keymap("n", "<leader>Hb", gitsigns.toggle_current_line_blame, opts)
            keymap("n", "<leader>HB", function() gitsigns.blame_line { full = true } end, opts)

            keymap("n", "<leader>Hd", gitsigns.diffthis, opts)
            keymap("n", "<leader>HD", function() gitsigns.diffthis("~") end, opts)
        end
    }
}
