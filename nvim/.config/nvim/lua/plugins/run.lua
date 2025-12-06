return {
    "https://codeberg.org/Ferhuce/run.nvim",
    opts = {
        -- Options here
    },
    config = function()
        require("run").setup({
            -- Keymaps
            keymaps = {
                -- A list with the keymaps to open and run commands in a terminal buffer.
                -- Each item must be a string representing a keymap to run the command
                -- corresponding to its index. Note: F25-F36 is for ctrl+F1-F12, if your
                -- terminal or shell does not recognize those you must change them here,
                -- you can press them while in insert to see what they are sent as.
                run = { "<F1>" },

                -- Open the buffer with the command corresponding to its index without
                -- running it.
                open = { "<F2>" },

                -- Edit the command corresponding to the buffer currently focused.
                edit = "<leader>re",

                -- Stop the process if it's still running, only created for the output buffer
                stop = "<C-c>",

                -- Stop and re run the command, if it's still running. Only created for
                -- the output buffer.
                rerun = "<C-r",

                -- Sends all accumulated error output to quickfix. Invalid entries (eg.
                -- when a line does not match any format in errorformat) are removed
                -- right after creating the list.
                send_to_quickfix = "<leader>rq",
            },

            -- The name of the terminal buffers. Buffers will be appended '(<command number>)'.
            buffer_name = "Run",

            -- If found in a line of the output, this along with the next lines are treated
            -- as error messages and sent to the quickfix list. They are parsed using vim.o.errorformat.
            error_patterns = {
                "error.*:",
                "ERROR.*:",
                "warning.*:",
                "WARNING.*:",
            },

            -- When the output is recognized as an error, all lines are stored until this
            -- many milliseconds has passed with no output. The lines can be sent to quickfix
            -- with require("run").send_to_quickfix(), or with the keymap 'config.keymaps.send_to_quickfix'
            error_wait_ms = 250,

            -- If true send captured errors, if any, to quickfix when the process finishes.
            send_to_quickfix_on_exit = true,
        })
    end,
}
