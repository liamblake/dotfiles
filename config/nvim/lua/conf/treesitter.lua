local M = {}

M.config = function()
	require("nvim-treesitter.configs").setup({
		ensure_installed = { "bash", "c", "cpp", "python", "julia", "latex", "rust", "typescript", "lua", "html" },
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
			-- Disable for LaTeX, since I prefer the Vimtex highlighting
			disable = { "latex" },
		},
		autopairs = { enable = true },
	})

	if vim.fn.has("win64") then
		require("nvim-treesitter.install").compilers = { "clang" }
	end
end

return M
