return {
    {
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
        lazy = false,
        priority = 1000, -- score 3(dragon,wave), background gut, text etwas dunkel
        config = function()
            require("kanagawa").setup({})
            vim.cmd.colorscheme("kanagawa-dragon")
        end,
    },
}
