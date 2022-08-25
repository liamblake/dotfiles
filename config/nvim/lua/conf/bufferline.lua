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
			groups = {
				options = {
					toggle_hidden_on_enter = true,
				},
				items = {
					{
						name = "Writing",
						icon = "",
						matcher = function(buf)
							return buf.name:match("%.tex")
								or buf.name:match("%.bib")
								or buf.name:match("%.md")
								or buf.name:match("%.rmd")
						end,
					},
					{
						name = "Code",
						icon = "",
						matcher = function(buf)
							return buf.name:match("%.py") or buf.name:match("%.jl")
						end,
					},
				},
			},
		},
		highlights = { buffer_selected = { bold = true } },
		-- Groups
		-- Currently only useful for uni-related work, e.g. having TeX files and Python or Julia code open.
	})

	KeyMapper("n", "]b", ":BufferLineCycleNext<CR>")
	KeyMapper("n", "[b", ":BufferLineCyclePrev<CR>")
	KeyMapper("n", "gb", ":BufferLinePick<CR>")
end

return M
