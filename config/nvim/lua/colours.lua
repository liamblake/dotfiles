vim.opt.termguicolors = true

vim.g.tokyonight_style = "storm"
vim.g.tokyonight_italic_keywords = false
vim.g.tokyonight_lualine_bold = true
vim.g.tokyonight_brightness = 0.1
vim.cmd("colorscheme tokyonight")

-- This gets the colours defined by tokyonight
-- https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/colors.lua#L14
local tc = require("tokyonight.colors").setup()
