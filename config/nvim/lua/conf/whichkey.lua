local M = {}

M.setup = function()
	require("which-key").setup({
		plugins = {
			spelling = {
				enabled = true,
				suggestions = 10,
			},
		presets = {
			operators = false,
			motions = false,
			text_objects = false,
			g = false,
			}
		}
	})
end

return M
