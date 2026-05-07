return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    branch = "main",
    config = function()
        require("nvim-treesitter").install({ "all" })

        --- Activate treesitter syntax highlighting for all supported filetypes
        vim.api.nvim_create_autocmd("FileType", {
            callback = function(args)
                local lang = vim.treesitter.language.get_lang(args.match)
                if lang and vim.treesitter.language.add(lang) then
                    vim.treesitter.start()
                    -- vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" --- TODO check if this works out or needs to be deactivated
                end
            end,
        })
    end,
}
