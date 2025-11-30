local M = {}

--- movement remaps ---
--
-- Press 'H', 'L' to jump to start/end of a line (first/last char)
vim.keymap.set("n", "L", "$", { desc = "Jump start of line" })
vim.keymap.set("n", "H", "^", { desc = "Jump end of line" })

-- Don't add search movements to jumplist
vim.keymap.set("n", "N", ":keepjumps normal! Nzz<cr>")
vim.keymap.set("n", "n", ":keepjumps normal! nzz<cr>")

vim.keymap.set("n", "<leader>oo", "o<ESC>k", { desc = "Add Empty Line Below" })
vim.keymap.set("n", "<leader>OO", "O<ESC>j", { desc = "Add Empty Line Above" })

local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
-- vim way: ; goes to the direction you were moving.
vim.keymap.set({ "n", "x", "o" }, ";", function()
    ts_repeat_move.repeat_last_move()
    vim.cmd("normal! zz")
end)
vim.keymap.set({ "n", "x", "o" }, ",", function()
    ts_repeat_move.repeat_last_move_opposite()
    vim.cmd("normal! zz")
end)

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
vim.keymap.set({"n", "t"}, "<C-T>", Snacks.terminal.toggle, { desc = "Snacks Terminal Toggle" })

-- AI
vim.keymap.set({ "n", "v" }, "<leader>al", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ag", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })
-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
vim.cmd([[cab ccc CodeCompanionChat]])

vim.keymap.set("n", "<leader>at", ":SupermavenToggle<CR>", { desc = "SuperMaven Toggle" })

-- quickfix
require("mblesel.qf_toggle")
-- Additional keybinds in trouble.lua
vim.keymap.set("n", "<leader>cc", ":Trouble qflist toggle<CR>", { desc = "Quickfix close list" })
vim.keymap.set("n", "<leader>CC", Toggle_qf, { desc = "Quickfix close list" })

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


--- buffers and splits ---

-- Swap between last two buffers
vim.keymap.set("n", "<leader>`", "<C-^>", { desc = "Buffer Tab" })

-- Buffer stuff
vim.keymap.set("n", "<leader>t", ":tabe<CR>", { desc = "Tab New" })

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

-- Comment and paste current line
vim.keymap.set("n", "ycc", "yygccp", { remap = true, desc = "Comment and paste current line" })

--- Plugins ---

-- Snacks.picker
local Picker = require("snacks").picker
vim.keymap.set("n", "<C-F>", Picker.files, { desc = "Snacks Picker Files" })
vim.keymap.set("n", "<C-G>", Picker.grep, { desc = "Snacks Picker Grep" })
vim.keymap.set("n", "<C-B>", Picker.buffers, { desc = "Snacks Picker Buffers" })
vim.keymap.set("n", "<C-P>", ":SessionManager load_session<CR>", { desc = "Session Load" })
vim.keymap.set("n", "<C-W>", Picker.lsp_symbols, { desc = "Snacks Picker LSP Symbols" })
vim.keymap.set("n", "?", Picker.keymaps, { desc = "Snacks Picker Keymaps" })
vim.keymap.set("n", "<C-/>", Picker.pickers, { desc = "Snacks Picker Pickers" })
vim.keymap.set("n", "<C-C>", Picker.icons, { desc = "Snacks Picker Icons" })
vim.keymap.set("n", "<C-N>", Picker.explorer, { desc = "Snacks Picker Explorer" })
-- yanky plugin is loaded before snacks and will auto register this function
vim.keymap.set("n", "<M-y>", Picker.yanky, { desc = "Snacks Picker Cliphist" }) 


-- harpoon
local harpoon = require("harpoon")

vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<leader>jj", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader>kk", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader>ll", function() harpoon:list():select(3) end)

-- undotree
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undotree" })

-- vim-fugitive
-- vim.keymap.set("n", "<leader>g", vim.cmd.Git)

-- oil.nvim
vim.keymap.set("n", "<leader>n", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Cellular Automaton
vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "CellularAutomaton" })

