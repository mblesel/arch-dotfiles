---
--- General settings
---

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.background = "dark"
vim.o.updatetime = 50
vim.opt.termguicolors = true

vim.cmd("set rtp^='home/michael/.opam/default/share/ocp-indent/vim/'")

vim.cmd("set spell spelllang=en_us,de_de")
vim.cmd("set spell!")

vim.cmd("let g:markdown_folding = 1")

-- auto-reload files when modified externally
-- https://unix.stackexchange.com/a/383044
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
    command = "if mode() != 'c' | checktime | endif",
    pattern = { "*" },
})

-- temp file settings
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- keep hidden buffers
vim.o.hidden = true
vim.o.history = 1000

-- relative line numbers
vim.o.nu = true
vim.o.rnu = true

-- Start scrolling when we're getting close to margins
vim.o.scrolloff = 10
vim.o.sidescrolloff = 15
vim.o.sidescroll = 1

-- We want to replace tabs with spaces and have 4 space width indentation
vim.o.smarttab = true
vim.o.autoindent = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4
vim.opt.breakindent = true

-- Searching
vim.o.incsearch = true
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Better splitting
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Enable the sign column to prevent the screen from jumping
vim.opt.signcolumn = "yes"

-- Diagnostic Settings
-- vim.diagnostic.config({ virtual_text = true })
vim.diagnostic.config({ virtual_text = { current_line = true } })

-- Set fold settings
vim.opt.foldmethod = "manual"
-- These options were reccommended by nvim-ufo
-- See: https://github.com/kevinhwang91/nvim-ufo#minimal-configuration
vim.opt.foldcolumn = "0"
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99
