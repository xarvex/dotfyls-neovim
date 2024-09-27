return {
    "mfussenegger/nvim-lint",
    event = { "BufNewFile", "BufReadPost" },
    init = function()
        if require("dotfyls.shortcut").executable("codespell") then vim.o.spell = false end
    end,
    config = function()
        require("lint").linters_by_ft = {
            fish = { "fish" },
            lua = { "selene" },
            sh = { "shellcheck" },
            nix = { "deadnix", "statix" },
            zsh = { "zsh" },
        }

        local codespell_blacklist = require("dotfyls.list").into_set({ "markdown", "text", "tex" })
        local function lint(bufnr)
            local linters = vim.list_extend({}, require("lint")._resolve_linter_by_ft(vim.bo.filetype))
            if not codespell_blacklist[vim.bo.filetype] then linters[#linters + 1] = "codespell" end

            local ctx = { filename = vim.api.nvim_buf_get_name(bufnr or 0) }
            ctx.dirname = vim.fn.fnamemodify(ctx.filename, ":h")

            linters = vim.tbl_filter(function(name)
                local linter = require("lint").linters[name]
                return require("dotfyls.shortcut").executable(linter.cmd)
                    ---@diagnostic disable-next-line: undefined-field
                    and not (type(linter) == "table" and linter.condition and not linter.condition(ctx))
            end, linters)

            if #linters > 0 then require("lint").try_lint(linters) end
        end

        lint()

        local timer = vim.uv.new_timer()
        vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
            group = require("dotfyls.shortcut").group,
            callback = function(args)
                timer:start(100, 0, function()
                    timer:stop()
                    vim.schedule_wrap(lint)(args.buf)
                end)
            end,
            desc = "Lint (nvim-lint)",
        })
    end,
}
