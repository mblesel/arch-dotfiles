return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        local autopairs = require("nvim-autopairs")
        autopairs.setup({
            check_ts = true,
            ts_config = {
                lua = { "string" }, -- don't add pairs in lua string treesitter nodes
            },
            fast_wrap = {},
        })
    end,
}
