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
