local M = {}

M.setup = function()
	logging = false
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
					stdin = true,
				}
			end,
		},
	}
end

-- Format on save
vim.api.nvim_exec(
	[[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.py,*.cpp,*.hpp,*.h FormatWrite
augroup END
]],
	true
)

return M
