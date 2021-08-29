local M = {}

M.setup = function()
	require("nvim-treesitter.configs").setup({
		ensure_installed = { "bash", "c", "cpp", "python", "julia", "latex", "rust", "typescript", "lua" },
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		autopairs = { enable = true },
	})
end

return M
