local M = {}

M.config = function()
	require("bufferline").setup({
		-- TODO: Tabs
		options = {
			debug = { logging = true },
			mode = "buffer",
			numbers = "ordinal",
			show_buffer_close_icons = false,
			show_close_icons = false,
			diagnostics = "nvim_lsp",
		},
		highlights = { fill = { bg = "#1F1F28" }, buffer_selected = { bg = "#1F1F28", fg = "#DCD7BA", bold = true } },
		-- Groups
		-- Currently only useful for uni-related work, e.g. having TeX files and Python or Julia code open.
	})

	vim.keymap.set("n", "]b", ":BufferLineCycleNext<CR>")
	vim.keymap.set("n", "[b", ":BufferLineCyclePrev<CR>")
	vim.keymap.set("n", "gb", ":BufferLinePick<CR>")
end

return M
