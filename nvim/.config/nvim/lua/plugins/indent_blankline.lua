return {
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufEnter",
        main = "ibl",
        config = function()
            require("ibl").setup({
                scope = {
                    enabled = true,
                    show_start = false,
                    show_end = false,
                },
            })
        end,
    },
}
