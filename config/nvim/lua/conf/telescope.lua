
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
			find_files = {theme = "dropdown", previewer = false},
			git_files = {theme = "dropdown", previewer = false},
			buffers = {
				sort_lastused = true,
				theme = "dropdown",
				previewer = false,
			},
		},
	})

	require("telescope").load_extension("file_browser")

	-- Keymappings
	KeyMapper("n", "<leader>ff", ':lua require"conf.telescope".project_files()<CR>')
	KeyMapper("n", "<leader>fa", ':lua require"telescope.builtin".find_files({ prompt_title = "all files", no_ignore = true, hidden = true})<CR>')
	KeyMapper("n", "<leader>fr", ':lua require"telescope.builtin".lsp_references()<CR>')
	KeyMapper("n", "<leader>ft", ':lua require"telescope.builtin".live_grep()<CR>')
	KeyMapper("n", "<leader>fs", ':lua require"telescope.builtin".treesitter()<CR>')
	KeyMapper("n", "<leader>fws", ':lua require"telescope.builtin".lsp_workspace_symbols()<CR>')
	KeyMapper("n", "<leader>fd", ':lua require"conf.telescope".search_dotfiles()<CR>')
	KeyMapper("n", "<leader>fn", ':lua require"conf.telescope".search_notes()<CR>')
	KeyMapper("n", "<leader>fb", ':lua require"telescope".extensions.file_browser.file_browser()<CR>')
	KeyMapper("n", "<leader>fgs", ':lua require"telescope.builtin".git_stash()<CR>')
	KeyMapper("n", "<leader>fgb", ':lua require"telescope.builtin".git_branches()<CR>')
end

M.project_files = function()
	local builtin = require("telescope.builtin")
	local opts = { prompt_title = "project files", hidden = true, theme = "dropdown", previewer = false, file_ignore_patterns = { "venv/.*", "venv%_linux/.*" }}
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
