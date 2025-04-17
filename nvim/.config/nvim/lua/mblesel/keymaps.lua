local M = {}

--- movement remaps ---
--
-- Press 'H', 'L' to jump to start/end of a line (first/last char)
vim.keymap.set("n", "L", "$", { desc = "Jump start of line" })
vim.keymap.set("n", "H", "^", { desc = "Jump end of line" })

-- vim.keymap.set("i", "<C-L>", "<right>", { desc = "Cursor right" })
-- vim.keymap.set("i", "<C-H>", "<left>") -- This causes problems with S-BS functionality
-- vim.keymap.set("i", "<C-J>", "<C-o>gj", { desc = "Cursor down" })
-- vim.keymap.set("i", "<C-K>", "<C-o>gk", { desc = "Cursor up" })

vim.keymap.set("n", "<leader>oo", "o<ESC>k", { desc = "Add Empty Line Below" })
vim.keymap.set("n", "<leader>OO", "O<ESC>j", { desc = "Add Empty Line Above" })

-- remaps for german keyboard layout
vim.keymap.set("n", "ä", "@", { desc = "Execute Macro" })
vim.keymap.set({ "n", "v", "o", "x" }, "ö", ";", { desc = "Repeat Last Movement" })
vim.keymap.set({ "n", "v", "o", "x" }, "Ü", "{")
vim.keymap.set({ "n", "v", "o", "x" }, "*", "}")

local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
-- vim way: ; goes to the direction you were moving.
vim.keymap.set({ "n", "x", "o" }, "ö", ts_repeat_move.repeat_last_move)
vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

--- vim functions ---
--
-- Clear search highlighting
vim.keymap.set("n", "<leader>q", ":nohlsearch<CR>", { desc = "Clear search" })

-- clipboard copy/paste
vim.keymap.set("v", "<leader>y", '"+y', { desc = "copy to clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "paste from clipboard" })

-- Move selected lines in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move lines up" })

-- Press gx to open the link under the cursor
vim.keymap.set(
    "n",
    "gx",
    ":silent execute '!$BROWSER ' . shellescape(expand('<cfile>'), 1)<CR>",
    { desc = "Open Link" }
)

require("mblesel.markdown_follow_links")
vim.keymap.set("n", "gm", follow_link, { desc = "Markdown Open Link" })

-- Macros

-- Terminal
vim.keymap.set("n", "<leader>T", ":terminal<CR>", { desc = "Terminal Open" })
vim.keymap.set("t", "<ESC>", "<C-Bslash><C-n>", { desc = "Terminal Exit Insert Mode" })
vim.keymap.set("n", "<C-T>", ":FloatermToggle --cwd=<root><CR>", { desc = "Terminal Float" })

-- ChatGPT
vim.keymap.set("n", "<C-A>", ":ChatGPT<CR>", { desc = "ChatGPT Toggle" })

-- quickfix
-- Additional keybinds in trouble.lua
vim.keymap.set("n", "<leader>cc", ":Trouble qflist toggle<CR>", { desc = "Quickfix close list" })
-- vim.keymap.set("n", "<leader>co", ":copen<CR>", { desc = "Quickfix open list" })
-- vim.keymap.set("n", "<leader>cw", ":cw<CR>", { desc = "Quickfix open if not empty" })
-- vim.keymap.set("n", "<leader>cc", Toggle_qf, { desc = "Quickfix close list" })
-- vim.keymap.set("n", "<leader>cn", ":cn<CR>", { desc = "Quickfix next" })
-- vim.keymap.set("n", "<leader>cp", ":cp<CR>", { desc = "Quickfix previous" })
-- vim.keymap.set("n", "<M-n>", ":cn<CR>", { desc = "Quickfix next" })
-- vim.keymap.set("n", "<M-p>", ":cp<CR>", { desc = "Quickfix previous" })
-- vim.keymap.set("n", "<leader>cf", ":cfirst<CR>", { desc = "Quickfix first" })
-- vim.keymap.set("n", "<leader>cl", ":clast<CR>", { desc = "Quickfix last" })


--- spellchecking
vim.keymap.set("n", "<leader>mst", ":setlocal spell!<cr>", { desc = "Spelling Toggle" })
-- Show spelling suggestions / spell suggestions
vim.keymap.set("n", "<leader>mss", function()
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("z=", true, false, true), "m", true)
end, { desc = "Spelling Suggestions" })

-- Add word under the cursor as a good word
vim.keymap.set("n", "<leader>msg", function()
    vim.cmd("normal! zg")
end, { desc = "Spelling Add Word" })

-- Undo zw, remove the word from the entry in 'spellfile'.
vim.keymap.set("n", "<leader>msu", function()
    vim.cmd("normal! zug")
end, { desc = "Spelling Remove Word" })

-- Repeat the replacement done by |z=| for all matches with the replaced word
-- in the current window.
vim.keymap.set("n", "<leader>msr", function()
    -- vim.cmd(":spellr")
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":spellr\n", true, false, true), "m", true)
end, { desc = "Spelling Repeat" })

