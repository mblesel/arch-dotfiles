return {
    "MeanderingProgrammer/markdown.nvim",
    name = "render-markdown",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        vim.cmd([[highlight Headline1 guibg=#f1fc79 guifg=#323449]])
        vim.cmd([[highlight Headline2 guibg=#37f499 guifg=#323449]])
        vim.cmd([[highlight Headline3 guibg=#04d1f9 guifg=#323449]])
        vim.cmd([[highlight Headline4 guibg=#a48cf2 guifg=#323449]])
        vim.cmd([[highlight Headline5 guibg=#f1fc79 guifg=#323449]])
        vim.cmd([[highlight Headline6 guibg=#f7c67f guifg=#323449]])
        require("render-markdown").setup({

            file_types = { "markdown", "Avante" },
            render_modes = true,
            anti_conceal = {
                enabled = true,
                -- Which elements to always show, ignoring anti conceal behavior. Values can either be
                -- booleans to fix the behavior or string lists representing modes where anti conceal
                -- behavior will be ignored. Valid values are:
                --   head_icon, head_background, head_border, code_language, code_background, code_border,
                --   dash, bullet, check_icon, check_scope, quote, table_border, callout, link, sign
                ignore = {
                    head_background = true,
                    head_border = true,
                    sign = true,
                    code_background = true,
                    code_language = true,
                    code_border = true,
                },
                above = 0,
                below = 0,
            },
            ft = { "markdown", "Avante" },
            heading = {
                -- Turn on / off heading icon & background rendering
                enabled = true,
                sign = false,
                -- -- Replaces '#+' of 'atx_h._marker'
                -- -- The number of '#' in the heading determines the 'level'
                -- -- The 'level' is used to index into the array using a cycle
                -- -- The result is left padded with spaces to hide any additional '#'
                icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
                -- -- Added to the sign column
                -- -- The 'level' is used to index into the array using a cycle
                -- signs = { '󰫎 ' },
                -- -- The 'level' is used to index into the array using a clamp
                -- -- Highlight for the heading icon and extends through the entire line
                -- backgrounds = { 'DiffAdd', 'DiffChange', 'DiffDelete' },
                -- -- The 'level' is used to index into the array using a clamp
                -- -- Highlight for the heading and sign icons

                foregrounds = {
                    "@markup.heading.1.markdown",
                    "@markup.heading.2.markdown",
                    "@markup.heading.3.markdown",
                    "@markup.heading.4.markdown",
                    "@markup.heading.5.markdown",
                    "@markup.heading.6.markdown",
                },
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
                -- Turn on / off code block & inline code rendering
                enabled = true,
                -- Determines how code blocks & inline code are rendered:
                --  none: disables all rendering
                --  normal: adds highlight group to code blocks & inline code
                --  language: adds language icon to sign column and icon + name above code blocks
                --  full: normal + language
                style = "full",
                -- Highlight for code blocks & inline code
                highlight = "ColorColumn",
            },
            dash = {
                -- Turn on / off thematic break rendering
                enabled = true,
                -- Replaces '---'|'***'|'___'|'* * *' of 'thematic_break'
                -- The icon gets repeated across the window's width
                icon = "─",
                -- Highlight for the whole line generated from the icon
                highlight = "LineNr",
            },
            bullet = {
                -- Turn on / off list bullet rendering
                enabled = true,
                -- Replaces '-'|'+'|'*' of 'list_item'
                -- How deeply nested the list is determines the 'level'
                -- The 'level' is used to index into the array using a cycle
                -- If the item is a 'checkbox' a conceal is used to hide the bullet instead
                icons = { "●", "○", "◆", "◇" },
                -- Highlight for the bullet icon
                highlight = "Normal",
            },
            checkbox = {
                -- Turn on / off checkbox state rendering
                enabled = true,
                unchecked = {
                    -- Replaces '[ ]' of 'task_list_marker_unchecked'
                    icon = "󰄱 ",
                    -- Highlight for the unchecked icon
                    highlight = "@markup.list.unchecked",
                },
                checked = {
                    -- Replaces '[x]' of 'task_list_marker_checked'
                    icon = "󰱒 ",
                    -- Highligh for the checked icon
                    highlight = "@markup.heading",
                },
                -- Define custom checkbox states, more involved as they are not part of the markdown grammar
                -- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks
                -- Can specify as many additional states as you like following the 'todo' pattern below
                --   The key in this case 'todo' is for healthcheck and to allow users to change its values
                --   'raw': Matched against the raw text of a 'shortcut_link'
                --   'rendered': Replaces the 'raw' value when rendering
                --   'highlight': Highlight for the 'rendered' icon
                custom = {
                    todo = { raw = "[-]", rendered = "󰥔 ", highlight = "@markup.raw" },
                },
            },
            quote = {
                -- Turn on / off block quote & callout rendering
                enabled = true,
                -- Replaces '>' of 'block_quote'
                icon = "▋",
                -- Highlight for the quote icon
                highlight = "@markup.quote",
            },
            pipe_table = {
                -- Turn on / off pipe table rendering
                enabled = true,
                -- Determines how the table as a whole is rendered:
                --  none: disables all rendering
                --  normal: applies the 'cell' style rendering to each row of the table
                --  full: normal + a top & bottom line that fill out the table when lengths match
                style = "normal",
                -- Determines how individual cells of a table are rendered:
                --  overlay: writes completely over the table, removing conceal behavior and highlights
                --  raw: replaces only the '|' characters in each row, leaving the cells unmodified
                --  padded: raw + cells are padded with inline extmarks to make up for any concealed text
                cell = "padded",
                -- Characters used to replace table border
                -- Correspond to top(3), delimiter(3), bottom(3), vertical, & horizontal
                -- stylua: ignore
                border = {
                    '┌', '┬', '┐',
                    '├', '┼', '┤',
                    '└', '┴', '┘',
                    '│', '─',
                },
                -- Highlight for table heading, delimiter, and the line above
                head = "@markup.heading",
                -- Highlight for everything else, main table rows and the line below
                row = "Normal",
                -- Highlight for inline padding used to add back concealed space
                filler = "Conceal",
            },
        })
    end,
}
