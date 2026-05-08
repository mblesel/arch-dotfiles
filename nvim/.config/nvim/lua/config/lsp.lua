return {

    require("mason-tool-installer").setup({
        ensure_installed = {
            --- LSPs
            "clangd",
            "marksman",
            "lua_ls",
            "bashls",
            "pyright",
            "texlab",
            "rust_analyzer",
            "harper_ls",
            --- Linters/Formatters
            "clang-format",
            "cpplint",
            "markdownlint",
            "stylua",
            "isort",
            "black",
            "shellcheck",
            "shfmt",
            -- "pylint",
        },
    }),

    --
    --- LSP configs
    --
    vim.lsp.config("lua_ls", {
        settings = {
            Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = {
                    checkThirdParty = false,
                    library = {
                        vim.env.VIMRUNTIME,
                    },
                },
                telemetry = { enable = false },
            },
        },
    }),

    vim.lsp.config("harper_ls", {
        cmd = { "harper-ls", "--stdio" },
        filetypes = { "markdown", "text", "tex", "typst" },
        settings = {
            ["harper-ls"] = {
                userDictPath = "",
                workspaceDictPath = "",
                fileDictPath = "",
                linters = {
                    -- https://writewithharper.com/docs/rules
                    SpellCheck = true,
                    SentenceCapitalization = false,
                    ToDoHyphen = false,
                },
                codeActions = {
                    ForceStable = true,
                },
                markdown = {
                    IgnoreLinkTitle = true,
                },
                diagnosticSeverity = "hint",
                isolateEnglish = true,
                dialect = "American",
                maxFileLength = 1200000,
                ignoredLintsPath = "",
                excludePatterns = {},
            },
        },
    }),

    vim.lsp.config("texlab", {
        settings = {
            texlab = {
                diagnostics = {
                    -- undefined reference needs to be ingored due to missing lstinputlisting support
                    -- https://github.com/latex-lsp/texlab/issues/1159
                    ignoredPatterns = { "Undefined reference", "Overfull", "Underfull"  },
                },
            },
        },
    }),

    --
    --- Enable LSPs
    --
    require("mason-lspconfig").setup({
        -- TODO maybe switch to manual activation or exclude some from automatic enabling
        automatic_enable = true,
        -- automatic_enable = {
        --     exclude = { "ts_ls" },
        -- },
    }),

    --
    --- Diagnostics settings
    --
    vim.diagnostic.config({
        severity_sort = true,
        update_in_insert = false,
        float = {
            border = "rounded",
            source = "if_many",
        },
        underline = true,
        virtual_text = {
            spacing = 2,
            source = "if_many",
            prefix = "●",
            current_line = true,
        },
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = " ",
                [vim.diagnostic.severity.WARN] = " ",
                [vim.diagnostic.severity.INFO] = " ",
                [vim.diagnostic.severity.HINT] = "󰠠 ",
            },
        },
    }),
}
