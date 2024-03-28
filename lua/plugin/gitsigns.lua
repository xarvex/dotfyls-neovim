return {
    "lewis6991/gitsigns.nvim",
    event = { "BufNewFile", "BufReadPre" },
    opts = {
        on_attach = function(bufnr)
            local gitsigns = require("gitsigns")

            local opts = { buffer = bufnr }

            vim.keymap.set("n", "[g", function()
                if vim.wo.diff then return "[c" end
                vim.schedule(function() gitsigns.prev_hunk() end)
                return "<Ignore>"
            end, { buffer = bufnr, expr = true })
            vim.keymap.set("n", "]g", function()
                if vim.wo.diff then return "]c" end
                vim.schedule(function() gitsigns.next_hunk() end)
                return "<Ignore>"
            end, { buffer = bufnr, expr = true })

            vim.keymap.set("n", "<leader>Hs", gitsigns.stage_hunk, opts)
            vim.keymap.set("v", "<leader>Hs", function()
                gitsigns.stage_hunk { vim.fn.line("."), vim.fn.line("v") }
            end, opts)
            vim.keymap.set("n", "<leader>HS", gitsigns.stage_buffer, opts)

            vim.keymap.set("n", "<leader>Hu", gitsigns.undo_stage_hunk, opts)

            vim.keymap.set("n", "<leader>Hr", gitsigns.reset_hunk, opts)
            vim.keymap.set("v", "<leader>Hr", function()
                gitsigns.reset_hunk { vim.fn.line("."), vim.fn.line("v") }
            end, opts)
            vim.keymap.set("n", "<leader>HR", gitsigns.reset_buffer, opts)

            vim.keymap.set("n", "<leader>Hp", gitsigns.preview_hunk, opts)

            vim.keymap.set("n", "<leader>Hb", gitsigns.toggle_current_line_blame, opts)
            vim.keymap.set("n", "<leader>HB", function() gitsigns.blame_line { full = true } end, opts)

            vim.keymap.set("n", "<leader>Hd", gitsigns.diffthis, opts)
            vim.keymap.set("n", "<leader>HD", function() gitsigns.diffthis("~") end, opts)
        end
    }
}
