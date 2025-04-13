return {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    opts = {
        symbol_folding = {
            -- Unfold entire symbol tree by default with false, otherwise enter a
            -- number starting from 1
            autofold_depth = false,
            -- autofold_depth = 1,
        },
    },
}
