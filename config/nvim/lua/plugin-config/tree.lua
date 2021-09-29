local M = {}

M.setup = function()
	require("nvim-tree").setup({
		update_cwd = true,
		disable_netrw = false,
		hijack_netrw = false,
		view = { width = 40 },
	})
	vim.g.nvim_tree_ignore = { ".git", "$null" }
	vim.g.nvim_tree_gitignore = 1
	vim.g.nvim_tree_quit_on_open = 1
	vim.g.nvim_tree_indent_markers = 1
	vim.g.nvim_tree_hide_dotfiles = 0
	vim.g.nvim_tree_git_hl = 1
	vim.g.nvim_tree_highlight_opened_files = 1
	vim.g.nvim_tree_root_folder_modifier = ":~"
	vim.g.nvim_tree_add_trailing = 1
	vim.g.nvim_tree_group_empty = 1
	vim.g.nvim_tree_disable_window_picker = 1
	vim.g.nvim_tree_icon_padding = " "
	vim.g.nvim_tree_show_icons = {
		git = 0,
		folders = 1,
		files = 1,
		folder_arrows = 1,
	}
end

return M
