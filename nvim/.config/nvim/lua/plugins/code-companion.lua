return {
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
        { "nvim-lua/plenary.nvim", branch = "master" },
        "nvim-treesitter/nvim-treesitter",
        "ravitemer/codecompanion-history.nvim",
    },
    config = function()
        local spinner = require("plugins.plugins.spinner")
        spinner:init()
        require("codecompanion").setup({
            interactions = {
                chat = {
                    name = "anthropic",
                    -- model = "TODO",
                    opts = {
                        completion_provider = "blink", -- blink|cmp|coc|default
                    },
                    cons = {
                        chat_context = "📎️", -- You can also apply an icon to the fold
                    },
                    fold_context = true,
                },
            },
            adapters = {
                http = {
                    anthropic = function()
                        return require("codecompanion.adapters").extend("anthropic", {
                            schema = {
                                model = {
                                    default = "claude-opus-4-7",
                                },
                            },
                        })
                    end,
                    openai = function()
                        return require("codecompanion.adapters").extend("openai", {
                            schema = {
                                model = {
                                    default = "gpt-5.5",
                                },
                            },
                        })
                    end,
                    xai = function()
                        return require("codecompanion.adapters").extend("xai", {
                            schema = {
                                model = {
                                    default = "grok-4.3",
                                },
                            },
                            opts = {
                                vision = true,
                                stream = true,
                            },
                        })
                    end,
                },
            },
            prompt_library = {
                markdown = {
                    dirs = {
                        vim.fn.getcwd() .. "/.prompts", -- Can be relative
                        "~/.config/nvim/prompts", -- Or absolute paths
                    },
                },
            },
            strategies = {
                chat = {
                    -- adapter = "openai",
                    adapter = "anthropic",
                    keymaps = {
                        send = {
                            callback = function(chat)
                                vim.cmd("stopinsert")
                                chat:submit()
                                chat:add_buf_message({ role = "llm", content = "" })
                            end,
                            index = 1,
                            description = "Send",
                        },
                    },
                },
                inline = {
                    -- adapter = "openai",
                    adapter = "anthropic",
                },
                cmd = {
                    -- adapter = "openai",
                    adapter = "anthropic",
                },
            },
            display = {
                action_palette = {
                    -- width = 95,
                    -- height = 10,
                    prompt = "Prompt ",
                    provider = "snacks",
                    opts = {
                        show_default_actions = true, -- Show the default actions in the action palette?
                        show_default_prompt_library = true, -- Show the default prompt library in the action palette?
                    },
                },
                chat = {
                    show_settings = true,
                },
                -- diff = {
                --     provider = "mini_diff", -- default|mini_diff
                -- },
            },
            extensions = {
                history = {
                    enabled = true,
                    opts = {
                        -- Keymap to open history from chat buffer (default: gh)
                        keymap = "gh",
                        -- Keymap to save the current chat manually (when auto_save is disabled)
                        save_chat_keymap = "sc",
                        -- Save all chats by default (disable to save only manually using 'sc')
                        auto_save = true,
                        -- Number of days after which chats are automatically deleted (0 to disable)
                        expiration_days = 0,
                        picker = "snacks",
                        -- Customize picker keymaps (optional)
                        picker_keymaps = {
                            rename = { n = "r", i = "<M-r>" },
                            delete = { n = "d", i = "<M-d>" },
                            duplicate = { n = "<C-y>", i = "<C-y>" },
                        },
                        ---Automatically generate titles for new chats
                        auto_generate_title = true,
                        title_generation_opts = {
                            ---Adapter for generating titles (defaults to active chat's adapter)
                            adapter = nil, -- e.g "copilot"
                            ---Model for generating titles (defaults to active chat's model)
                            model = nil, -- e.g "gpt-4o"
                            ---Number of user prompts after which to refresh the title (0 to disable)
                            refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
                            ---Maximum number of times to refresh the title (default: 3)
                            max_refreshes = 3,
                        },
                        ---On exiting and entering neovim, loads the last chat on opening chat
                        continue_last_chat = false,
                        ---When chat is cleared with `gx` delete the chat from history
                        delete_on_clearing_chat = false,
                        ---Directory path to save the chats
                        dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
                        ---Enable detailed logging for history extension
                        enable_logging = false,
                        ---Optional filter function to control which chats are shown when browsing
                        chat_filter = function(chat_data)
                            return chat_data.cwd == vim.fn.getcwd()
                        end,
                    },
                },
            },
        })
    end,
}
