return {
    "aznhe21/actions-preview.nvim",
    config = function()
        require("actions-preview").setup({
            -- options for vim.diff(): https://neovim.io/doc/user/lua.html#vim.diff()
            diff = { ctxlen = 3 },
            -- priority list of preferred backend
            backend = { "snacks" },
            --- options for snacks picker
            ---@type snacks.picker.Config
            snacks = {
                layout = { preset = "default" },
            },
        })
    end,
}
