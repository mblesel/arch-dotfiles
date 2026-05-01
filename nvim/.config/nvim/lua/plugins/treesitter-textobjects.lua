return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    init = function()
        -- Disable entire built-in ftplugin mappings to avoid conflicts.
        -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
        vim.g.no_plugin_maps = true
    end,
    config = function()
        require("nvim-treesitter-textobjects").setup({
            select = {
                -- Automatically jump forward to textobj, similar to targets.vim
                lookahead = true,
                -- You can choose the select mode (default is charwise 'v')

                selection_modes = {
                    ["@parameter.outer"] = "v", -- charwise
                    ["@function.outer"] = "V", -- linewise
                    -- ["@class.outer"] = "<c-v>", -- blockwise
                },
                include_surrounding_whitespace = false,
            },
            move = {
                -- whether to set jumps in the jumplist
                set_jumps = true,
            },
        })
        --- Keymaps
        -- Selects
        local select = require("nvim-treesitter-textobjects.select")
        vim.keymap.set({ "x", "o" }, "a=", function() select.select_textobject("@assignment.outer", "textobjects") end)
        vim.keymap.set({ "x", "o" }, "i=", function() select.select_textobject("@assignment.inner", "textobjects") end)
        vim.keymap.set({ "x", "o" }, "l=", function() select.select_textobject("@assignment.lhs",   "textobjects") end)
        vim.keymap.set({ "x", "o" }, "r=", function() select.select_textobject("@assignment.rhs",   "textobjects") end)

        vim.keymap.set({ "x", "o" }, "as", function() select.select_textobject("@block.outer",   "textobjects") end)

        vim.keymap.set({ "x", "o" }, "ic", function() select.select_textobject("@call.inner",   "textobjects") end)
        vim.keymap.set({ "x", "o" }, "ac", function() select.select_textobject("@call.outer",   "textobjects") end)

        vim.keymap.set({ "x", "o" }, "io", function() select.select_textobject("@class.inner",   "textobjects") end)
        vim.keymap.set({ "x", "o" }, "ao", function() select.select_textobject("@class.outer",   "textobjects") end)

        vim.keymap.set({ "x", "o" }, "i/", function() select.select_textobject("@comment.inner",   "textobjects") end)
        vim.keymap.set({ "x", "o" }, "a/", function() select.select_textobject("@comment.outer",   "textobjects") end)

        vim.keymap.set({ "x", "o" }, "ii", function() select.select_textobject("@conditional.inner", "textobjects") end)
        vim.keymap.set({ "x", "o" }, "ai", function() select.select_textobject("@conditional.outer", "textobjects") end)
        
        vim.keymap.set({ "x", "o" }, "if", function() select.select_textobject("@function.inner",   "textobjects") end)
        vim.keymap.set({ "x", "o" }, "af", function() select.select_textobject("@function.outer",   "textobjects") end)
        
        vim.keymap.set({ "x", "o" }, "il", function() select.select_textobject("@loop.inner",   "textobjects") end)
        vim.keymap.set({ "x", "o" }, "al", function() select.select_textobject("@loop.outer",   "textobjects") end)
        
        vim.keymap.set({ "x", "o" }, "ia", function() select.select_textobject("@parameter.inner",   "textobjects") end)
        vim.keymap.set({ "x", "o" }, "aa", function() select.select_textobject("@parameter.outer",   "textobjects") end)
        
        -- TODO check this
        -- You can also use captures from other query groups like `locals.scm`
        -- vim.keymap.set({ "x", "o" }, "as", function() select.select_textobject("@local.scope", "locals") end)

        -- Moves
        local move = require("nvim-treesitter-textobjects.move")
        vim.keymap.set({ "n", "x", "o" }, "]=", function() move.goto_next_start("@assignment.inner", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "]a", function() move.goto_next_start("@parameter.inner", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "]i", function() move.goto_next_start("@conditional.outer","textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "]l", function() move.goto_next_start("@loop.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "]c", function() move.goto_next_start("@call.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "]f", function() move.goto_next_start("@function.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "]o", function() move.goto_next_start("@class.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "]/", function() move.goto_next_start("@comment.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "]s", function() move.goto_next_start("@block.outer", "textobjects") end)

        vim.keymap.set({ "n", "x", "o" }, "]A", function() move.goto_next_end("@parameter.inner", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "]I", function() move.goto_next_end("@conditional.outer","textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "]L", function() move.goto_next_end("@loop.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "]C", function() move.goto_next_end("@call.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "]F", function() move.goto_next_end("@function.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "]O", function() move.goto_next_end("@class.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "]S", function() move.goto_next_end("@block.outer", "textobjects") end)

        vim.keymap.set({ "n", "x", "o" }, "[=", function() move.goto_previous_start("@assignment.inner", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "[a", function() move.goto_previous_start("@parameter.inner", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "[i", function() move.goto_previous_start("@conditional.outer","textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "[l", function() move.goto_previous_start("@loop.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "[c", function() move.goto_previous_start("@call.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "[f", function() move.goto_previous_start("@function.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "[o", function() move.goto_previous_start("@class.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "[/", function() move.goto_previous_start("@comment.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "[s", function() move.goto_previous_start("@block.outer", "textobjects") end)

        vim.keymap.set({ "n", "x", "o" }, "[A", function() move.goto_previous_end("@parameter.inner", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "[I", function() move.goto_previous_end("@conditional.outer","textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "[L", function() move.goto_previous_end("@loop.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "[C", function() move.goto_previous_end("@call.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "[F", function() move.goto_previous_end("@function.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "[O", function() move.goto_previous_end("@class.outer", "textobjects") end)
        vim.keymap.set({ "n", "x", "o" }, "[S", function() move.goto_previous_end("@block.outer", "textobjects") end)

        -- Swaps
        -- TODO activate this?
        -- local swap = require("nvim-treesitter-textobjects.swap")
        -- vim.keymap.set("n", "<leader>a", function() swap.swap_next "@parameter.inner" end)
        -- vim.keymap.set("n", "<leader>A", function() swap.swap_previous "@parameter.outer" end)
        

        -- repeatable motions
        local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"
        -- Repeat movement with ; and ,
        -- ensure ; goes forward and , goes backward regardless of the last direction
        vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
        vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
        -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
        vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
        vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
    end,
}

--- old config from master branch version
--     config = function()
--         ---@diagnostic disable-next-line: missing-fields
--         require("nvim-treesitter.configs").setup({
--             textobjects = {
--                 select = {
--                     enable = true,
--                     -- Automatically jump forward to textobj, similar to targets.vim
--                     lookahead = true,
--
--                     keymaps = {
--                         -- You can use the capture groups defined in textobjects.scm
--                         ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
--                         ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
--                         ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
--                         ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },
--
--                         ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
--                         ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },
--
--                         ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
--                         ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },
--
--                         ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
--                         ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },
--
--                         ["ac"] = { query = "@call.outer", desc = "Select outer part of a function call" },
--                         ["ic"] = { query = "@call.inner", desc = "Select inner part of a function call" },
--
--                         ["af"] = { query = "@function.outer", desc = "Select outer part of a function definition" },
--                         ["if"] = { query = "@function.inner", desc = "Select inner part of a function definition" },
--
--                         ["ao"] = { query = "@class.outer", desc = "Select outer part of a class" },
--                         ["io"] = { query = "@class.inner", desc = "Select inner part of a class" },
--
--                         ["at"] = { query = "@comment.outer", desc = "Select outer part of a comment" },
--                         ["it"] = { query = "@comment.inner", desc = "Select inner part of a comment" },
--
--                         ["as"] = { query = "@block.outer", query_group = "locals", desc = "Select language scope" },
--                     },
--                 },
--                 move = {
--                     enable = true,
--                     set_jumps = true, -- whether to set jumps in the jumplist
--                     goto_next_start = {
--                         ["]c"] = { query = "@call.outer", desc = "Next function call start" },
--                         ["]f"] = { query = "@function.outer", desc = "Next method/function def start" },
--                         ["]o"] = { query = "@class.outer", desc = "Next class start" },
--                         ["]t"] = { query = "@comment.outer", desc = "Next comment start" },
--                         ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
--                         ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
--
--                         ["]s"] = { query = "@block.outer", query_group = "locals", desc = "Next scope" },
--                         ["]a"] = { query = "@paramter.inner", desc = "Next parameter start" },
--                     },
--                     goto_next_end = {
--                         ["]C"] = { query = "@call.outer", desc = "Next function call end" },
--                         ["]F"] = { query = "@function.outer", desc = "Next method/function def end" },
--                         ["]O"] = { query = "@class.outer", desc = "Next class end" },
--                         ["]T"] = { query = "@comment.outer", desc = "Next comment end" },
--                         ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
--                         ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
--                         ["]S"] = { query = "@block.outer", query_group = "locals", desc = "Next scope" },
--                         ["]A"] = { query = "@paramter.inner", desc = "Next parameter start" },
--                     },
--                     goto_previous_start = {
--                         ["[c"] = { query = "@call.outer", desc = "Prev function call start" },
--                         ["[f"] = { query = "@function.outer", desc = "Prev method/function def start" },
--                         ["[o"] = { query = "@class.outer", desc = "Prev class start" },
--                         ["[t"] = { query = "@comment.outer", desc = "Prev comment start" },
--                         ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
--                         ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
--                         ["[s"] = { query = "@block.outer", query_group = "locals", desc = "Next scope" },
--                         ["[a"] = { query = "@paramter.inner", desc = "Next parameter start" },
--                     },
--                     goto_previous_end = {
--                         ["[C"] = { query = "@call.outer", desc = "Prev function call end" },
--                         ["[F"] = { query = "@function.outer", desc = "Prev method/function def end" },
--                         ["[O"] = { query = "@class.outer", desc = "Prev class end" },
--                         ["[T"] = { query = "@comment.outer", desc = "Prev comment end" },
--                         ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
--                         ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
--                         ["[S"] = { query = "@block.outer", query_group = "locals", desc = "Next scope" },
--                         ["[A"] = { query = "@paramter.inner", desc = "Next parameter start" },
--                     },
--                 },
--                 swap = {
--                     enable = true,
--                     swap_next = {
--                         ["<leader>a"] = "@parameter.inner",
--                     },
--                     swap_previous = {
--                         ["<leader>A"] = "@parameter.inner",
--                     },
--                 },
--             },
--         })
--     end,
-- }
