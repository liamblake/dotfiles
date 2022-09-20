vim.opt.termguicolors = true
vim.cmd("colorscheme tokyonight")

-- This gets the colours defined by tokyonight
-- https://github.com/folke/tokyonight.nvim/blob/main/lua/tokyonight/colors.lua#L14
local tc = require("tokyonight.colors").setup()

-- TeX syntax colouring. Uses groups defined by VimTeX
vim.api.nvim_set_hl(0, "texDelim", { fg = tc.fg })

-- Preamble
vim.api.nvim_set_hl(0, "texCmdPackage", { fg = tc.red })
vim.api.nvim_set_hl(0, "texCmdClass", { fg = tc.red })
vim.api.nvim_set_hl(0, "texCmdTitle", { fg = tc.red })
vim.api.nvim_set_hl(0, "texCmdAuthor", { fg = tc.red })
vim.api.nvim_set_hl(0, "texFileOpt", { fg = tc.fg })
vim.api.nvim_set_hl(0, "texFilesOpt", { fg = tc.fg })
vim.api.nvim_set_hl(0, "texAuthorOpt", { fg = tc.fg })
vim.api.nvim_set_hl(0, "texFileArg", { fg = tc.yellow })
vim.api.nvim_set_hl(0, "texFilesArg", { fg = tc.yellow })
vim.api.nvim_set_hl(0, "texFilesArg", { fg = tc.yellow })
vim.api.nvim_set_hl(0, "texTitleArg", { fg = tc.yellow, bold = true })
vim.api.nvim_set_hl(0, "texAuthorArg", { fg = tc.yellow })

vim.api.nvim_set_hl(0, "texCmdPart", { fg = tc.red })
vim.api.nvim_set_hl(0, "texPartArgTitle", { fg = tc.yellow, bold = true })

vim.api.nvim_set_hl(0, "texCmdBib", { fg = tc.red })

-- Math zone
vim.api.nvim_set_hl(0, "texMathDelimZone", { fg = tc.fg_dark })
vim.api.nvim_set_hl(0, "texMathZone", { fg = tc.fg })
vim.api.nvim_set_hl(0, "texCmd", { fg = tc.blue })
vim.api.nvim_set_hl(0, "texCmdMath", { fg = tc.magenta })

vim.api.nvim_set_hl(0, "texCmdItem", { fg = tc.purple })

-- Trouble window
vim.api.nvim_set_hl(0, "TroubleNormal", { bg = tc.bg_dark })
