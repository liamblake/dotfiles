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
			["<Tab>"] = function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end,
		},
		sources = { { name = "nvim_lsp" }, { name = "ultisnips" }, { name = "path" }, { name = "treesitter" } },
		formatting = {
			-- TODO: We should be able to use the built-in LSP completion kinds:
			-- https://github.com/hrsh7th/nvim-cmp/issues/39
			-- However, this seems to be slightly non-trivial in nvim-cmp:
			-- https://github.com/hrsh7th/nvim-cmp/issues/39
			format = function(_, vim_item)
				vim_item.kind = require("lspkind").presets.default[vim_item.kind]
				return vim_item
			end,
		},
		documentation = { zindex = 50 },
	})
end

return M
