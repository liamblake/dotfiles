local vim = vim

vim.o.syntax = "on"

vim.o.number = true
vim.opt.signcolumn = "yes:1"

-- Set spacebar to be map leader
vim.g.mapleader = " "

vim.o.completeopt = "menuone,noselect,preview"

vim.o.relativenumber = true
vim.o.scrolloff = 5

vim.o.ignorecase = true
vim.o.smartcase = true

require("plugins")
require("lsp")
require("keymappings")

vim.opt.termguicolors = true

-- Colourscheme
vim.g.dracula_italic = 0
vim.g.dracula_colorterm = 0
vim.cmd("colorscheme dracula")

-- Custom plugin colours
vim.cmd("hi! link TelescopePromptBorder DraculaGreen")
vim.cmd("hi! link TelescopeResultsBorder DraculaCyan")
vim.cmd("hi! link TelescopePreviewBorder DraculaPink")

vim.cmd("hi! link NvimTreeRootFolder DraculaPurpleBold")
vim.cmd("hi! link NvimTreeNormal DraculaFg")
vim.cmd("hi! link NvimTreeGitDirty DraculaCyan")
vim.cmd("hi! link NvimTreeGitNew DraculaGreen")
vim.cmd("hi! link NvimTreeStaged DraculaYellow")
vim.cmd("hi! link NvimTreeFolderName DraculaFg")
vim.cmd("hi! link NvimTreeEmptyFolderName DraculaComment")
vim.cmd("hi! link NvimTreeOpenedFolderName DraculaFgBold")
vim.cmd("hi! link NvimTreeExecFile DraculaFg")
