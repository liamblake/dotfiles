local M = {}

M.config = function()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"bash",
			"c",
			"cpp",
			"python",
			"julia",
			"latex",
			"rust",
			"typescript",
			"lua",
			"html",
			"markdown",
			"markdown_inline",
		},
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = { "markdown" },
			-- Disable for LaTeX, since I prefer the Vimtex highlighting
			disable = { "latex" },
		},
		autopairs = { enable = true },
	})

	if vim.fn.has("win64") then
		require("nvim-treesitter.install").compilers = { "clang" }
	end

	-- Parse Quarto files as RMarkdown, for now.
	local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername
	ft_to_parser.quarto = "R"
end

return M
