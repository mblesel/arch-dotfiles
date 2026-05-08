function MdConvertToLink()
    -- delete selected text
    vim.cmd("normal d")
    -- Insert the following in insert mode
    vim.cmd("startinsert")
    vim.api.nvim_put({ "[]()" }, "c", true, true)
    -- Move to the left, paste, and then move to the right
    vim.cmd("normal F[pf)")
    -- vim.cmd("normal 2hpF[l")
    -- Leave me in insert mode to start typing
    vim.cmd("startinsert")
end

function MdConvertToLink2()
    -- delete selected text
    vim.cmd("normal viWd")
    -- Insert the following in insert mode
    vim.cmd("startinsert")
    vim.api.nvim_put({ "[]()" }, "c", true, true)
    -- Move to the left, paste, and then move to the right
    vim.cmd("normal F(pF]")
    -- vim.cmd("norma<leader>l 2hpF[l")
    -- Leave me in insert mode to start typing
    vim.cmd("startinsert")
end

function MdCheckbox()
    vim.cmd("normal ^f[lx")
    vim.cmd("startinsert")
    vim.api.nvim_put({ "x" }, "c", false, true)
    vim.cmd("stopinsert")
end

function MdCheckbox2()
    vim.cmd("normal ^f[lx")
    vim.cmd("startinsert")
    vim.api.nvim_put({ " " }, "c", false, true)
    vim.cmd("stopinsert")
end

-------------------------------------------------------------------------------
--                           Folding section
--                  Credits: https://linkarzu.com/
-------------------------------------------------------------------------------

-- Checks each line to see if it matches a markdown heading (#, ##, etc.):
-- It’s called implicitly by Neovim’s folding engine by vim.opt_local.foldexpr
function _G.markdown_foldexpr()
    local lnum = vim.v.lnum
    local line = vim.fn.getline(lnum)
    local heading = line:match("^(#+)%s")
    if heading then
        local level = #heading
        if level == 1 then
            -- Special handling for H1
            if lnum == 1 then
                return ">1"
            else
                local frontmatter_end = vim.b.frontmatter_end
                if frontmatter_end and (lnum == frontmatter_end + 1) then
                    return ">1"
                end
            end
        elseif level >= 2 and level <= 6 then
            -- Regular handling for H2-H6
            return ">" .. level
        end
    end
    -- own hack to have empty lines between closed h2 folds and dash-lines
    -- can't figure out how this could be accomplished for other foldlevels as well
    local line2 = vim.fn.getline(lnum + 1)
    local empty = line:match("^$")
    local dashes = line2:match("^---")
    local heading2 = line2:match("^(#+)%s")
    if empty and heading2 and #heading2 == 2 then
            return ">0"
    elseif empty and dashes then
        return ">0"
    else
        return "="
    end
end

local function set_markdown_folding()
    vim.opt_local.foldmethod = "expr"
    vim.opt_local.foldexpr = "v:lua.markdown_foldexpr()"
    vim.opt_local.foldlevel = 99

    -- Detect frontmatter closing line
    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local found_first = false
    local frontmatter_end = nil
    for i, line in ipairs(lines) do
        if line == "---" then
            if not found_first then
                found_first = true
            else
                frontmatter_end = i
                break
            end
        end
    end
    vim.b.frontmatter_end = frontmatter_end
end

-- Use autocommand to apply only to markdown files
vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = set_markdown_folding,
})

-- Function to fold all headings of a specific level
local function fold_headings_of_level(level)
    -- Move to the top of the file without adding to jumplist
    vim.cmd("keepjumps normal! gg")
    -- Get the total number of lines
    local total_lines = vim.fn.line("$")
    for line = 1, total_lines do
        -- Get the content of the current line
        local line_content = vim.fn.getline(line)
        -- "^" -> Ensures the match is at the start of the line
        -- string.rep("#", level) -> Creates a string with 'level' number of "#" characters
        -- "%s" -> Matches any whitespace character after the "#" characters
        -- So this will match `## `, `### `, `#### ` for example, which are markdown headings
        if line_content:match("^" .. string.rep("#", level) .. "%s") then
            -- Move the cursor to the current line without adding to jumplist
            vim.cmd(string.format("keepjumps call cursor(%d, 1)", line))
            -- Check if the current line has a fold level > 0
            local current_foldlevel = vim.fn.foldlevel(line)
            if current_foldlevel > 0 then
                -- Fold the heading if it matches the level
                if vim.fn.foldclosed(line) == -1 then
                    vim.cmd("normal! za")
                end
                -- else
                --   vim.notify("No fold at line " .. line, vim.log.levels.WARN)
            end
        end
    end
