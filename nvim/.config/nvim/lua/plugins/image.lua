return {
    "3rd/image.nvim",
    ft = { "markdown", "vimwiki" },
    config = function()
        require("image").setup({
            backend = "kitty", -- or "ueberzug" or "sixel"
            processor = "magick_cli", -- or "magick_rock"
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = true,
                    download_remote_images = true,
                    only_render_image_at_cursor = true,
                    only_render_image_at_cursor_mode = "inline",
                    floating_windows = false,
                    filetypes = { "markdown", "vimwiki" },
                },
                neorg = {
                    enabled = false,
                    filetypes = { "norg" },
                },
                typst = {
                    enabled = false,
                    filetypes = { "typst" },
                },
                html = {
                    enabled = false,
                },
                css = {
                    enabled = false,
                },
            },
            max_width = nil,
            max_height = nil,
            max_width_window_percentage = nil,
            max_height_window_percentage = 50,
            scale_factor = 1.0,
            window_overlap_clear_enabled = false,
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "snacks_notif", "scrollview", "scrollview_sign" },
            editor_only_render_when_focused = false,
            tmux_show_only_in_active_window = false,
            hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
            kitty_method = "normal",
        })
    end,

    init = function()
        -- vim.api.nvim_create_autocmd("InsertEnter", {
        --     callback = function()
        --         if require("image").is_enabled() then
        --             require("image").disable()
        --         end
        --     end,
        -- })
        --
        -- vim.api.nvim_create_autocmd("InsertLeave", {
        --     callback = function()
        --         if not require("image").is_enabled() then
        --             require("image").enable()
        --         end
        --     end,
        -- })

        vim.api.nvim_create_user_command("ImageToggle", function()
            if require("image").is_enabled() then
                require("image").disable()
            else
                require("image").enable()
            end
        end, {})

        vim.keymap.set("n", "<leader>mit", "<cmd>ImageToggle<CR>", { desc = "Toggle image preview" })
    end,
}
