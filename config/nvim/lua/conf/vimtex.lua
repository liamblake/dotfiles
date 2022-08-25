local M = {}

M.setup = function()
	vim.g.vimtex_compiler_latexmk = {
		build_dir = "build",
		continuous = 1,
		options = { "-bibtex", "-xelatex", "-shell-escape" },
	}

	if vim.loop.os_uname().sysname == "Darwin" then
		-- Use Skim on Mac
		vim.g.vimtex_view_method = "skim"
	elseif vim.loop.os_uname().sysname == "Windows_NT" then
		-- Use SumatraPDF on Windows
		vim.g.vimtex_view_method = "SumatraPDF"
	end

	vim.g.vimtex_quickfix_mode = 0
	vim.g.vimtex_toc_config = {
		show_help = 0,
		fold_enabled = 1,
		indent_levels = 1,
		split_pos = "vert rightbelow",
	}
	-- Conceal options
	vim.g.vimtex_syntax_conceal = { accents = true }
	-- Start compilation automatically on open
	-- Clean auxillary files on close
	-- TODO: Do not attempt to compile .sty or .cls files
	vim.cmd([[
				augroup vimtex_events
					au!
					au user VimtexEventInitPost VimtexCompile
					au user VimtexEventQuit VimtexClean
			]])

	require("which-key").register({
		["<localleader>l"] = {
			name = "+VimTeX",
			l = "toggle compiler",
			v = "forward search",
			q = "view log",
			T = "toggle outline",
		},
	})
end

return M
