return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                c = { "clang-format" },
                cpp = { "clang-format" },
                markdown = { "markdownlint" },
                lua = { "stylua" },
                python = { "isort", "black" },
                bash = { "shfmt" },
            },
            formatters = {
                stylua = {
                    --TODO: function that checks if a local .stylua exists
                    -- Currently works if a .stylua exists in HOME
                    -- prepend_args = { "--config-path", "/home/michael/.stylua.toml" },
                },
            },
        })
    end,
}
