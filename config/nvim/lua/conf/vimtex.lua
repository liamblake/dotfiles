local M = {}

diagnostics_from_qf = function()
	-- Find the LSP client corresponding to texlab
	-- TODO: Surely a better way to do this
	texlab_id = 0
	for i, v in pairs(vim.lsp.get_active_clients()) do
		if v["name"] == "texlab" then
			texlab_id = i
			break
		end
	end

	-- Get the corresponding namespace
	local texlab_namespace = vim.lsp.diagnostic.get_namespace(texlab_id)

	-- Grab the quickfix list and use these to set diagnostics
	vim.diagnostic.set(texlab_namespace, vim.fn.bufnr("%"), vim.diagnostic.fromqflist(vim.fn.getqflist()))
end

M.setup = function()
	vim.g.vimtex_compiler_latexmk = { build_dir = "build", continuous = 1, options = { "-xelatex", "-shell-escape" } }
	-- Use SumatraPDF on Windows for previewing
	if vim.fn.has("win64") then
		vim.g.vimtex_view_general_viewer = "SumatraPDF"
		vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
	end
	-- Trouble will be opened automatically instead
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
					au user VimtexEventCompileSuccess :lua diagnostics_from_qf()
					au user VimtexEventCompileFailed :lua diagnostics_from_qf()
			]])
end

return M
