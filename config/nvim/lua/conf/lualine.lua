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
			theme = "onenord",
			section_separators = { left = "", right = "" },
			component_separators = { left = "|", right = "|" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff" },
			lualine_c = { { "filename", path = 1, separator = "" }, {M.compile_status} },
			lualine_x = {
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					-- displays diagnostics from defined severity
					sections = { "error", "warn", "info", "hint" },
				},
			},
			lualine_y = { "filetype" },
			lualine_z = { "location" },
		},
		extensions = { "nvim-tree", "fugitive" },
	})
end

return M
