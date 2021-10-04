local M = {}

local trouble = require("trouble.providers.telescope")

M.setup = function()
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
			buffers = {
				sort_lastused = true,
				theme = "dropdown",
				previewer = false,
			},
		},
	})
end

M.project_files = function()
	local opts = { hidden = true }
	local ok = pcall(require("telescope.builtin").git_files, opts)
	if not ok then
		require("telescope.builtin").find_files(opts)
	end
end

M.matching_files = function()
	-- Find files with the same name, but a different filetype.
	-- e.g. convienient for jumping between the header class.hpp and the implementation class.cpp.
	require("telescope.builtin").find_files({})
end

M.search_dotfiles = function()
	require("telescope.builtin").git_files({ prompt_tile = "dotfiles", cwd = "~/dev/dotfiles", hidden = true })
end
return M
