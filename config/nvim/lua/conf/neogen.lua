local M = {}

M.config = function()
	require("neogen").setup({
		enabled = true,
		jump_map = "<C-j>",
	})

	vim.keymap.set("n", "<leader>nf", ":lua require('neogen').generate({type = 'func'})<CR>")
	vim.keymap.set("n", "<leader>nc", ":lua require('neogen').generate({type = 'class'})<CR>")
	vim.keymap.set("n", "<leader>nt", ":lua require('neogen').generate({type = 'type'})<CR>")
end

return M
