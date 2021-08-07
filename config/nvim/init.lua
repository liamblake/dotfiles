local vim = vim

vim.o.syntax = "on"
vim.o.number = true

-- Set spacebar to be map leader
vim.g.mapleader = " "

require("plugins")
require("lsp")
require("keymappings")

require("colours")