vim.keymap.set("n", "<leader>msf", "]s", { desc = "Spelling Next" })
vim.keymap.set("n", "<leader>msb", "[s", { desc = "Spelling Previous" })

-- ocaml
-- vim.keymap.set("n", "<leader>rr", OpenMlRepl, {})
-- vim.keymap.set("n", "<leader>ri", GetMlId, {})

--- buffers and splits ---

-- Swap between last two buffers
vim.keymap.set("n", "<leader>^", "<C-^>", { desc = "Buffer Tab" })

-- Buffer stuff
vim.keymap.set("n", "<leader>t", ":tabe<CR>", { desc = "Tab New" })
-- vim.keymap.set("n", "<leader>h", ":bprevious<CR>", { desc = "Buffer Previous " })
-- vim.keymap.set("n", "<leader>l", ":bnext<CR>", { desc = "Buffer Next" })

-- Split stuff
vim.keymap.set("n", "<C-H>", "<C-W><C-H>", { noremap = true, desc = "Split go left" })
vim.keymap.set("n", "<C-J>", "<C-W><C-J>", { noremap = true, desc = "Split go down" })
vim.keymap.set("n", "<C-K>", "<C-W><C-K>", { noremap = true, desc = "Split go up" })
vim.keymap.set("n", "<C-L>", "<C-W><C-L>", { noremap = true, desc = "Split go right" })
vim.keymap.set("n", "<leader>v", ":vsplit<CR>", { noremap = true, desc = "Split Vertical" })
vim.keymap.set("n", "<leader>s", ":split<CR>", { noremap = true, desc = "Split Horizontal" })

-- Resize split windows to be equal size
vim.keymap.set("n", "<leader>=", "<C-w>=", { desc = "Splits Equal Size" })

-- Press leader rw to rotate open windows
vim.keymap.set("n", "<leader>rw", ":RotateWindows<cr>", { desc = "[R]otate [W]indows" })

-- Map MaximizerToggle (szw/vim-maximizer) to leader-m
vim.keymap.set("n", "<leader>MM", ":MaximizerToggle<cr>", { desc = "Split Maximize" })

-- delete current file
local function confirm_and_delete_buffer()
    local confirm = vim.fn.confirm("Delete buffer and file?", "&Yes\n&No", 2)

    if confirm == 1 then
        os.remove(vim.fn.expand("%"))
        -- vim.api.nvim_buf_delete(0, { force = true })
    end
end
vim.keymap.set("n", "<leader>RM", confirm_and_delete_buffer, { desc = "File Delete" })

--- Plugins ---

-- Open Spectre for global find/replace
vim.keymap.set("n", "<leader>S", function()
    require("spectre").toggle()
end, { desc = "Spectre Open" })

