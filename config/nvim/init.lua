local vim = vim

vim.o.syntax = 'on'
vim.o.number = true

-- Set spacebar to be map leader
vim.g.mapleader = ' '

require('plugins')
require('lsp')
require('keymappings')


-- Set colourscheme
vim.opt.termguicolors = true
vim.cmd("colorscheme dracula")

require('colours')
