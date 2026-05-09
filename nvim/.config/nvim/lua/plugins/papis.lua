return {
    "jghauser/papis.nvim",
    dependencies = {
        "kkharji/sqlite.lua",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("papis").setup({
            -- You might want to change the filetypes activating papis.nvim
            init_filetypes = { "markdown", "norg", "yaml", "typst", "tex", "alpha" },

            -- Configuration of the search module.
            ["search"] = {
                enable = true,
                provider = "snacks",

                -- Picker keymaps
                picker_keymaps = {
                    ["<CR>"] = { "ref_insert", mode = { "n", "i" }, desc = "(Papis) Insert ref" },
                    ["r"] = { "ref_insert_formatted", mode = "n", desc = "(Papis) Insert formatted ref" },
                    ["<c-r>"] = { "ref_insert_formatted", mode = "i", desc = "(Papis) Insert formatted ref" },
                    ["f"] = { "open_file", mode = "n", desc = "(Papis) Open file" },
                    ["<c-f>"] = { "open_file", mode = "i", desc = "(Papis) Open file" },
                    ["n"] = { "open_note", mode = "n", desc = "(Papis) Open note" },
                    ["<c-n>"] = { "open_note", mode = "i", desc = "(Papis) Open note" },
                    ["e"] = { "open_info", mode = "n", desc = "(Papis) Open info.yaml file" },
                    ["<c-e>"] = { "open_info", mode = "i", desc = "(Papis) Open info.yaml file" },
                },
                -- What keys to search for matches.
                search_keys = { "author", "editor", "year", "title", "tags" },
            },
            -- Configuration of the at-cursor module.
            ["at-cursor"] = {
                enable = true,
                -- Configuration of the popup that automatically appears when the cursor is on a `ref` in normal mode
                auto_popup = {
                    -- Whether to automatically show the popup
                    enable = true,
                    -- The delay (in ms) after which to show the popup after the cursor has been moved to it
                    delay = 1000,
                },
            },
            -- Configuration of formatter module.
            ["formatter"] = {
                enable = true,
            },
            -- You can enable disabled modules (e.g. the 'ask' module) like so:
            ["ask"] = {
                enable = false,
            },
            -- Configuration of the debug module
            ["debug"] = {

                -- Whether to enable this module.
                enable = true,
            },
        })
    end,

    -- NOTE not sure if this is placed well here in the init function, but seems to work
    init = function()
        vim.api.nvim_create_autocmd("ColorScheme", {
            pattern = "*",
            callback = function()
                vim.api.nvim_set_hl(0, "PapisResultsNotes", { bg = "none", nocombine = true })
            end,
        })
    end,
}
