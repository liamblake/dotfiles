local M = {}

local formatting = require("null-ls").builtins.formatting
local linting = require("null-ls").builtins.diagnostics


M.setup = function()
	local null_ls = require("null-ls")
	local nl_utils = require("null-ls.helpers")

local indentlatex = {
	method = require("null-ls.methods").FORMATTING,
	filetypes = { "latex" },
	generator = {},
	generator_opts = {
		command = "latexindent",
		to_stdin = true,
	},
	factory = nl_utils.formatter_factory,
}

	require("null-ls").config({
		sources = {
			-- Formatters
			formatting.black,
			formatting.clang_format,
			formatting.isort,
			formatting.prettier,
			formatting.styler,
			formatting.stylua,
			indentlatex,
			-- Diagnostics/linting
			linting.flake8,
		},
	})
end

-- Format on save
vim.api.nvim_exec(
	[[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.py,*.cpp,*.hpp,*.h,*.lua,*.tex,*.bib,*.sty lua vim.lsp.buf.formatting_sync()
  autocmd BufWritePost *.jl JuliaFormatterFormat
augroup END
]],
	true
)

return M
