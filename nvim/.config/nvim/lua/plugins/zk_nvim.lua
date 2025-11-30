return {
    "zk-org/zk-nvim",
    config = function()
        require("zk").setup({
            picker = "snacks_picker",
            lsp = {
                config = {
                    cmd = { "zk", "lsp" },
                    name = "zk",
                },
                auto_attach = {
                    enabled = true,
                    filetypes = { "markdown" },
                },
            },
        })
    end,
}
