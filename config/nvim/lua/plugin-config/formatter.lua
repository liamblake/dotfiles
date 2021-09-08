local M = {}

M.fmt_prettier = function()
	return { exe = "prettier --write", args = {}, stdin = false }
end

M.fmt_latexindent = function()
	return {
		exe = "latexindent",
		args = {},
		stdin = true,
	}
end

M.setup = function()
	require("formatter").setup({
		logging = false,
		filetype = {
			python = {
				-- black
				function()
					return {
						exe = "black",
						args = {},
						stdin = false,
					}
				end,
				-- isort
				function()
					return {
						exe = "isort",
						args = {},
						stdin = false,
					}
				end,
			},
			cpp = {
				-- clang-format
				function()
					return {
						exe = "clang-format",
						args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
						stdin = true,
						cwd = vim.fn.expand("%:p:h"), -- Run clang-format in cwd of the file.
					}
				end,
			},
			lua = {
				-- stylua
				function()
					return {
						exe = "stylua",
						args = {},
						stdin = false,
					}
				end,
			},
			tex = {
				-- latexindent
				M.fmt_latexindent,
			},
			bib = {
				-- latexindent
				M.fmt_latexindent,
			},
			sty = {
				-- latexindent
				M.fmt_latexindent,
			},
			typescript = {
				-- Prettier
				M.fmt_prettier,
			},
			html = {
				-- Prettier
				M.fmt_prettier,
			},
			css = {
				-- Prettier
				M.fmt_prettier,
			},
		},
	})
end

-- Format on save
vim.api.nvim_exec(
	[[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.py,*.cpp,*.hpp,*.h,*.lua,*.tex,*.bib,*.sty,*.ts FormatWrite
  autocmd BufWritePost *.jl JuliaFormatterFormat
augroup END
]],
	true
)

return M
