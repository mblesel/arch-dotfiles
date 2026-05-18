vim.opt_local.shiftwidth = 2

-- WARNING: AI generated code FIXME: rewrite this myself
-- TODO check if this has an ill effect on non-markdown buffers
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function(ev)
        vim.keymap.set("n", "gd", function()
            local current_uri = vim.uri_from_bufnr(0)
            local current_file = vim.api.nvim_buf_get_name(0)
            local params = vim.lsp.util.make_position_params(0, "utf-8")

            vim.lsp.buf_request_all(0, "textDocument/definition", params, function(responses)
                local locations = {}
                for _, res in pairs(responses) do
                    local result = res.result or {}
                    if result.uri or result.targetUri then
                        result = { result }
                    end
                    for _, loc in ipairs(result) do
                        table.insert(locations, loc)
                    end
                end

                if #locations == 0 then
                    vim.notify("No definition found", vim.log.levels.INFO)
                    return
                end

                -- If any location points inside the current file, keep only those
                local has_current = false
                for _, loc in ipairs(locations) do
                    if (loc.uri or loc.targetUri) == current_uri then
                        has_current = true
                        break
                    end
                end
                if has_current then
                    locations = vim.tbl_filter(function(loc)
                        return (loc.uri or loc.targetUri) == current_uri
                    end, locations)
                end

                if #locations == 1 then
                    vim.lsp.util.show_document(locations[1], "utf-8", { focus = true })
                else
                    -- Fall back to picker for genuine multi-result cases
                    local items = vim.lsp.util.locations_to_items(locations, "utf-8")
                    Snacks.picker.pick({
                        source = "lsp_definitions",
                        items = vim.tbl_map(function(it)
                            return {
                                text = it.text,
                                file = it.filename,
                                pos = { it.lnum, it.col - 1 },
                            }
                        end, items),
                    })
                end
            end)
        end, { buffer = ev.buf, desc = "Goto definition" })
    end,
})

local MdInsertHeadingLink = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local parser = vim.treesitter.get_parser(bufnr, "markdown")
    local root = parser:parse()[1]:root()
    local query = vim.treesitter.query.parse(
        "markdown",
        [[
        (atx_heading
            heading_content: (inline) @title)
    ]]
    )

    local headings = {}
    for _, node in query:iter_captures(root, 0) do
        table.insert(headings, {
            text = vim.treesitter.get_node_text(node, bufnr)
        })
    end
    
    require("snacks").picker({
        title = "Choose Heading",
        items = headings,
        format = function(item)
            return { { item.text }, }
        end,
        confirm = function(picker, item)
            picker:close()
            if not item then return end

            -- Build GitHub-style anchor slug
            local slug = item.text:lower()
                :gsub("[`*_~]", "")
                :gsub("[^%w%s%-]", "")
                :gsub("^%s+", ""):gsub("%s+$", "")
                :gsub("%s+", "-")

            local link = string.format("[%s](#%s)", item.text, slug)
            local row, col = unpack(vim.api.nvim_win_get_cursor(0))
            vim.api.nvim_buf_set_text(0, row-1, col, row-1, col, { link })
            vim.api.nvim_win_set_cursor(0, { row, col + #link })
        end,
    })

end

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function(ev)
        vim.keymap.set("n", "<leader>mlh", MdInsertHeadingLink, { buffer = ev.buf, desc = "Markdown Insert Link to Heading" })
    end,
})
