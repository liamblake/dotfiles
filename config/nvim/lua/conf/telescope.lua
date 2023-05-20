local M = {}

M.config = function()
	local trouble = require("trouble.providers.telescope")

	require("telescope").setup({
		defaults = {
			mappings = {
				i = {
					["<esc>"] = require("telescope.actions").close,
					["<c-t>"] = trouble.open_with_trouble,
				},
				n = { ["<c-t>"] = trouble.open_with_trouble },
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
	require("which-key").register({
		["<leader>f"] = {
			name = "+telescope",
			f = { ':lua require"conf.telescope".project_files()<CR>', "find project file" },
			a = {
				':lua require"telescope.builtin".find_files({ prompt_title = "all files", hidden = true})<CR>',
				"find file",
			},
			r = { ':lua require"telescope.builtin".lsp_references()<CR>', "find symbol reference" },
			t = { ':lua require"telescope.builtin".live_grep()<CR>', "live grep" },
			s = { ':lua require"telescope.builtin".treesitter()<CR>', "find treesitter symbol" },
			l = {
				name = "+lsp",
				s = { ':lua require"telescope.builtin".lsp_workspace_symbols()<CR>', "find workspace symbol" },
			},
			d = { ':lua require"conf.telescope".search_dotfiles()<CR>', "find dotfile" },
			n = { ':lua require"conf.telescope".search_notes()<CR>', "find notes" },
			b = {
				':lua require"telescope".extensions.file_browser.file_browser( {hidden = true} )<CR>',
				"file browser",
			},
			g = {
				name = "+git",
				s = { ':lua require"telescope.builtin".git_stash()<CR>', "find git stash" },
				b = { ':lua require"telescope.builtin".git_branches()<CR>', "find git branch" },
			},
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
