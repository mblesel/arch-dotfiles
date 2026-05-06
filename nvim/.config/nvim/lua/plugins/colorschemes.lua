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
    -- light mode themes for presentations
    {
        "sainnhe/edge",
        lazy = false,
        priority = 1000,
        config = function()
            -- Optionally configure and load the colorscheme
            -- directly inside the plugin declaration.
            vim.g.edge_enable_italic = true
            -- vim.cmd.colorscheme("edge")
        end,
    },
    {
        "projekt0n/github-nvim-theme",
        name = "github-theme",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- require("github-theme").setup({ })
            -- vim.cmd("colorscheme github_light_high_contrast")
        end,
    },
}
