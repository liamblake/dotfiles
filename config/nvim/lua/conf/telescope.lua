local M = {}

M.config = function()
	require("telescope").setup({
		defaults = {
			mappings = {
				i = {
					["<esc>"] = require("telescope.actions").close,
				},
			},
			-- Ignore binary files, e.g. PDFs
			file_ignore_patterns = { "%.pdf" },
		},
		pickers = {
			find_files = { theme = "dropdown", previewer = false },
			git_files = { theme = "dropdown", previewer = false },
			buffers = {
				sort_lastused = true,
				theme = "dropdown",
				previewer = false,
			},
		},
	})

	require("telescope").load_extension("file_browser")

	-- Keymappings
	require("which-key").add({
		{ "<leader>f", group = "telescope" },
		{ "<leader>ff", ':lua require"conf.telescope".project_files()<CR>', desc = "find project file" },
		{
			"<leader>fa",
			':lua require"telescope.builtin".find_files({ prompt_title = "all files", hidden = true})<CR>',
			desc = "find file",
		},
		{
			"<leader>fp",
			':lua require"telescope.builtin".buffers({ prompt_title = "open buffers" })<CR>',
			desc = "find buffer",
		},
		{ "<leader>fr", ':lua require"telescope.builtin".lsp_references()<CR>', desc = "find symbol reference" },
		{ "<leader>ft", ':lua require"telescope.builtin".live_grep()<CR>', desc = "live grep" },
		{ "<leader>fr", ':lua require"telescope.builtin".treesitter()<CR>', desc = "find treesitter symbol" },
		{ "<leader>fl", ':lua require"telescope.builtin".lsp_workspace_symbols()<CR>', desc = "find workspace symbol" },
		{ "<leader>fd", ':lua require"conf.telescope".search_dotfiles()<CR>', desc = "find dotfile" },
		{
			"<leader>fb",
			':lua require"telescope".extensions.file_browser.file_browser( {hidden = true} )<CR>',
			desc = "file browser",
		},
	})
end

M.project_files = function()
	-- Originally from
	-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#falling-back-to-find_files-if-git_files-cant-find-a-git-directory
	-- However, this doesn't work anymore. Instead using the workaround
	-- https://github.com/nvim-telescope/telescope.nvim/issues/2183

	local builtin = require("telescope.builtin")
	local opts = {
		prompt_title = "project files",
		hidden = true,
		-- show_untracked = true,
		theme = "dropdown",
		previewer = false,
		file_ignore_patterns = { "venv/.*" },
		recurse_submodules = true,
	}

	-- local ok = pcall(builtin.git_files, opts)
	-- if not ok then
	-- 	builtin.find_files(opts)
	-- end

	local in_git_repo = vim.fn.systemlist("git rev-parse --is-inside-work-tree")[1] == "true"
	if in_git_repo then
		require("telescope.builtin").git_files(opts)
	else
		require("telescope.builtin").find_files(opts)
	end
end

M.search_dotfiles = function()
	local cwd = "~/dev/dotfiles"
	-- Windows has a different filesystem :(
	-- TODO: Breaks the finder, even on other operating systems
	-- if vim.fn.has("win64") then
	-- 	cwd = "D:\\dev\\dotfiles"
	-- end

	require("telescope.builtin").git_files({
		prompt_title = "dotfiles",
		cwd = cwd,
		hidden = true,
		show_untracked = true,
	})
end

return M
