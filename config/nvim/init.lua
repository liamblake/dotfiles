require('helpers')

local vim = vim

vim.o.syntax = 'on'
vim.o.number = true

-- Set spacebar to be map leader
vim.g.mapleader = ' '

require('plugins')
require('lsp')

-- Set colourscheme
vim.opt.termguicolors = true
require("bufferline").setup{}

vim.cmd("colorscheme dracula")