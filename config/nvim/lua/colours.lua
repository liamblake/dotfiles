vim.cmd("colorscheme catppuccino")

-- Custom plugin colours
-- Telescope
vim.cmd("hi! link TelescopePromptBorder DraculaGreen")
vim.cmd("hi! link TelescopeResultsBorder DraculaCyan")
vim.cmd("hi! link TelescopePreviewBorder DraculaPink")

-- NvimTree
vim.cmd("hi! link NvimTreeRootFolder DraculaPurpleBold")
vim.cmd("hi! link NvimTreeNormal DraculaFg")
vim.cmd("hi! link NvimTreeGitDirty DraculaCyan")
vim.cmd("hi! link NvimTreeGitNew DraculaGreen")
vim.cmd("hi! link NvimTreeStaged DraculaYellow")
vim.cmd("hi! link NvimTreeFolderName DraculaFg")
vim.cmd("hi! link NvimTreeEmptyFolderName DraculaComment")
vim.cmd("hi! link NvimTreeOpenedFolderName DraculaFgBold")
vim.cmd("hi! link NvimTreeExecFile DraculaFg")
