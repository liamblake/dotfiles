local M = {}

M.setup = function()
	require("kanagawa").setup({
		theme = "wave",
		keywordStyle = { italic = false },
		statementStyle = { bold = false },
		colors = { theme = { wave = { ui = { bg_gutter = "#1F1F28" } } } },
		overrides = function(colors)
			local theme = colors.theme
			return {
				-- Borderless Telescope
				TelescopeTitle = { fg = theme.ui.fg, bold = true },
				TelescopePromptNormal = { bg = theme.ui.bg_p1 },
				TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
				TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
				TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
				TelescopePreviewNormal = { bg = theme.ui.bg_dim },
				TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
				-- Darker pop-up colors
				Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
				PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
				PmenuSbar = { bg = theme.ui.bg_m1 },
				PmenuThumb = { bg = theme.ui.bg_p2 },
			}
		end,
	})

	vim.cmd("colorscheme kanagawa")

	-- Manual color changes go here
	-- Cursorline
	vim.api.nvim_set_hl(0, "CursorLine", { bg = "#2A2A37" })
	vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#DCD7BA", bg = "#1F1F28", bold = true })
end

return M
