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
				':lua require"telescope.builtin".find_files({ prompt_title = "all files", no_ignore = true, hidden = true})<CR>',
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
			b = { ':lua require"telescope".extensions.file_browser.file_browser()<CR>', "file browser" },
			g = {
				name = "+git",
				s = { ':lua require"telescope.builtin".git_stash()<CR>', "find git stash" },
				b = { ':lua require"telescope.builtin".git_branches()<CR>', "find git branch" },
			},
		},
	})
end

M.project_files = function()
	local builtin = require("telescope.builtin")
	local opts = {
		prompt_title = "project files",
		hidden = true,
		theme = "dropdown",
		previewer = false,
		file_ignore_patterns = { "venv/.*", "venv%_linux/.*" },
	}
	local ok = pcall(builtin.git_files, opts)
	if not ok then
		builtin.find_files(opts)
	end
end

M.matching_files = function()
	-- Find files with the same name, but a different filetype.
	-- e.g. convienient for jumping between the header class.hpp and the implementation class.cpp.
	-- TODO: Actually implement this.
	require("telescope.builtin").find_files({})
end

M.search_dotfiles = function()
	cwd = "~/dev/dotfiles"
	-- Windows has a different filesystem :(
	-- TODO: Might be able to place a symlink in a clever spot
	if vim.fn.has("win64") then
		cwd = "D:\\dev\\dotfiles"
	end

	require("telescope.builtin").git_files({ prompt_title = "dotfiles", cwd = cwd, hidden = true })
end

M.search_notes = function()
	-- TODO: Windows
	if not vim.fn.has("win64") then
		require("telescope.builtin").git_files({ prompt_title = "notes", cwd = "~/Dropbox/notes", hidden = false })
	end
end

return M
