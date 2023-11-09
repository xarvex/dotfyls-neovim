return {
    "mbbill/undotree",
    cmd = {
        "UndotreeFocus",
        "UndotreeHide",
        "UndotreePersistUndo",
        "UndotreeShow",
        "UndotreeToggle"
    },
    keys = {
        { "<leader>u", vim.cmd.UndotreeToggle }
    }
}
