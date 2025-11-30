return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    commit = "e76cb03c420bb74a5900a5b3e1dde776156af45f",
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
            },
        })
    end,
}
