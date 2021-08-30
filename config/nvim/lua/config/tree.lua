local M = {}
local view = require("nvim-tree.view")

M.config = function() end

M.open = function()
	require("bufferline.state").set_offset(41, "Explorer")
	require("nvim-tree").find_file(true)
end

M.close = function()
	require("bufferline.state").set_offset(0)
	require("nvim-tree").close()
end

M.toggle = function()
	if view.win_open() then
		M.close()
	else
		if vim.g.nvim_tree_follow == 1 then
			M.open()
		end
		if not view.win_open() then
			lib.open()
		end
	end
end

return M
