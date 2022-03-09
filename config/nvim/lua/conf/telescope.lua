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
			git_files = {theme = "dropdown", previewer = false},
			buffers = {
				sort_lastused = true,
				theme = "dropdown",
				previewer = false,
			},
		},
	})
end

M.project_files = function()
	local builtin = require("telescope.builtin")
	local opts = { prompt_title = "project files", hidden = true, theme = "dropdown", previewer = false}
	local ok = pcall(builtin.git_files, opts)
	if not ok then
		builtin.find_files(opts)
	end
end

M.matching_files = function()
	-- Find files with the same name, but a different filetype.
	-- e.g. convienient for jumping between the header class.hpp and the implementation class.cpp.
	require("telescope.builtin").find_files({})
end

M.search_dotfiles = function()
	require("telescope.builtin").git_files({ prompt_title = "dotfiles", cwd = "~/dev/dotfiles", hidden = true })
end

M.search_notes = function()
	require("telescope.builtin").git_files({ prompt_title = "notes", cwd = "~/Dropbox/notes", hidden = false })
end
return M
