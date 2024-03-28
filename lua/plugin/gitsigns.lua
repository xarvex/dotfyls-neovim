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

            vim.keymap.set("n", "<leader>hs", gitsigns.stage_hunk, opts)
            vim.keymap.set("v", "<leader>hs", function()
                gitsigns.stage_hunk { vim.fn.line("."), vim.fn.line("v") }
            end, opts)
            vim.keymap.set("n", "<leader>hS", gitsigns.stage_buffer, opts)

            vim.keymap.set("n", "<leader>hu", gitsigns.undo_stage_hunk, opts)

            vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk, opts)
            vim.keymap.set("v", "<leader>hr", function()
                gitsigns.reset_hunk { vim.fn.line("."), vim.fn.line("v") }
            end, opts)
            vim.keymap.set("n", "<leader>hR", gitsigns.reset_buffer, opts)

            vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk, opts)

            vim.keymap.set("n", "<leader>hb", function() gitsigns.blame_line { full = true } end, opts)
            vim.keymap.set("n", "<leader>tb", gitsigns.toggle_current_line_blame, opts)

            vim.keymap.set("n", "<leader>hd", gitsigns.diffthis, opts)
            vim.keymap.set("n", "<leader>hD", function() gitsigns.diffthis("~") end, opts)
        end
    }
}
