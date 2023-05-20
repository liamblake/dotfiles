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
require("which-key").register({
	["<leader>tz"] = {
		name = "+true-zen",
		a = { "<cmd>TZAtaraxis<CR>", "ataraxis" },
		n = { "<cmd>'<,'>TZNarrow<CR>", "narrow" },
		m = { "<cmd>TZMinimalist<CR>", "minimalist" },
		f = { "<cmd>TZFocus<CR>", "focus" },
	},
})

return M
