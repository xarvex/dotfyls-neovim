local M = {}

function M.into_set(table)
    local set = {}
    for _, value in ipairs(table) do
        set[value] = true
    end

    return set
end

return M
