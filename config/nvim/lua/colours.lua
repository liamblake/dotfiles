vim.opt.termguicolors = true

vim.g.tokyonight_style = "storm"
vim.g.tokyonight_italic_keywords = false
vim.g.tokyonight_lualine_bold = true
vim.g.tokyonight_brightness = 0.1
vim.cmd("colorscheme tokyonight")

-- This gets the colours defined by tokyonight
-- https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/colors.lua#L14
local tc = require("tokyonight.colors").setup()
-- local onc = require("onenord.colors").load()

local hl_set_fg = function(group, colour)
	vim.cmd("highlight " .. group .. " guifg=" .. colour)
end

-- TeX syntax colouring
-- https://github.com/lervag/vimtex/blob/master/doc/vimtex.txt#L4208
-- TODO: Customise this with the correct colours
hl_set_fg("texMathZone", tc.magenta)
hl_set_fg("texCmdItem", tc.orange)
hl_set_fg("texOpt", tc.orange)

-- Highlight the current line number
-- TODO: This does not work
vim.cmd("highlight CursorLineNR gui=bold")

-- Trouble customisation
vim.cmd("highlight TroubleNormal guibg=#000000")
