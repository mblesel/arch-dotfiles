return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        picker = {
            enabled = true,
            ui_select = true, -- replace `vim.ui.select` with the snacks picker
            matcher = { frecency = true },
            hidden = true,
            follow = true,
            sources = {
                files = {
                    hidden = true,
                    follow = true,
                },
                explorer = {
                    hidden = false,
                    follow = true,
                },
            },
            exclude = { -- TODO add more stuff here
                "Downloads",
                "Games",
                "go",
                "Images",
                "%.git",
                "%.sl",
            },
        },
        explorer = {
            enabled = true,
            replace_netrw = true,
        },
        indent = {
            enabled = true,
        },
        input = {
            enabled = true,
        },
        notifier = {
            enabled = true,
            timeout = 5000,
            style = "fancy",
        },
    },

    -- NOTE not sure if this is placed well here in the init function, but seems to work
    -- and I want to keep in in the plugin file
    init = function()
        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "*",
            callback = function()
                vim.api.nvim_set_hl(0, "SnacksPicker", { bg = "none", nocombine = true })
                vim.api.nvim_set_hl(0, "SnacksPickerBorder", { fg = "#316c71", bg = "none", nocombine = true })
            end,
        })
    end,
}
