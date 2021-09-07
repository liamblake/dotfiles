local M = {}

M.setup = function()
	require("lualine").setup({
		options = { theme = "tokyonight", section_separators = { "", "" }, component_separators = { "|", "|" } },
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff" },
			lualine_c = { { "filename", path = 1 } },
			lualine_x = {
				{
					"diagnostics",
					sources = { "nvim_lsp" },
					-- displays diagnostics from defined severity
					sections = { "error", "warn", "info", "hint" },
				},
			},
			lualine_y = { "filetype" },
			lualine_z = { "location" },
		},
		extensions = { "nvim-tree" },
	})
end

return M
