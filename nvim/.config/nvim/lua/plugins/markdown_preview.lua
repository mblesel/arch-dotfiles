return {
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        build = "cd app && yarn install",
        ft = "markdown",
        init = function()
            vim.g.mkdp_filetypes = { "markdown" }
        end,
        config = function()
            vim.g.mkdp_markdown_css = os.getenv("HOME") .. "/.config/nvim/markdown_styles/retro.css"
            vim.g.mkdp_highlight_css = os.getenv("HOME") .. "/.config/nvim/markdown_styles/retro-highlight.css"
        end,
    },
}