-- Hardtime
vim.keymap.set("n", "<leader>H", ":Hardtime toggle<CR>", { desc = "Hardtime Toggle" })

--- Treewalker
-- movement
vim.keymap.set({ "n", "v" }, "<M-k>", "<cmd>Treewalker Up<cr>zz", { silent = true })
vim.keymap.set({ "n", "v" }, "<M-j>", "<cmd>Treewalker Down<cr>zz", { silent = true })
vim.keymap.set({ "n", "v" }, "<M-h>", "<cmd>Treewalker Left<cr>zz", { silent = true })
vim.keymap.set({ "n", "v" }, "<M-l>", "<cmd>Treewalker Right<cr>zz", { silent = true })
-- swapping
vim.keymap.set("n", "<M-S-k>", "<cmd>Treewalker SwapUp<cr>", { silent = true })
vim.keymap.set("n", "<M-S-j>", "<cmd>Treewalker SwapDown<cr>", { silent = true })
vim.keymap.set("n", "<M-S-h>", "<cmd>Treewalker SwapLeft<cr>", { silent = true })
vim.keymap.set("n", "<M-S-l>", "<cmd>Treewalker SwapRight<cr>", { silent = true })

--- LSP ---
vim.keymap.set("n", "gn", vim.lsp.buf.rename, { desc = "LSP Rename" })
vim.keymap.set({ "n", "v" }, "gra", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "LSP Hover" })
vim.keymap.set({ "n", "i" }, "<C-s>", vim.lsp.buf.signature_help, { desc = "LSP Signature Help" })

vim.keymap.set("n", "<leader>do", vim.diagnostic.open_float, { desc = "Diagnostic Open Float" })
vim.keymap.set("n", "<leader>dl", Picker.diagnostics, { desc = "Snacks Picker Diagnostics" })
vim.keymap.set("n", "<leader>dt", ":ToggleDiagnostics<CR>", { desc = "Diagnostics Toggle" })
vim.keymap.set("n", "<leader>drs", ":LspRestart<CR>", { desc = "Restart LSP" })

vim.keymap.set("n", "gd", Picker.lsp_definitions, { desc = "LSP Goto Definition" })
vim.keymap.set("n", "gD", Picker.lsp_declarations, { desc = "LSP Goto Declaration" })
vim.keymap.set("n", "gT", Picker.lsp_type_definitions, { desc = "LSP Goto Type Definition" })
vim.keymap.set("n", "gr", Picker.lsp_references, { nowait = true, desc = "Snacks Picker LSP References" })
vim.keymap.set("n", "gi", Picker.lsp_implementations, { desc = "Snacks Picker LSP Implementations" })
vim.keymap.set("n", "gai", Picker.lsp_incoming_calls, { desc = "Snacks Picker LSP Implementations" })
vim.keymap.set("n", "gao", Picker.lsp_outgoing_calls, { desc = "Snacks Picker LSP Implementations" })

vim.keymap.set("n", "<F5>", ":LspClangdSwitchSourceHeader<CR>", { desc = "Switch Header/Source File" })
vim.keymap.set({ "n", "v" }, "<leader>F", function()
    require("conform").format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
    })
end, { desc = "Format File or Selection" })

--- autocomplete binds are in blink plugin file ---

-- LuaSnip snippet jumps
local ls = require("luasnip")
vim.keymap.set({"i", "s"}, "<M-Tab>", function() ls.jump( 1) end, {silent = true})
vim.keymap.set({"i", "s"}, "<M-S-Tab>", function() ls.jump(-1) end, {silent = true})

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

vim.keymap.set("n", "<leader>zz", "<Cmd>ZkNotes<CR>", { desc = "ZK Find Notes" })
vim.keymap.set("n", "<leader>zt", "<Cmd>ZkTags<CR>", { desc = "ZK Browse Tags" })
vim.keymap.set("n", "<leader>zg", function() Picker.grep({ dirs = { vim.fn.expand("%:p:h") } }) end, { desc = "ZK Grep Notes" })

