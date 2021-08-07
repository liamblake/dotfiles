local colors = {
	bg = "#282A36",
	fg = "#F8F8F2",
	selection = "#44475A",
	comment = "#6272A4",
	red = "#FF5555",
	orange = "#FFB86C",
	yellow = "#F1FA8C",
	green = "#50fa7b",
	purple = "#BD93F9",
	cyan = "#8BE9FD",
	pink = "#FF79C6",
	bright_red = "#FF6E6E",
	bright_green = "#69FF94",
	bright_yellow = "#FFFFA5",
	bright_blue = "#D6ACFF",
	bright_magenta = "#FF92DF",
	bright_cyan = "#A4FFFF",
	bright_white = "#FFFFFF",
	menu = "#21222C",
	visual = "#3E4452",
	gutter_fg = "#4B5263",
	nontext = "#3B4048",
	white = "#ABB2BF",
	black = "#191A21",
}

local vs_colours = {
	white = "#ffffff",
	grey = "#90A4AE",
	blue = "#8be9fd",
	green = "#35c772",
	bg = "#21222c",
}

local highlight = function(group, fg, bg, attr, sp)
	fg = fg and "guifg=" .. fg or "guifg=NONE"
	bg = bg and "guibg=" .. bg or "guibg=NONE"
	attr = attr and "gui=" .. attr or "gui=NONE"
	sp = sp and "guisp=" .. sp or ""

	vim.api.nvim_command("highlight " .. group .. " " .. fg .. " " .. bg .. " " .. attr .. " " .. sp)
end

-- Set colourscheme
vim.opt.termguicolors = true

vim.g.dracula_italic = 0
vim.g.dracula_colorterm = 0
vim.cmd("colorscheme dracula")
vim.api.nvim_command("highlight Normal ctermbg=None")

-- NvimTree
highlight("NvimTreeRootFolder", vs_colours.white, colors.bg, "bold", nil)
highlight("NvimTreeNormal ", vs_colours.white, vs_colours.bg, nil, nil)
highlight("NvimTreeGitDirty", vs_colours.blue, nil, nil, nil)
highlight("NvimTreeGitNew", vs_colours.green, nil, nil, nil)
highlight("NvimTreeImageFile", colors.pink, nil, nil, nil)
highlight("NvimTreeFolderIcon", vs_colours.grey, nil, nil, nil)
highlight("NvimTreeIndentMarker", colors.nontext, nil, nil, nil)
highlight("NvimTreeEmptyFolderName", colors.comment, nil, nil, nil)
highlight("NvimTreeFolderName", vs_colours.white, nil, nil, nil)
highlight("NvimTreeSpecialFile", colors.pink, nil, "underline", nil)
