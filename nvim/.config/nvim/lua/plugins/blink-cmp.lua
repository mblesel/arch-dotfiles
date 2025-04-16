return {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = {
        -- { "rafamadriz/friendly-snippets" },
        -- { "L3MON4D3/LuaSnip", version = "v2.*" },
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp", -- if you're on windows remove this line
        dependencies = {
            "rafamadriz/friendly-snippets",
            config = function()
                require("luasnip.loaders.from_vscode").lazy_load()

                require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
            end,
        },
    },
    -- use a release tag to download pre-built binaries
    version = "1.*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
        -- 'super-tab' for mappings similar to vscode (tab to accept)
        -- 'enter' for enter to accept
        -- 'none' for no mappings
        --
        -- All presets have the following mappings:
        -- C-space: Open menu or open docs if already open
        -- C-n/C-p or Up/Down: Select next/previous item
        -- C-e: Hide menu
        -- C-k: Toggle signature help (if signature.enabled = true)
        --
        -- See :h blink-cmp-config-keymap for defining your own keymap
        keymap = {
            preset = "none",
            ["<C-H>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-V>"] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end },
            ["<C-E>"] = { "cancel" },
            ["<C-Z>"] = { "select_and_accept" },
            ["<C-S>"] = { "show_signature", "hide_signature", "fallback" },

            ["<C-K>"] = { "select_prev", "fallback" },
            ["<C-J>"] = { "select_next", "fallback" },
            ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
            ["<C-n>"] = { "select_next", "fallback_to_mappings" },

            ["<C-b>"] = { "scroll_documentation_up", "fallback" },
            ["<C-f>"] = { "scroll_documentation_down", "fallback" },

            ["<Tab>"] = { "snippet_forward", "fallback" },
            ["<S-Tab>"] = { "snippet_backward", "fallback" },
        },

        appearance = {
            -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
            -- Adjusts spacing to ensure icons are aligned
            nerd_font_variant = "mono",
        },

        -- (Default) Only show the documentation popup when manually triggered
        completion = {
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 500,
            },

            -- ghost_text = { enabled = true },
            -- menu = {
            --     -- nvim-cmp style menu
            --     draw = {
            --         columns = {
            --             { "label", "label_description", gap = 1 },
            --             { "kind_icon", "kind" },
            --         },
            --     },
            -- },
            menu = {
                draw = {
                    -- We don't need label_description now because label and label_description are already
                    -- combined together in label by colorful-menu.nvim.
                    columns = { { "kind_icon" }, { "label", gap = 1 } },
                    components = {
                        label = {
                            text = function(ctx)
                                return require("colorful-menu").blink_components_text(ctx)
                            end,
                            highlight = function(ctx)
                                return require("colorful-menu").blink_components_highlight(ctx)
                            end,
                        },
                    },
                },
            },
        },

        signature = {
            enabled = true,
            -- window = { show_documentation = true },
        },

        snippets = {
            preset = "luasnip",
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { "snippets",  "lsp", "buffer", "path" },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
