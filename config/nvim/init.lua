local vim = vim

vim.o.syntax = "on"

vim.opt.signcolumn = "yes:2"
vim.g.noshowmode = true

-- Cursorline and line numbers
vim.o.cursorline = true
vim.o.number = true
vim.o.relativenumber = true

-- Set spacebar to be map leader
vim.g.mapleader = " "
vim.g.maplocalleader = ";"

vim.o.completeopt = "menu,menuone,noselect"

vim.o.scrolloff = 10

-- Search options
vim.o.ignorecase = true
vim.o.smartcase = true

-- vim.o.mouse = "a"

vim.o.updatetime = 400

-- Autosave buffer when navigating away from it
vim.o.autowriteall = true

-- Spelling locale
vim.o.spelllang = "en_au"

-- Highlight on yank
vim.cmd("au TextYankPost * lua vim.highlight.on_yank {}")

-- Hide mode at bottom, since this is already shown by the statusline
vim.o.showmode = false

-- Use Y to yank to end of line
vim.keymap.set("n", "Y", "y$")

-- Turn off hlsearch with two ESCs
vim.keymap.set("n", "<esc><esc>", "<cmd>nohls<CR>")

-- Fold settings
-- vim.o.foldmethod = "expr"
-- vim.o.foldexp = [[nvim_treesitter#foldexpr()]]
-- vim.o.fillchars = [[fold:\\ ]]
-- vim.o.foldtext = [[getline(v:foldstart).'...'.trim(getline(v:foldend))]]

vim.opt.termguicolors = true

-- Other configuration
require("plugins")
