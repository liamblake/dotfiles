local M = {}

-- Show the vimtex compile status
M.compile_status = function()
	if vim.bo.filetype == "tex" then
		-- Status: not started or stopped
		if vim.b.vimtex["compiler"]["status"] == -1 or vim.b.vimtex["compiler"]["status"] == 0 then
			return ""
		end

		-- Status: running
		if vim.b.vimtex["compiler"]["status"] == 1 then
			return " (⋯)"
			-- Status: compile success
		elseif vim.b.vimtex["compiler"]["status"] == 2 then
			return " ()"
			-- Status: compile failed
		elseif vim.b.vimtex["compiler"]["status"] == 3 then
			return " ()"
		end
	else
		return ""
	end
end

M.config = function()
	require("lualine").setup({
		options = {
			theme = "kanagawa",
			section_separators = { left = "", right = "" },
			component_separators = { left = "|", right = "|" },
			disabled_filetypes = { "toggleterm" },
			globalstatus = false,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				{
					"filename",
					path = 1,
					separator = "",
					symbols = { modified = " ●", readonly = " ", noname = "" },
					color = { bg = "#2A2A37", fg = "#DCD7BA" },
				},
				{ M.compile_status },
			},
			lualine_c = {
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					-- displays diagnostics from defined severity
					sections = { "error", "warn", "info", "hint" },
				},
			},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		extensions = { "fugitive" },
	})
end

return M
