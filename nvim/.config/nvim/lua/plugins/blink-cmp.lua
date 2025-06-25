return {
    "saghen/blink.cmp",
    -- optional: provides snippets for the snippet source
    dependencies = {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp", -- if you're on windows remove this line
        opts = {
            histoy = false,
        },
        dependencies = {
            {
                "rafamadriz/friendly-snippets",
                config = function()
                    require("luasnip.loaders.from_vscode").lazy_load()
                    require("luasnip.loaders.from_vscode").lazy_load({
                        paths = { vim.fn.stdpath("config") .. "/snippets" },
                    })
                end,
            },
            "Kaiser-Yang/blink-cmp-avante",
            "moyiz/blink-emoji.nvim",
            "MahanRahmati/blink-nerdfont.nvim",
            {
                "supermaven-inc/supermaven-nvim",
                opts = {
                    keymaps = {
                        accept_suggestion = "<C-]>",
                        clear_suggestion = "<C-u>",
                        accept_word = "<C-l>",
                    },
                    disable_inline_completion = false, -- disables inline completion for use with cmp
                    disable_keymaps = false, -- disables built in keymaps for more manual control
                },
            },
            {
                "huijiro/blink-cmp-supermaven",
            },
        },
    },
    -- use a release tag to download pre-built binaries
    version = "1.*",

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = "none",
            ["<C-H>"] = { "show", "show_documentation", "hide_documentation" },
            ["<C-V>"] = {
                function(cmp)
                    cmp.show({ providers = { "snippets" } })
                end,
            },
            ["<C-E>"] = { "cancel" },
            ["<C-Y>"] = { "select_and_accept" },
            ["<C-S>"] = { "show_signature", "hide_signature", "fallback" },

            ["<C-K>"] = { "select_prev", "fallback" },
            ["<C-J>"] = { "select_next", "fallback" },
            ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
            ["<C-n>"] = { "select_next", "fallback_to_mappings" },

            ["<S-k>"] = { "scroll_documentation_up", "fallback" },
            ["<S-j>"] = { "scroll_documentation_down", "fallback" },

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
            default = { "snippets", "lsp", "buffer", "path", "emoji", "nerdfont" },
            -- per_filetype = {
            --     codecompanion = { "codecompanion " },
            -- },
            providers = {
                avante = {
                    module = "blink-cmp-avante",
                    name = "Avante",
                    opts = {},
                },
                supermaven = {
                    name = "supermaven",
                    module = "blink-cmp-supermaven",
                    async = true,
                },
                emoji = {
                    module = "blink-emoji",
                    name = "Emoji",
                    score_offset = -15, -- Tune by preference
                    opts = {
                        insert = true, -- Insert emoji (default) or complete its name
                        ---@type string|table|fun():table
                        trigger = function()
                            return { ":" }
                        end,
                    },
                    should_show_items = function()
                        return vim.tbl_contains(
                            -- Enable emoji completion only for git commits and markdown.
                            -- By default, enabled for all file-types.
                            { "gitcommit", "markdown" },
                            vim.o.filetype
                        )
                    end,
                },
                nerdfont = {
                    module = "blink-nerdfont",
                    name = "Nerd Fonts",
                    score_offset = -15, -- Tune by preference
                    opts = { insert = true }, -- Insert nerdfont icon (default) or complete its name
                },
            },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
