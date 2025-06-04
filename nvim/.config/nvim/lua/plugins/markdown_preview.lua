return {
    "iamcco/markdown-preview.nvim",
    ft = "markdown",
    build = function()
        vim.fn["mkdp#util#install"]()
    end,
    cmd = {
        "MarkdownPreviewToggle",
        "MarkdownPreview",
        "MarkdownPreviewStop",
    },
    config = function ()
        vim.g.mkdp_markdown_css = os.getenv("HOME") .. "/.config/nvim/markdown_styles/retro.css"
        vim.g.mkdp_highlight_css = os.getenv("HOME") .. "/.config/nvim/markdown_styles/retro-highlight.css"

    end,
}
