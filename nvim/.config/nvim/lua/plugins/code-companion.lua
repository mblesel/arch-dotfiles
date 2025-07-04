return {
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
        { "nvim-lua/plenary.nvim", branch = "master" },
        "j-hui/fidget.nvim",
        "nvim-treesitter/nvim-treesitter",
        "ravitemer/codecompanion-history.nvim",
        {
            "ravitemer/mcphub.nvim", -- Manage MCP servers
            cmd = "MCPHub",
            build = "npm install -g mcp-hub@latest",
            config = true,
        },
    },
    config = function()
        local spinner = require("plugins.plugins.spinner")
        spinner:init()
        require("codecompanion").setup({
            adapters = {
                opts = {
                    show_defaults = false,
                },
                openai_o3_mini = function()
                    return require("codecompanion.adapters").extend("openai", {
                        schema = {
                            model = {
                                default = "o3-mini-2025-01-31",
                            },
                        },
                    })
                end,
                openai_o3 = function()
                    return require("codecompanion.adapters").extend("openai", {
                        schema = {
                            model = {
                                default = "o3-2025-04-16",
                            },
                        },
                    })
                end,
                openai_o4_mini = function()
                    return require("codecompanion.adapters").extend("openai", {
                        schema = {
                            model = {
                                default = "o4-mini-2025-04-16",
                            },
                        },
                    })
                end,
                anthropic = function()
                    return require("codecompanion.adapters").extend("anthropic", {
                        schema = {
                            model = {
                                default = "claude-3-7-sonnet-20250219",
                            },
                        },
                    })
                end,
                tavily = function()
                    return require("codecompanion.adapters").extend("tavily", {
                        schema = {
                            model = {
                                default = "tavily",
                            },
                        },
                    })
                end,
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
                    prompt = "Prompt ", -- Prompt used for interactive LLM calls
                    provider = "default", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
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
                        -- Picker interface ("telescope" or "snacks" or "fzf-lua" or "default")
                        picker = "telescope",
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
                mcphub = {
                    callback = "mcphub.extensions.codecompanion",
                    opts = {
                        show_result_in_chat = true, -- Show mcp tool results in chat
                        make_vars = true, -- Convert resources to #variables
                        make_slash_commands = true, -- Add prompts as /slash commands
                    },
                },
            },
        })
    end,
}
