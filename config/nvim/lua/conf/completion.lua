local M = {}

M.config = function()
	local cmp = require("cmp")
	local symbol_map = {
		Text = "  ",
		Method = "  ",
		Function = "  ",
		Constructor = "  ",
		Field = "  ",
		Variable = "  ",
		Class = "  ",
		Interface = "  ",
		Module = "  ",
		Property = "  ",
		Unit = "  ",
		Value = "  ",
		Enum = "  ",
		Keyword = "  ",
		Snippet = "  ",
		Color = "  ",
		File = "  ",
		Reference = "  ",
		Folder = "  ",
		EnumMember = "  ",
		Constant = "  ",
		Struct = "  ",
		Event = "  ",
		Operator = "  ",
		TypeParameter = "  ",
	}

	cmp.setup({
		snippet = {
			expand = function(args)
				vim.fn["UltiSnips#Anon"](args.body)
			end,
		},
		mapping = {
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.close(),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<Tab>"] = function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end,
		},
		-- Insert mode completion
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "ultisnips" },
			{ name = "path" },
		}),

		formatting = {
			-- TODO: We should be able to use the built-in LSP completion kinds:
			-- https://github.com/hrsh7th/nvim-cmp/issues/39
			-- However, this seems to be slightly non-trivial in nvim-cmp:
			-- https://github.com/hrsh7th/nvim-cmp/issues/39
			format = function(_, vim_item)
				vim_item.kind = (symbol_map[vim_item.kind] or "")
				return vim_item
			end,
		},
		documentation = { zindex = 50 },
	})
end

return M
