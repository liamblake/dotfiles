vim.opt.termguicolors = true

-- This gets the colours defined by tokyonight
-- https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/colors.lua#L14
local tc = require("tokyonight.colors").setup()

-- TeX syntax colouring. Uses groups defined by VimTeX
vim.api.nvim_set_hl(0, "texMathZone", { fg = tc.magenta })
vim.api.nvim_set_hl(0, "texCmdItem", { fg = tc.orange })
vim.api.nvim_set_hl(0, "texOpt", { fg = tc.orange })
vim.api.nvim_set_hl(0, "texDelim", { fg = tc.fg_dark })
vim.api.nvim_set_hl(0, "texRefArg", { fg = tc.green })
vim.api.nvim_set_hl(0, "texRefArg", { fg = tc.green })
vim.api.nvim_set_hl(0, "texMathDelimZoneLI", { fg = tc.fg_dark })
vim.api.nvim_set_hl(0, "texMathDelimZoneLD", { fg = tc.fg_dark })
-- vim.api.nvim_set_hl(0, "texMathZoneLI", { fg = tc.blue6 })
-- vim.api.nvim_set_hl(0, "texMathZoneLD", { fg = tc.blue6 })
-- vim.api.nvim_set_hl(0, "texMathZoneEnv", { fg = tc.blue6 })
-- vim.api.nvim_set_hl(0, "texMathZoneEnvStarred", { fg = tc.blue6 })
-- vim.api.nvim_set_hl(0, "texCmdMath", { fg = tc.blue6 })
-- vim.api.nvim_set_hl(0, "texMathDelim", { fg = tc.blue6 })
-- vim.api.nvim_set_hl(0, "texMathDelimMod", { fg = tc.blue6 })
-- vim.api.nvim_set_hl(0, "texMathOper", { fg = tc.blue6 })
-- vim.api.nvim_set_hl(0, "texMathSuperSub", { fg = tc.blue6 })

-- Trouble window
vim.api.nvim_set_hl(0, "TroubleNormal", { bg = tc.bg_dark })