end

local function fold_markdown_headings(levels)
    -- I save the view to know where to jump back after folding
    local saved_view = vim.fn.winsaveview()
    for _, level in ipairs(levels) do
        fold_headings_of_level(level)
    end
    vim.cmd("nohlsearch")
    -- Restore the view to jump to where I was
    vim.fn.winrestview(saved_view)
end

-- Keymap for folding markdown headings of level 1 or above
function MdFoldlevel1()
    -- "Update" saves only if the buffer has been modified since the last save
    vim.cmd("silent update")
    -- vim.keymap.set("n", "<leader>mfj", function()
    -- Reloads the file to refresh folds, otheriise you have to re-open neovim
    vim.cmd("edit!")
    -- Unfold everything first or I had issues
    vim.cmd("normal! zR")
    fold_markdown_headings({ 6, 5, 4, 3, 2, 1 })
    vim.cmd("normal! zz") -- center the cursor line on screen
end

-- Keymap for folding markdown headings of level 2 or above
function MdFoldlevel2()
    -- "Update" saves only if the buffer has been modified since the last save
    vim.cmd("silent update")
    -- vim.keymap.set("n", "<leader>mfk", function()
    -- Reloads the file to refresh folds, otherwise you have to re-open neovim
    vim.cmd("edit!")
    -- Unfold everything first or I had issues
    vim.cmd("normal! zR")
    fold_markdown_headings({ 6, 5, 4, 3, 2 })
    vim.cmd("normal! zz") -- center the cursor line on screen
end

-- Keymap for folding markdown headings of level 3 or above
function MdFoldlevel3()
    -- "Update" saves only if the buffer has been modified since the last save
    vim.cmd("silent update")
    -- vim.keymap.set("n", "<leader>mfl", function()
    -- Reloads the file to refresh folds, otherwise you have to re-open neovim
    vim.cmd("edit!")
    -- Unfold everything first or I had issues
    vim.cmd("normal! zR")
    fold_markdown_headings({ 6, 5, 4, 3 })
    vim.cmd("normal! zz") -- center the cursor line on screen
end

-- Keymap for folding markdown headings of level 4 or above
function MdFoldlevel4()
    -- "Update" saves only if the buffer has been modified since the last save
    vim.cmd("silent update")
    -- vim.keymap.set("n", "<leader>mf;", function()
    -- Reloads the file to refresh folds, otherwise you have to re-open neovim
    vim.cmd("edit!")
    -- Unfold everything first or I had issues
    vim.cmd("normal! zR")
    fold_markdown_headings({ 6, 5, 4 })
    vim.cmd("normal! zz") -- center the cursor line on screen
end

-- Keymap for folding markdown headings of level 5 or above
function MdFoldlevel5()
    -- "Update" saves only if the buffer has been modified since the last save
    vim.cmd("silent update")
    -- vim.keymap.set("n", "<leader>mf;", function()
    -- Reloads the file to refresh folds, otherwise you have to re-open neovim
    vim.cmd("edit!")
    -- Unfold everything first or I had issues
    vim.cmd("normal! zR")
    fold_markdown_headings({ 6, 5 })
    vim.cmd("normal! zz") -- center the cursor line on screen
end

-- Fold markdown headings in Neovim with a keymap
function MarkdownToggleFold()
    -- Get the current line number
    local line = vim.fn.line(".")
    -- Get the fold level of the current line
    local foldlevel = vim.fn.foldlevel(line)
    if foldlevel == 0 then
        vim.notify("No fold found", vim.log.levels.INFO)
    else
        vim.cmd("normal! za")
        vim.cmd("normal! zz") -- center the cursor line on screen
    end
end

-- Keymap for unfolding markdown headings of level 2 or above
function MdUnfoldAll()
    -- "Update" saves only if the buffer has been modified since the last save
    vim.cmd("silent update")
    -- vim.keymap.set("n", "<leader>mfu", function()
    -- Reloads the file to reflect the changes
    vim.cmd("edit!")
    vim.cmd("normal! zR") -- Unfold all headings
    vim.cmd("normal! zz") -- center the cursor line on screen
end

-- zi by default toggles folding, but I don't need it lamw25wmal
function MarkdownToggleParentFold()
    -- "Update" saves only if the buffer has been modified since the last save
    vim.cmd("silent update")
    -- `?` - Start a search backwards from the current cursor position.
    -- `^` - Match the beginning of a line.
    -- `##` - Match 2 ## symbols
    -- `\\+` - Match one or more occurrences of prev element (#)
    -- `\\s` - Match exactly one whitespace character following the hashes
    -- `.*` - Match any characters (except newline) following the space
    -- `$` - Match extends to end of line
    vim.cmd("silent! ?^##\\+\\s.*$")
    -- Clear the search highlight
    vim.cmd("nohlsearch")
    -- This is to fold the line under the cursor
    vim.cmd("normal! za")
    vim.cmd("normal! zz") -- center the cursor line on screen
end

-------------------------------------------------------------------------------
--                         End Folding section
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
--                         Start ToC Section
--                  Credits: https://linkarzu.com/
--                  TODO Currently not working for me
-------------------------------------------------------------------------------
-- Generate/update a Markdown TOC
-- To generate the TOC I use the markdown-toc plugin
-- https://github.com/jonschlinkert/markdown-toc
-- Function to update the Markdown TOC with customizable headings
function Update_markdown_toc(heading2, heading3)
    local path = vim.fn.expand("%") -- Expands the current file name to a full path
    local bufnr = 0 -- The current buffer number, 0 references the current active buffer
    -- Save the current view
    -- If I don't do this, my folds are lost when I run this keymap
    vim.cmd("mkview")
    -- Retrieves all lines from the current buffer
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local toc_exists = false -- Flag to check if TOC marker exists
    local frontmatter_end = 0 -- To store the end line number of frontmatter
    -- Check for frontmatter and TOC marker
    for i, line in ipairs(lines) do
        if i == 1 and line:match("^---$") then
            -- Frontmatter start detected, now find the end
            for j = i + 1, #lines do
                if lines[j]:match("^---$") then
                    frontmatter_end = j
                    break
                end
            end
        end
        -- Checks for the TOC marker
        if line:match("^%s*<!%-%-%s*toc%s*%-%->%s*$") then
            toc_exists = true
            break
        end
    end
    -- Inserts H2 and H3 headings and <!-- toc --> at the appropriate position
    if not toc_exists then
        local insertion_line = 1 -- Default insertion point after first line
        if frontmatter_end > 0 then
            -- Find H1 after frontmatter
            for i = frontmatter_end + 1, #lines do
                if lines[i]:match("^#%s+") then
                    insertion_line = i + 1
                    break
                end
            end
            -- else
            -- -- Find H1 from the beginning
            -- for i, line in ipairs(lines) do
            --   if line:match("^#%s+") then
            --     insertion_line = i + 1
            --     break
            --   end
            -- end
        end
        -- Insert the specified headings and <!-- toc --> without blank lines
        -- Insert the TOC inside a H2 and H3 heading right below the main H1 at the top lamw25wmal
        vim.api.nvim_buf_set_lines(bufnr, insertion_line, insertion_line, false, { heading2, heading3, "<!-- toc -->" })
    end
    -- Silently save the file, in case TOC is being created for the first time
    vim.cmd("silent write")
    -- Silently run markdown-toc to update the TOC without displaying command output
    -- vim.fn.system("markdown-toc -i " .. path)
    -- I want my bulletpoints to be created only as "-" so passing that option as
    -- an argument according to the docs
    -- https://github.com/jonschlinkert/markdown-toc?tab=readme-ov-file#optionsbullets
    vim.fn.system('markdown-toc --bullets "*" -i ' .. path)
    vim.cmd("edit!") -- Reloads the file to reflect the changes made by markdown-toc
    vim.cmd("silent write") -- Silently save the file
    vim.notify("TOC updated and file saved", vim.log.levels.INFO)
    -- -- In case a cleanup is needed, leaving this old code here as a reference
    -- -- I used this code before I implemented the frontmatter check
    -- -- Moves the cursor to the top of the file
    -- vim.api.nvim_win_set_cursor(bufnr, { 1, 0 })
    -- -- Deletes leading blank lines from the top of the file
    -- while true do
    --   -- Retrieves the first line of the buffer
    --   local line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]
    --   -- Checks if the line is empty
    --   if line == "" then
    --     -- Deletes the line if it's empty
    --     vim.api.nvim_buf_set_lines(bufnr, 0, 1, false, {})
    --   else
    --     -- Breaks the loop if the line is not empty, indicating content or TOC marker
    --     break
    --   end
    -- end
    -- Restore the saved view (including folds)
    vim.cmd("loadview")
end

-- -- Keymap for English TOC
-- vim.keymap.set("n", "<leader>mtt", function()
--   Update_markdown_toc("## Contents", "### Table of contents")
-- end, { desc = "Markdown Insert/update Markdown TOC (English)" })
-------------------------------------------------------------------------------
--                         End ToC Section
-------------------------------------------------------------------------------
