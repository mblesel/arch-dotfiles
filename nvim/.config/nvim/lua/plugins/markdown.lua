return {
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        vim.cmd([[highlight Headline1 guibg=#f1fc79 gui=bold guifg=#323449]])
        vim.cmd([[highlight Headline2 guibg=#37f499 gui=bold guifg=#323449]])
        vim.cmd([[highlight Headline3 guibg=#04d1f9 gui=bold guifg=#323449]])
        vim.cmd([[highlight Headline4 guibg=#a48cf2 gui=bold guifg=#323449]])
        vim.cmd([[highlight Headline5 guibg=#f1fc79 gui=bold guifg=#323449]])
        vim.cmd([[highlight Headline6 guibg=#f7c67f gui=bold guifg=#323449]])

        require("render-markdown").setup({

            file_types = { "markdown", "codecompanion" },
            render_modes = true,
            completions = { lsp = { enabled = true } },
            anti_conceal = {
                enabled = true,
                disabled_modes = false,
                ignore = {
                    head_background = true,
                    head_border = true,
                    sign = true,
                    code_background = true,
                    code_language = true,
                },
                above = 0,
                below = 0,
            },
            ft = { "markdown", "codecompanion" },
            heading = {
                enabled = true,
                sign = false,
                icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
                backgrounds = {
                    "Headline1",
                    "Headline2",
                    "Headline3",
                    "Headline4",
                    "Headline5",
                    "Headline6",
                },
            },
            code = {
                enabled = true,
                style = "full",
                highlight = "ColorColumn",
            },
            dash = {
                enabled = true,
                icon = "─",
                highlight = "LineNr",
            },
            bullet = {
                enabled = true,
                icons = { "●", "○", "◆", "◇" },
                highlight = "Normal",
            },
            checkbox = {
                enabled = true,
                unchecked = {
                    icon = "󰄱 ",
                    highlight = "@markup.list.unchecked",
                },
                checked = {
                    icon = "󰱒 ",
                    highlight = "@markup.heading",
                },
                custom = {
                    todo = { raw = "[-]", rendered = "󰥔 ", highlight = "@markup.raw" },
                },
            },
            quote = {
                enabled = true,
                icon = "▋",
                highlight = "@markup.quote",
            },
            pipe_table = {
                enabled = true,
                style = "normal",
                cell = "padded",
                border = {
                    '┌', '┬', '┐',
                    '├', '┼', '┤',
                    '└', '┴', '┘',
                    '│', '─',
                },
                head = "@markup.heading",
                row = "Normal",
                filler = "Conceal",
            },
        })
    end,
}
