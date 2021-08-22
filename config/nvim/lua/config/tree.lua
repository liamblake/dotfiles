-- NvimTree
vim.g.nvim_tree_side = "left"
vim.g.nvim_tree_width = 40
vim.g.nvim_tree_ignore = { ".git", "$null" }
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_auto_open = 0
vim.g.nvim_tree_auto_close = 0
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_hide_dotfiles = 0
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_root_folder_modifier = ":~"
vim.g.nvim_tree_tab_open = 1
vim.g.nvim_tree_auto_resize = 0
vim.g.nvim_tree_disable_netrw = 0
vim.g.nvim_tree_hijack_netrw = 0
vim.g.nvim_tree_add_trailing = 1
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_lsp_diagnostics = 1
vim.g.nvim_tree_disable_window_picker = 1
vim.g.nvim_tree_hijack_cursor = 0
vim.g.nvim_tree_icon_padding = " "
vim.g.nvim_tree_update_cwd = 1
vim.g.nvim_tree_show_icons = {
	git = 0,
	folders = 1,
	files = 1,
	folder_arrows = 1,
}

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
