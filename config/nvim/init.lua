local vim = vim

vim.o.syntax = "on"

vim.o.number = true
vim.opt.signcolumn = "yes:1"
vim.g.noshowmode = true

-- Set spacebar to be map leader
vim.g.mapleader = " "
vim.g.maplocalleader = ";"

vim.o.completeopt = "menu,menuone,noselect,preview"

vim.o.relativenumber = true
vim.o.scrolloff = 5

-- Search options
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.mouse = "a"

vim.o.updatetime = 400

-- Autosave buffer when navigating away from it
vim.o.autowriteall = true

-- Spelling locale
vim.o.spelllang = "en_au"

-- Highlight on yank
vim.cmd("au TextYankPost * lua vim.highlight.on_yank {}")

require("plugins")
require("keymappings")
require("colours")
