return {
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
                cond = vim.fn.executable("cmake") == 1,
            },
            "chip/telescope-software-licenses.nvim",
            "ghassan0/telescope-glyph.nvim",
            "xiyaowong/telescope-emoji.nvim",
        },
        config = function()
            local actions = require("telescope.actions")

            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-q>"] = actions.smart_send_to_qflist,
                            ["<C-x>"] = actions.delete_buffer,
                        },
                    },
                    file_ignore_patterns = {
                        "node_modules",
                        "yarn.lock",
                        "%.sl",
                        "%.git",
                        "_build",
                        "%.next",
                    },
                    hidden = true,
                    extensions = {
                        fzf = {
                            fuzzy = true, -- false will only do exact matching
                            override_generic_sorter = true, -- override the generic sorter
                            override_file_sorter = true, -- override the file sorter
                            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                        },
                        glyph = {
                            action = function(glyph)
                                -- argument glyph is a table.
                                -- {name="", value="", category="", description=""}
                                vim.fn.setreg("", glyph.value)
                                print([[Press p or "*p to paste this glyph]] .. glyph.value)
                                -- insert glyph when picked
                                -- vim.api.nvim_put({ glyph.value }, 'c', false, true)
                            end,
                        },
                        emoji = {
                            action = function(emoji)
                                -- argument emoji is a table.
                                -- {name="", value="", cagegory="", description=""}
                                vim.fn.setreg("", emoji.value)
                                print([[Press p or "*p to paste this emoji]] .. emoji.value)
                                -- insert emoji when picked
                                -- vim.api.nvim_put({ emoji.value }, 'c', false, true)
                            end,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        follow = true,
                    },
                    -- Not yet supported in release branch
                    -- marks = {
                    --     attach_mappings = function(prompt_bufnr, map)
                    --         map("i", "<C-d>", function()
                    --             require("telescope.actions").delete_mark(prompt_bufnr)
                    --         end)
                    --         return true -- Keep default mappings as well as the custom ones
                    --     end,
                    -- },
                },
            })

            -- Enable telescope fzf native, if installed
            pcall(require("telescope").load_extension, "fzf")
            require("telescope").load_extension("software-licenses")
            require("telescope").load_extension("glyph")
            require("telescope").load_extension("emoji")
            require("telescope").load_extension("markit")
        end,
    },
}
