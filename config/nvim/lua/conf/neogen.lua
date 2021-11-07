local M = {}

M.config = function()
	require("neogen").setup({
		enabled = true,
		jump_map = "<C-j>",
	})

	KeyMapper("n", "<leader>nf", ":lua require('neogen').generate({type = 'func'})<CR>")
	KeyMapper("n", "<leader>nc", ":lua require('neogen').generate({type = 'class'})<CR>")
	KeyMapper("n", "<leader>nt", ":lua require('neogen').generate({type = 'type'})<CR>")
end

return M
