return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            -- TODO
            -- c = { "cpplint" },
            -- cpp = { "cpplint" },
            markdown = { "markdownlint" },
            bash = { "shellcheck" },
            -- python = { "pylint" },
        }

        -- https://github.com/mfussenegger/nvim-lint#customize-built-in-linters 
        -- In case linters need to be configured speciallly
        -- Most of the time a global config file would be better if the linter supports it

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave", "TextChanged" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })
    end,
}
