return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    commit = "e76cb03c420bb74a5900a5b3e1dde776156af45f",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope.nvim",
            branch = "0.1.x",
        },
    },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({
            settings = {
                save_on_toggle = true,
                sync_on_ui_close = true,
                -- key = function()
                --     return vim.fn.getcwd()
                -- end,
            },
        })

        -- basic telescope configuration
        -- local conf = require("telescope.config").values
        -- local function toggle_telescope(harpoon_files)
        --     local file_paths = {}
        --     for _, item in ipairs(harpoon_files.items) do
        --         table.insert(file_paths, item.value)
        --     end
        --
        --     require("telescope.pickers")
        --         .new({}, {
        --             prompt_title = "Harpoon",
        --             finder = require("telescope.finders").new_table({
        --                 results = file_paths,
        --             }),
        --             previewer = conf.file_previewer({}),
        --             sorter = conf.generic_sorter({}),
        --         })
        --         :find()
        -- end
    end,
}
