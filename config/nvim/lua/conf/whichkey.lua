local M = {}

M.setup = function()
	require("which-key").setup({ spelling = { enabled = true, suggestions = 10 } })
end

return M
