return {
    "sudo-tee/opencode.nvim",
    dependencies = {
        "folke/snacks.nvim",
        "saghen/blink.cmp",
        {
            "MeanderingProgrammer/render-markdown.nvim",
            ft = { "markdown", "opencode_output" },
        },
    },
    opts = {},
}
