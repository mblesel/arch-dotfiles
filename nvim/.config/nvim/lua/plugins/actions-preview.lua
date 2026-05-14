return {
    "aznhe21/actions-preview.nvim",
    opts = {
        -- options for vim.diff(): https://neovim.io/doc/user/lua.html#vim.diff()
        diff = { ctxlen = 3 },
        -- priority list of preferred backend
        backend = { "snacks" },
        --- options for snacks picker
        snacks = {
            layout = { preset = "default" },
        },
    },
}
