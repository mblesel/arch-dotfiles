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
    vim.api.nvim_put({ "x"}, "c", false, true)
    vim.cmd("stopinsert")
end

function MdCheckbox2()
    vim.cmd("normal ^f[lx")
    vim.cmd("startinsert")
    vim.api.nvim_put({ " "}, "c", false, true)
    vim.cmd("stopinsert")
end

function MdIncreaseHeadings()
    -- Save the current cursor position
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    -- I'm using [[ ]] to escape the special characters in a command
    vim.cmd([[:g/\(^$\n\s*#\+\s.*\n^$\)/ .+1 s/^#\+\s/#&/]])
    -- Restore the cursor position
    vim.api.nvim_win_set_cursor(0, cursor_pos)
    -- Clear search highlight
    vim.cmd("nohlsearch")
end

function MdDecreaseHeadings()
    -- Save the current cursor position
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    -- I'm using [[ ]] to escape the special characters in a command
    vim.cmd([[:g/^\s*#\{2,}\s/ s/^#\(#\+\s.*\)/\1/]])
    -- Restore the cursor position
    vim.api.nvim_win_set_cursor(0, cursor_pos)
    -- Clear search highlight
    vim.cmd("nohlsearch")
end

-- To see help about folds use `:help fold`
vim.keymap.set("n", "<leader><CR>", function()
    -- Get the current line number
    local line = vim.fn.line(".")
    -- Get the fold level of the current line
    local foldlevel = vim.fn.foldlevel(line)
    if foldlevel == 0 then
        vim.notify("No fold found", vim.log.levels.INFO)
    else
        vim.cmd("normal! za")
    end
end, { desc = "[P]Toggle fold" })

local function set_foldmethod_expr()
    -- These are lazyvim.org defaults but setting them just in case a file
    -- doesn't have them set
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    vim.opt.foldtext = ""
    vim.opt.foldlevel = 99
end

-- Function to fold all headings of a specific level
local function fold_headings_of_level(level)
    -- Move to the top of the file
    vim.cmd("normal! gg")
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
            -- Move the cursor to the current line
            vim.fn.cursor(line, 1)
            -- Fold the heading if it matches the level
            if vim.fn.foldclosed(line) == -1 then
                vim.cmd("normal! za")
            end
        end
    end
end

local function fold_markdown_headings(levels)
    set_foldmethod_expr()
    -- I save the view to know where to jump back after folding
    local saved_view = vim.fn.winsaveview()
    for _, level in ipairs(levels) do
        fold_headings_of_level(level)
    end
    vim.cmd("nohlsearch")
    -- Restore the view to jump to where I was
    vim.fn.winrestview(saved_view)
end

function MdFoldLevel2()
    -- Reloads the file to refresh folds, otherwise you have to re-open neovim
    vim.cmd("edit!")
    -- Unfold everything first or I had issues
    vim.cmd("normal! zR")
    fold_markdown_headings({ 6, 5, 4, 3, 2 })
end

function MdFoldLevel3()
    -- Reloads the file to refresh folds, otherwise you have to re-open neovim
    vim.cmd("edit!")
    -- Unfold everything first or I had issues
    vim.cmd("normal! zR")
    fold_markdown_headings({ 6, 5, 4, 3 })
end

function MdFoldLevel4()
    -- Reloads the file to refresh folds, otherwise you have to re-open neovim
    vim.cmd("edit!")
    -- Unfold everything first or I had issues
    vim.cmd("normal! zR")
    fold_markdown_headings({ 6, 5, 4 })
end

function MdFoldLevel5()
    -- Reloads the file to refresh folds, otherwise you have to re-open neovim
    vim.cmd("edit!")
    -- Unfold everything first or I had issues
    vim.cmd("normal! zR")
    fold_markdown_headings({ 6, 5 })
end

function MdPrevHeading()
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
end

function MdNextHeading()
    -- `/` - Start a search forwards from the current cursor position.
    -- `^` - Match the beginning of a line.
    -- `##` - Match 2 ## symbols
    -- `\\+` - Match one or more occurrences of prev element (#)
    -- `\\s` - Match exactly one whitespace character following the hashes
    -- `.*` - Match any characters (except newline) following the space
    -- `$` - Match extends to end of line
    vim.cmd("silent! /^##\\+\\s.*$")
    -- Clear the search highlight
    vim.cmd("nohlsearch")
end
