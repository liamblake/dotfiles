local M = {}

local trouble = require("trouble.providers.telescope")
local previewers = require("telescope.previewers")
local Job = require("plenary.job")

-- No preview of binary files
-- From https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#dont-preview-binaries
local maker_no_bin = function(filepath, bufnr, opts)
	filepath = vim.fn.expand(filepath)
	Job
		:new({
			command = "file",
			args = { "--mime-type", "-b", filepath },
			on_exit = function(j)
				local mime_type = vim.split(j:result()[1], "/")[1]
				if mime_type == "text" then
					previewers.buffer_previewer_maker(filepath, bufnr, opts)
				else
					-- maybe we want to write something to the buffer here
					vim.schedule(function()
						vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "Binary file, no preview available." })
					end)
				end
			end,
		})
		:sync()
end

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
			buffer_previewer_maker = maker_no_bin,
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
	local opts = {} -- define here if you want to define something
	local ok = pcall(require("telescope.builtin").git_files, opts)
	if not ok then
		require("telescope.builtin").find_files(opts)
	end
end

M.search_dotfiles = function()
	require("telescope.builtin").git_files({ prompt_tile = "dotfiles", cwd = "~/dev/dotfiles", hidden = true })
end
return M