-- telescope binds
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-F>", ":Telescope find_files hidden=true<CR>", { desc = "Telescope Find Files" })
vim.keymap.set("n", "<C-G>", ":Telescope live_grep<CR>", { desc = "Telescope Live Grep" })
vim.keymap.set("n", "<C-B>", builtin.buffers, { desc = "Telescope Buffers" })
vim.keymap.set("n", "<C-P>", ":SessionManager load_session<CR>", { desc = "Session Load" })
vim.keymap.set("n", "<C-Y>", ":Telescope neoclip<CR>", { desc = "Telescope Neoclip" })
vim.keymap.set("n", "<C-Q>", ":Telescope macroscope<CR>", { desc = "Telescope Neoclip Macros" })
vim.keymap.set("n", "<C-W>", ":Telescope telescope-tabs list_tabs<CR>", { desc = "Telescope List Tabs" })
vim.keymap.set("n", "<C-M>", require('telescope').extensions.markit.marks_list_buf, { desc = "Telescope List Marks" })
vim.keymap.set("n", "<C-R>", builtin.lsp_document_symbols, { desc = "Telescope List Symbols" })
vim.keymap.set("n", "<leader>mte", ":Telescope emoji<CR>", { desc = "Telescope Emoji" })
vim.keymap.set("n", "<leader>mtg", ":Telescope glyph<CR>", { desc = "Telescope Glyph" })
vim.keymap.set("n", "<leader>mtl", ":Telescope software-licenses find<CR>", { desc = "Telescope Software-Licenses" })
vim.keymap.set("n", "?", builtin.keymaps, { desc = "Telescope Keymaps" })

-- harpoon
local harpoon = require("harpoon")

vim.keymap.set("n", "<leader>ha", function()
    harpoon:list():add()
end)
vim.keymap.set("n", "<leader>hh", function()
    harpoon.ui:toggle_quick_menu(harpoon:list())
end)

vim.keymap.set("n", "<leader>jj", function()
    harpoon:list():select(1)
end)
vim.keymap.set("n", "<leader>kk", function()
    harpoon:list():select(2)
end)
vim.keymap.set("n", "<leader>ll", function()
    harpoon:list():select(3)
end)

-- ufo
-- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
-- vim.keymap.set('n', '<leader>+', require('ufo').openAllFolds, {desc = "Folds Open All"})
-- vim.keymap.set('n', '<leader>-', require('ufo').closeAllFolds, {desc = "Folds Close All"})
-- vim.keymap.set("n", "-", "<cmd>foldclose<CR>", { desc = "Fold Close" })
-- vim.keymap.set("n", "+", "<cmd>foldopen<CR>", { desc = "Fold Open" })

-- vim.keymap.set('n', '<leader>K', function()
--     local winid = require('ufo').peekFoldedLinesUnderCursor()
--     if not winid then
--         vim.lsp.buf.hover()
--     end
-- end, {desc = "Fold Peek"})
--
-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undotree" })

-- vim-fugitive
-- vim.keymap.set("n", "<leader>g", vim.cmd.Git)

-- neotree
vim.keymap.set("n", "<C-N>", ":Neotree filesystem reveal left toggle<CR>", { desc = "Neotree" })

-- oil.nvim
vim.keymap.set("n", "<leader>n", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- outline.nvim
vim.keymap.set("n", "<leader>o", ":Outline<CR>", { desc = "Outline Toggle" })

-- Transparent
vim.keymap.set("n", "<leader>b", ":TransparentToggle<CR>")

-- Cellular Automaton
vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "CellularAutomaton" })

vim.keymap.set("n", "<leader>ä", ":Screenkey toggle<CR>", { desc = "Screenkey Toggle" })

