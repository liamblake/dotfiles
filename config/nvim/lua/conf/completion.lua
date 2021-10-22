local M = {}

M.config = function()
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
		sources = {
			{ name = "nvim_lsp" },
			{ name = "ultisnips" },
			{ name = "path" },
			{ name = "treesitter" },
			{ name = "neorg" },
		},
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

	-- TODO: Is this still required?
	-- Cycle through options with tab and shift-tab when the window is open.
	-- From https://github.com/hrsh7th/nvim-compe#how-to-use-tab-to-navigate-completion-menu
	local t = function(str)
		return vim.api.nvim_replace_termcodes(str, true, true, true)
	end

	local check_back_space = function()
		local col = vim.fn.col(".") - 1
		return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
	end

	-- Use (s-)tab to:
	--- move to prev/next item in completion menuone
	--- jump to prev/next snippet's placeholder
	_G.tab_complete = function()
		if vim.fn.pumvisible() == 1 then
			return t("<C-n>")
		elseif check_back_space() then
			return t("<Tab>")
		else
			return vim.fn["compe#complete"]()
		end
	end
	_G.s_tab_complete = function()
		if vim.fn.pumvisible() == 1 then
			return t("<C-p>")
		else
			-- If <S-Tab> is not working in your terminal, change it to <C-h>
			return t("<S-Tab>")
		end
	end

	vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", { expr = true })
	vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", { expr = true })
	vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
	vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", { expr = true })
end

return M
