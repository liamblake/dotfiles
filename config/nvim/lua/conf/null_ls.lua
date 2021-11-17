local M = {}

M.setup = function()
	local null_ls = require("null-ls")
	local nl_utils = require("null-ls.helpers")
	local formatting = require("null-ls").builtins.formatting
	local linting = require("null-ls").builtins.diagnostics

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

	null_ls.config({
		sources = {
			-- Formatters
			formatting.black,
			formatting.clang_format,
			formatting.isort,
			formatting.prettierd,
			formatting.styler,
			formatting.stylua,
			formatting.rustfmt,
			formatting.shfmt,
			-- TODO: Fix this, perhaps something is missing in the above table
			-- indentlatex,
			-- Diagnostics/linting
			-- linting.flake8,
			linting.chktex.with({ from_stderr = true }),
		},
	})
end

return M