vim.keymap.set("n", "<leader>zll", "<Cmd>ZkLinks<CR>", { desc = "ZK Links List" })
vim.keymap.set("n", "<leader>zli", "<Cmd>ZkInsertLink<CR>", { desc = "ZK Link Insert" })

--- Latex ---

vim.keymap.set("n", "<leader>lc", ":VimtexCompile<CR>", { desc = "Vimtex Compile" })

--- Markdown ---
require("mblesel.markdown_funcs")

vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>", { desc = "Markdown Preview" })
vim.keymap.set("n", "<leader>P", ":PasteImage<CR>", { desc = "Markdown Paste Image" })

-- In visual mode, surround the selected text with markdown link syntax
vim.keymap.set("v", "<leader>mlL", MdConvertToLink, { desc = "Markdown Convert to Link" })
-- In visual mode, surround the selected url with markdown link syntax
vim.keymap.set("n", "<leader>mll", MdConvertToLink2, { desc = "Markdown Convert to Link" })

-- vim.keymap.set("n", "<leader>mc", MdCheckbox, { desc = "Markdown Tick Checkbox" })
-- vim.keymap.set("n", "<leader>mC", MdCheckbox2, { desc = "Markdown Tick Checkbox" })

vim.keymap.set("n", "zj", MdFoldlevel2, { desc = "Markdown Fold Level 2+ Headings" })
vim.keymap.set("n", "zk", MdFoldlevel3, { desc = "Markdown Fold Level 3+ Headings" })
vim.keymap.set("n", "zl", MdFoldlevel4, { desc = "Markdown Fold Level 4+ Headings" })
vim.keymap.set("n", "z;", MdFoldlevel5, { desc = "Markdown Fold Level 5+ Headings" })
vim.keymap.set("n", "zo", MarkdownToggleFold, { desc = "Markdown Toggle Fold" })
vim.keymap.set("n", "zu", MdUnfoldAll, { desc = "Markdown Unfold all headings level 2 or above" })
vim.keymap.set("n", "zi", MarkdownToggleParentFold, { desc = "Markdown Toggle Parent Fold" })

-- Keymap for English TOC
vim.keymap.set("n", "<leader>mtt", ":Mtoc<CR>", { desc = "Markdown Insert/update Markdown TOC" })

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
-- vim.keymap.set({ "n", "v" }, "üm", MdPrevHeading, { desc = "Markdown Previous Header" })
-- vim.keymap.set({ "n", "v" }, "+m", MdNextHeading, { desc = "Markdown Next Header" })

--- Strudel ---
local strudel = require("strudel")

vim.keymap.set("n", "<leader>sl", strudel.launch, { desc = "Launch Strudel" })
vim.keymap.set("n", "<leader>sq", strudel.quit, { desc = "Quit Strudel" })
vim.keymap.set("n", "<leader>st", strudel.toggle, { desc = "Strudel Toggle Play/Stop" })
-- vim.keymap.set("n", "<leader>su", strudel.update, { desc = "Strudel Update" })
-- vim.keymap.set("n", "<leader>ss", strudel.stop, { desc = "Strudel Stop Playback" })
vim.keymap.set("n", "<leader>sb", strudel.set_buffer, { desc = "Strudel set current buffer" })
vim.keymap.set("n", "<leader>sx", strudel.execute, { desc = "Strudel set current buffer and update" })


--- generic settings that don't need to be remembered ---

-- Center buffer while navigating
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "{", "{zz")
vim.keymap.set("n", "}", "}zz")
vim.keymap.set("n", "G", "Gzz")
vim.keymap.set("n", "gg", "ggzz")
vim.keymap.set("n", "<C-i>", "<C-i>zz")
vim.keymap.set("n", "<C-o>", "<C-o>zz")
vim.keymap.set("n", "<M-o>", "g;zz")
vim.keymap.set("n", "<M-i>", "g,zz")
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
