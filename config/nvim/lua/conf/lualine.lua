local M = {}

M.config = function()
	require("lualine").setup({
		options = {
			theme = "onenord",
			section_separators = { left = "", right = "" },
			component_separators = { left = "|", right = "|" },
		},
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
		extensions = { "nvim-tree", "fugitive" },
		--{ sections = { lualine_b = {
		--	function()
		--		return "Table of Contents"
		--	end,
		--} }, filetypes= } },
	})
end

return M
