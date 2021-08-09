local vim = vim

vim.o.syntax = "on"
vim.o.number = true

-- Set spacebar to be map leader
vim.g.mapleader = " "

vim.o.completeopt = "menuone,noselect"

require("plugins")
require("lsp")
require("keymappings")

vim.opt.termguicolors = true

-- Colourscheme
vim.g.dracula_italic = 0
vim.g.dracula_colorterm = 0
vim.cmd("colorscheme dracula")
