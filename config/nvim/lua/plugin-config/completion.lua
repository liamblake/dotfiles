local M = {}

M.setup = function()
	local cmp = require("cmp")

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
			["<Tab>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "s" }),
		},
		sources = { { name = "nvim_lsp" }, { name = "ultisnips" }, { name = "path" }, { name = "treesitter" } },
		formatting = {
			format = function(entry, vim_item)
				vim_item.kind = require("lspkind").presets.default[vim_item.kind]
				return vim_item
			end,
		},
	})
end

return M