--- LSP ---
--
M.map_lsp_keybinds = function(opts)
    vim.keymap.set("n", "grn", vim.lsp.buf.rename, { buffer = opts, desc = "LSP Rename" })
    vim.keymap.set({ "n", "v" }, "gra", vim.lsp.buf.code_action, { buffer = opts, desc = "LSP Code Action" })
    vim.keymap.set({ "n", "v" }, "<leader>F", function()
        require("conform").format({
            lsp_fallback = true,
            async = false,
            timeout_ms = 1000,
        })
    end, { desc = "Format File or Selection" })

    -- Telescope LSP keybinds --
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = opts, desc = "LSP Goto Definition" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = opts, desc = "LSP Goto Declaration" })
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = opts, desc = "LSP Goto Type Definition" })

    vim.keymap.set(
        "n",
        "grr",
        require("telescope.builtin").lsp_references,
        { buffer = opts, desc = "LSP List References" }
    )
    vim.keymap.set(
        "n",
        "gri",
        require("telescope.builtin").lsp_implementations,
        { buffer = opts, desc = "LSP List Implementations" }
    )

    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = opts, desc = "LSP Hover" })
    vim.keymap.set("i", "<C-s>", vim.lsp.buf.signature_help, { buffer = opts, desc = "LSP Signature Help" })
    vim.keymap.set("n", "<C-s>", vim.lsp.buf.signature_help, { buffer = opts, desc = "LSP Signature Help" })

    vim.keymap.set("n", "do", vim.diagnostic.open_float, { buffer = opts, desc = "Diagnostic Open Float" })
    vim.keymap.set("n", "<leader>dn", function() vim.diagnostic.jump( { count = 1 }) end, { buffer = opts, desc = "Diagnostic Next" })
    vim.keymap.set("n", "<leader>dp", function() vim.diagnostic.jump( { count = -1 }) end, { buffer = opts, desc = "Diagnostic Previous" })
    vim.keymap.set(
        "n",
        "<leader>dl",
        require("telescope.builtin").diagnostics,
        { buffer = opts, desc = "Diagnostics List" }
    )
    vim.keymap.set("n", "<leader>dt", ":ToggleDiagnostics<CR>", { desc = "Diagnostics Toggle" })

    vim.keymap.set("n", "<leader>drs", ":LspRestart<CR>", { desc = "Restart LSP" })

    vim.keymap.set("n", "<F5>", ":ClangdSwitchSourceHeader<CR>", { desc = "Switch Header/Source File" })
end

--- autocomplete binds are in cmp plugin file ---

--- zk ---
-- This overrides the global `<leader>zn` mapping to create the note in the same directory as the current buffer.
vim.keymap.set(
    "n",
    "<leader>znn",
    "<Cmd>ZkNew { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>",
    { desc = "ZK New Note in Notebook" }
)
-- Create a new note in the same directory as the current buffer, using the current selection for title.
vim.keymap.set(
    "v",
    "<leader>znt",
    ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>",
    { desc = "ZK New Note With Selected Title" }
)
-- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
vim.keymap.set(
    "v",
    "<leader>znc",
    ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>",
    { desc = "ZK New Note With Selected Content" }
)

vim.keymap.set("n", "<leader>zf", "<Cmd>ZkNotes<CR>", { desc = "ZK Find Notes" })
vim.keymap.set("n", "<leader>zt", "<Cmd>ZkTags<CR>", { desc = "ZK Browse Tags" })
vim.keymap.set(
    "n",
    "<leader>zg",
    ":lua require('telescope.builtin').live_grep{search_dirs={vim.fn.expand('%:p:h')}}<CR>",
    { desc = "ZK Grep Notes" }
)

vim.keymap.set("n", "<leader>zll", "<Cmd>ZkLinks<CR>", { desc = "ZK Links List" })
vim.keymap.set("n", "<leader>zli", "<Cmd>ZkInsertLink<CR>", { desc = "ZK Link Insert" })
-- Open main note
vim.keymap.set("n", "<leader>zz", '<Cmd>ZkNotes { tags = { "ROOT" } }<CR>', { desc = "ZK Open Root Note" })

--- Markdown ---
require("mblesel.markdown_funcs")

vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>", { desc = "Markdown Preview" })
vim.keymap.set("n", "<leader>P", ":PasteImage<CR>", { desc = "Markdown Paste Image" })

-- In visual mode, surround the selected text with markdown link syntax
vim.keymap.set("v", "<leader>mlL", MdConvertToLink, { desc = "Markdown Convert to Link" })
-- In visual mode, surround the selected url with markdown link syntax
vim.keymap.set("n", "<leader>mll", MdConvertToLink2, { desc = "Markdown Convert to Link" })

vim.keymap.set("n", "<leader>mc", MdCheckbox, { desc = "Markdown Tick Checkbox" })
vim.keymap.set("n", "<leader>mC", MdCheckbox2, { desc = "Markdown Tick Checkbox" })

-- Increase/Decrease all headings above H1 in the file
vim.keymap.set("n", "<leader>mhI", MdIncreaseHeadings, { desc = "Markdown Increase Headings" })
vim.keymap.set("n", "<leader>mhD", MdDecreaseHeadings, { desc = "Markdown Decrease Headings" })

