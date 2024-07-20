local M = {}

M.setup = function()
	-- Compiler options
	vim.g.vimtex_compiler_latexmk = {
		out_dir = "build",
		callback = 1,
		continuous = 1,
		options = { "-bibtex", "-xelatex", "-shell-escape", "-synctex=1" },
	}

	-- PDF viewer depends on OS
	if vim.loop.os_uname().sysname == "Darwin" then
		-- Use Skim on Mac
		vim.g.vimtex_view_method = "skim"
	elseif vim.loop.os_uname().sysname == "Windows_NT" then
		-- Use SumatraPDF on Windows
		vim.g.vimtex_view_general_viewer = "SumatraPDF"
	end

	-- Jump to and highlight current line after compilation
	vim.g.vimtex_view_skim_sync = 1
	vim.g.vimtex_view_skim_reading_var = 1

	-- Table of contents
	vim.g.vimtex_toc_config = {
		show_help = 0,
		fold_enabled = 1,
		indent_levels = 1,
		layer_status = { content = 1, label = 0, todo = 0, include = 0 },
		split_pos = "vert rightbelow",
	}

	-- Enable folding
	vim.g.vimtex_fold_enabled = 0

	-- Do not automatically open quickfix menu on compilation
	vim.g.vimtex_quickfix_mode = 0

	-- Disable indentation. Handled by latexindent.
	vim.g.vimtex_indent_enabled = 0

	-- Disable syntax conceal
	vim.g.vimtex_syntax_conceal_disable = 1

	-- Disable insert mode mappings
	vim.g.vimtex_imaps_enabled = 0

	-- Register keybindings to which-key
	require("which-key").add({
		{ "<localleader>l", group = "VimTeX" },
		{ "<localleader>ll", desc = "toggle compiler" },
		{ "<localleader>lv", desc = "forward search" },
		{ "<localleader>lq", desc = "view log" },
		{ "<localleader>lT", desc = "toggle outline" },
		{ "<localleader>lw", desc = "count words" },
	})
end

return M
