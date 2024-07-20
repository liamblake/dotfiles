local M = {}

M.setup = function()
	require("true-zen").setup({
		integrations = { tmux = true, lualine = true },
		modes = {
			ataraxis = {
				padding = { left = 13, right = 13 },
				callbacks = {
					open_pos = function()
						-- Ensure numbers are enabled.
						vim.o.number = true
						vim.o.relativenumber = true
					end,
				},
			},
		},
	})
end

-- Custom callback to narrow on current section in TeX files

-- Keybindings!
require("which-key").add({
	{ "<leader>tz", group = "true-zen" },
	{ "<leader>tza", "<cmd>TZAtaraxis<CR>", desc = "ataraxis" },
	{ "<leader>tzn", "<cmd>'<,'>TZNarrow<CR>", desc = "narrow" },
	{ "<leader>tzm", "<cmd>TZMinimalist<CR>", desc = "minimalist" },
	{ "<leader>tzf", "<cmd>TZFocus<CR>", desc = "focus" },
})

return M