-- Keymap for folding markdown headings of different levels
-- vim.keymap.set("n", "<leader>mfj", MdFoldLevel2, { desc = "Markdown Fold Level 2+ Headings" })
-- vim.keymap.set("n", "<leader>mfk", MdFoldLevel3, { desc = "Markdown Fold Level 3+ Headings" })
-- vim.keymap.set("n", "<leader>mfl", MdFoldLevel4, { desc = "Markdown Fold Level 4+ Headings" })
-- vim.keymap.set("n", "<leader>mfö", MdFoldLevel5, { desc = "Markdown Fold Level 5+ Headings" })
-- vim.keymap.set("n", "<leader>mfu", function()
--     -- Reloads the file to reflect the changes
--     vim.cmd("edit!")
--     vim.cmd("normal! zR") -- Unfold all headings
-- end, { desc = "Markdown Unfold 2+ Headings" })

vim.keymap.set("v", "<leader>mb", function()
    -- Get the selected text range
    local start_row, start_col = unpack(vim.fn.getpos("'<"), 2, 3)
    local end_row, end_col = unpack(vim.fn.getpos("'>"), 2, 3)
    -- Get the selected lines
    local lines = vim.api.nvim_buf_get_lines(0, start_row - 1, end_row, false)
    local selected_text = table.concat(lines, "\n"):sub(start_col, #lines == 1 and end_col or -1)
    if selected_text:match("^%*%*.*%*%*$") then
        vim.notify("Text already bold", vim.log.levels.INFO)
    else
        vim.cmd("normal 2sa*")
    end
end, { desc = "Markdown Bold Selection" })

-- Search UP/DOWN for a markdown header
-- Make sure to follow proper markdown convention, and you have a single H1 Heading at the top
vim.keymap.set({ "n", "v" }, "üm", MdPrevHeading, { desc = "Markdown Previous Header" })
vim.keymap.set({ "n", "v" }, "+m", MdNextHeading, { desc = "Markdown Next Header" })

-- vim.keymap.set("n", "<leader>mc", ":set concealcursor= <CR>", { desc = "Markdown Concealcursor 0" })
-- vim.keymap.set("n", "<leader>mC", ":set conceallevel=0<CR>", { desc = "Markdown Concealcursor 0" })

-------------------------------------------------------------------------------
--                           Folding section
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
  return "="
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

-- HACK: Fold markdown headings in Neovim with a keymap
-- https://youtu.be/EYczZLNEnIY
--
-- Keymap for folding markdown headings of level 1 or above
vim.keymap.set("n", "zj", function()
  -- "Update" saves only if the buffer has been modified since the last save
  vim.cmd("silent update")
  -- vim.keymap.set("n", "<leader>mfj", function()
  -- Reloads the file to refresh folds, otheriise you have to re-open neovim
  vim.cmd("edit!")
  -- Unfold everything first or I had issues
  vim.cmd("normal! zR")
  fold_markdown_headings({ 6, 5, 4, 3, 2, 1 })
  vim.cmd("normal! zz") -- center the cursor line on screen
end, { desc = "[P]Fold all headings level 1 or above" })

-- HACK: Fold markdown headings in Neovim with a keymap
-- https://youtu.be/EYczZLNEnIY
--
-- Keymap for folding markdown headings of level 2 or above
-- I know, it reads like "madafaka" but "k" for me means "2"
vim.keymap.set("n", "zk", function()
  -- "Update" saves only if the buffer has been modified since the last save
  vim.cmd("silent update")
  -- vim.keymap.set("n", "<leader>mfk", function()
  -- Reloads the file to refresh folds, otherwise you have to re-open neovim
  vim.cmd("edit!")
  -- Unfold everything first or I had issues
  vim.cmd("normal! zR")
  fold_markdown_headings({ 6, 5, 4, 3, 2 })
  vim.cmd("normal! zz") -- center the cursor line on screen
end, { desc = "[P]Fold all headings level 2 or above" })

-- HACK: Fold markdown headings in Neovim with a keymap
-- https://youtu.be/EYczZLNEnIY
--
-- Keymap for folding markdown headings of level 3 or above
vim.keymap.set("n", "zl", function()
  -- "Update" saves only if the buffer has been modified since the last save
  vim.cmd("silent update")
  -- vim.keymap.set("n", "<leader>mfl", function()
  -- Reloads the file to refresh folds, otherwise you have to re-open neovim
  vim.cmd("edit!")
  -- Unfold everything first or I had issues
  vim.cmd("normal! zR")
  fold_markdown_headings({ 6, 5, 4, 3 })
  vim.cmd("normal! zz") -- center the cursor line on screen
end, { desc = "[P]Fold all headings level 3 or above" })

-- HACK: Fold markdown headings in Neovim with a keymap
-- https://youtu.be/EYczZLNEnIY
--
-- Use <CR> to fold when in normal mode
-- To see help about folds use `:help fold`
vim.keymap.set("n", "<CR>", function()
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
end, { desc = "[P]Toggle fold" })

-- HACK: Fold markdown headings in Neovim with a keymap
-- https://youtu.be/EYczZLNEnIY
--
-- Keymap for unfolding markdown headings of level 2 or above
-- Changed all the markdown folding and unfolding keymaps from <leader>mfj to
-- zj, zk, zl, z; and zu respectively lamw25wmal
vim.keymap.set("n", "zu", function()
  -- "Update" saves only if the buffer has been modified since the last save
  vim.cmd("silent update")
  -- vim.keymap.set("n", "<leader>mfu", function()
  -- Reloads the file to reflect the changes
  vim.cmd("edit!")
  vim.cmd("normal! zR") -- Unfold all headings
  vim.cmd("normal! zz") -- center the cursor line on screen
end, { desc = "[P]Unfold all headings level 2 or above" })

-- HACK: Fold markdown headings in Neovim with a keymap
-- https://youtu.be/EYczZLNEnIY
--
-- gk jummps to the markdown heading above and then folds it
-- zi by default toggles folding, but I don't need it lamw25wmal
vim.keymap.set("n", "zi", function()
  -- "Update" saves only if the buffer has been modified since the last save
  vim.cmd("silent update")
  -- Difference between normal and normal!
  -- - `normal` executes the command and respects any mappings that might be defined.
  -- - `normal!` executes the command in a "raw" mode, ignoring any mappings.
  vim.cmd("normal gk")
  -- This is to fold the line under the cursor
  vim.cmd("normal! za")
  vim.cmd("normal! zz") -- center the cursor line on screen
end, { desc = "[P]Fold the heading cursor currently on" })

-------------------------------------------------------------------------------
--                         End Folding section
-------------------------------------------------------------------------------




--- marks ---
-- Marks keep coming back even after deleting them, this deletes them all
-- This deletes all marks in the current buffer, including lowercase, uppercase, and numbered marks
-- Fix should be applied on April 2024
-- https://github.com/chentoast/marks.nvim/issues/13
vim.keymap.set("n", "<leader>mD", function()
    -- Delete all marks in the current buffer
    vim.cmd("delmarks!")
    print("All marks deleted.")
end, { desc = "[P]Delete all marks" })

--- generic settings that don't need to be remembered ---

-- Center buffer while navigating
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "G", "Gzz")
vim.keymap.set("n", "gg", "ggzz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "%", "%zz")
vim.keymap.set("n", "#", "#zz")
-- vim.keymap.set("n", "j", "jzz")
-- vim.keymap.set("n", "k", "jzz")

-- keep cursor postiton when joining lines
vim.keymap.set("n", "J", "mzJ`z")
-- disable annoying binds
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "q:", "<nop>")

-- Visual --

-- Press 'H', 'L' to jump to start/end of a line (first/last char)
vim.keymap.set("v", "L", "$<left>", { desc = "Jump Line Start" })
vim.keymap.set("v", "H", "^", { desc = "Jump Line End" })

-- Reselect the last visual selection
vim.keymap.set("x", "<<", function()
    vim.keymap.set("x", "<leader>p", '"_dP')
    -- Move selected text up/down in visual mode
    vim.cmd("normal! <<")
    vim.cmd("normal! gv")
end, { desc = "TODO" })

vim.keymap.set("x", ">>", function()
    vim.cmd("normal! >>")
    vim.cmd("normal! gv")
end, { desc = "TODO" })

return M
