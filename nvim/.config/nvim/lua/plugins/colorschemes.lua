return {
    --- Colorschemes
    --'AlexvZyl/nordic.nvim', lazy = false, priority = 1000, config = function() require 'nordic' .load() end, --score 2, etwas heller background
    --"olimorris/onedarkpro.nvim", lazy = false, priority = 1000, -- score 2,5 (onedark); lsp+treesitter, nicht ganz so heller background
    --'projekt0n/github-nvim-theme', lazy = false, priority = 1000, -- score 2 (dimmed); lsp-treesitter, recht blau und hell
    {
        "savq/melange-nvim",
        lazy = false,
        priority = 1000, --score 3; treesitter, background gut, text recht hell
    },
    {
        "marko-cerovac/material.nvim",
        name = "material",
        lazy = false,
        priority = 1000, --score 3 (darker); lsp+treesitter,  recht nach an papercolor dran
    },
    {
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
        lazy = false,
        priority = 1000, -- score 3(dragon,wave), background gut, text etwas dunkel
        config = function()
            require("kanagawa").setup({
                keywordStyle = { italic = true },
                overrides = function(colors)
                    local palette = colors.palette
                    return {
                        String = { italic = true },
                        Boolean = { fg = palette.dragonPink },
                        Constant = { fg = palette.dragonPink },

                        Identifier = { fg = palette.dragonBlue },
                        Statement = { fg = palette.dragonBlue },
                        Operator = { fg = palette.dragonGray2 },
                        Keyword = { fg = palette.dragonRed },
                        Function = { fg = palette.dragonGreen },

                        Type = { fg = palette.dragonYellow },

                        Special = { fg = palette.dragonOrange },

                        ["@lsp.typemod.function.readonly"] = { fg = palette.dragonBlue },
                        ["@variable.member"] = { fg = palette.dragonBlue },
                    }
                end,
            })
            vim.cmd.colorscheme("kanagawa-dragon")
        end,
    },
}
