local vim = vim

vim.o.syntax = "on"

vim.o.number = true
vim.opt.signcolumn = "yes:1"

-- Set spacebar to be map leader
vim.g.mapleader = " "

vim.o.completeopt = "menuone,noselect,preview"

vim.o.relativenumber = true
vim.o.scrolloff = 5

-- Search options
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.mouse = "a"

vim.o.updatetime = 300

require("plugins")
require("lsp")
require("keymappings")

vim.opt.termguicolors = true

-- Colourscheme
vim.g.dracula_italic = 0
vim.g.dracula_colorterm = 0
vim.cmd("colorscheme dracula")

require("colours")
