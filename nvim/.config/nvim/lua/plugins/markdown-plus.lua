return {
    "yousefhadder/markdown-plus.nvim",
    ft = "markdown",
    opts = {
        enabled = true,

        features = {
            list_management = true,
            text_formatting = true,
            code_block = true,
            links = true,
            quotes = true,
            callouts = true,
            table = true,
            footnotes = true,
            html_block_awareness = true,
            -- disabled
            images = false,
            thematic_break = false,
            headers_toc = false,
        },

        keymaps = {
            enabled = true,
        },

        filetypes = { "markdown" },

        list = {
            smart_outdent = true,
            checkbox_completion = {
                enabled = false,
            },
        },

        callouts = {
            default_type = "NOTE",
            custom_types = {},
        },

        code_block = {
            enabled = true,
            fence_style = "backtick", -- "backtick" | "tilde"
            languages = { "lua", "python", "javascript", "typescript", "bash", "json", "yaml", "markdown" },
        },

        table = {
            enabled = true,
            auto_format = true,
            default_alignment = "left",
            confirm_destructive = true,
        },

        footnotes = {
            section_header = "Footnotes",
            confirm_delete = true,
        },

        links = {
            smart_paste = {
                enabled = true,
                timeout = 5, -- 1..30
            },
        },
    },

    init = function()
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "markdown",
            callback = function(args)
                -- Defer so it runs after the plugin sets its mappings
                vim.schedule(function()
                    pcall(vim.keymap.del, "i", "<C-T>", { buffer = args.buf })
                    pcall(vim.keymap.del, "i", "<Tab>", { buffer = args.buf })
                    pcall(vim.keymap.del, "i", "<S-Tab>", { buffer = args.buf })
                end)
            end,
        })
    end,
}
