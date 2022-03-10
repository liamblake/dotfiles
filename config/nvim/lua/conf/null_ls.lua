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
	null_ls.register(indentlatex)

	null_ls.setup({
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
			-- Diagnostics/linting
			-- linting.flake8,
		},
		-- Format on save
		on_attach = function(client)
			if client.resolved_capabilities.document_formatting then
				vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
			end
		end,
	})
end

return M
