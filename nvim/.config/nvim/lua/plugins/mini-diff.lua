return {
    "nvim-mini/mini.diff",
    event = { "BufReadPre", "BufNewFile" },
    version = false,
    opts = {
        view = {
            style = "sign",
            signs = {
                add = "+",
                change = "~",
                delete = "-",
            },
        },
        -- currently don't want any of these mappings. Only want the overlay functionality and the gitsigns
        mappings = {
            apply = "",
            reset = "",
            textobject = "",
            goto_first = "",
            goto_prev = "",
            goto_next = "",
            goto_last = "",
        },
    },
}
