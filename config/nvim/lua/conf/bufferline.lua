local M = {}

M.config = function()
	require("bufferline").setup({
		-- TODO: Tabs
		options = {
			numbers = "ordinal",
			show_buffer_close_icons = false,
			show_close_icons = false,
			diagnostics = "nvim_lsp",
			close_icon = ''
		},
		highlights = { buffer_selected = { gui = "bold" } },
		-- Groups
		-- Currently only useful for uni-related work, e.g. having TeX files and Python or Julia code open.
		groups = {
		  options = {
		    toggle_hidden_on_enter = true 
		  },
		  items = {
			  {
				  name = "Writing",
				  priority = 1,
				  autoclose = false,
				  icon = "",
				  matcher = function(buf)
					  return buf.name:match('%.tex') or buf.name:match('%.bib') or buf.name:match("%.md") or buf.name:match("%.rmd")
				  end
			  },
			  {
				name = "Code",
				priority = 2,
				autoclose = false,
				icon = "",
				matcher = function(buf)
					return buf.name:match('%.py') or buf.name:match('%.jl')
				end
			  }
		    }
		  }
	})

	KeyMapper("n", "]b", ":BufferLineCycleNext<CR>")
	KeyMapper("n", "[b", ":BufferLineCyclePrev<CR>")
	KeyMapper("n", "gb", ":BufferLinePick<CR>")
end

return M
