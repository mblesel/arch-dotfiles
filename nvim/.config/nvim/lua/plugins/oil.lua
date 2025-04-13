return {
    {
        "stevearc/oil.nvim",
        -- dependencies = { { "echasnovski/mini.icons" } },
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup()
        end,
    },
}
