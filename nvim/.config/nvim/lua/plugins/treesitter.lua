return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    branch = "main",
    config = function()
        require("nvim-treesitter").install({ "all" })
    end,
}
    --- old config
    -- dependencies = {
    --     "nvim-treesitter/nvim-treesitter-textobjects",
    -- },
    -- config = function()
    --     -- require("nvim-treesitter").install({"all"})
    --         local config = require("nvim-treesitter.configs")
    --         ---@diagnostic disable-next-line: missing-fields
    --         config.setup({
    --             ensure_installed = "all",
    --             ignore_install = { "ipkg" },
    --             highlight = {
    --                 enable = true,
    --                 -- disable = { "markdown"}
    --             },
    --             indent = {
    --                 enable = true,
    --                 -- disable = {"markdown"},
    --             },
    --             incremental_selection = {
    --                 enable = true,
    --                 keymaps = {
    --                     -- init_selection = "<C-X>",
    --                     -- node_incremental = "<C-X>",
    --                     scope_incremental = false,
    --                     node_decremental = "<bs>",
    --                 },
    --             },
    --         })
    -- end,
