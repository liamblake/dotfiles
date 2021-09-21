-- Helper function to set key mappings
function key_mapper(mode, key, result)
	vim.api.nvim_set_keymap(mode, key, result, { noremap = true, silent = true })
end

-- LSP
key_mapper("n", "gd", ":lua vim.lsp.buf.definition()<CR>")
key_mapper("n", "gD", ":lua vim.lsp.buf.declaration()<CR>")
key_mapper("n", "gi", ":lua vim.lsp.buf.implementation()<CR>")
key_mapper("n", "gw", ":lua vim.lsp.buf.document_symbol()<CR>")
key_mapper("n", "gW", ":lua vim.lsp.buf.workspace_symbol()<CR>")
key_mapper("n", "gt", ":lua vim.lsp.buf.type_definition()<CR>")
key_mapper("n", "K", ":lua vim.lsp.buf.hover()<CR>")
key_mapper("n", "<c-k>", ":lua vim.lsp.buf.signature_help()<CR>")
key_mapper("n", "<leader>af", ":lua vim.lsp.buf.code_action()<CR>")
key_mapper("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>")

-- Telescope searches
key_mapper("n", "<leader>ff", ':lua require"plugin-config.telescope".project_files()<CR>')
key_mapper("n", "<leader>fr", ':lua require"telescope.builtin".lsp_references()<CR>')
key_mapper("n", "<leader>fg", ':lua require"telescope.builtin".live_grep()<CR>')
key_mapper("n", "<C-i>", ':lua require"telescope.builtin".buffers()<CR>')
key_mapper("n", "<leader>fs", ':lua require"telescope.builtin".treesitter()<CR>')

-- Toggle extension windows
key_mapper("n", "<leader>st", ':lua require"nvim-tree".toggle()<CR>')
key_mapper("n", "<leader>ss", ":SymbolsOutline<CR>")
key_mapper("n", "<leader>sg", ":Git<CR>")

-- Toggle trouble view
key_mapper("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
key_mapper("n", "<leader>xw", "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>")
key_mapper("n", "<leader>xd", "<cmd>TroubleToggle lsp_document_diagnostics<cr>")
key_mapper("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>")

-- Toggle light and dark themes
toggle_light_dark_colour = function()
	if vim.o.background == "dark" then
		vim.o.background = "light"
	else
		vim.o.background = "dark"
	end
	vim.cmd("redraw!")
	vim.cmd("colorscheme tokyonight")
end
key_mapper("n", "<leader>cs", ":lua toggle_light_dark_colour()<CR>")

-- Turn off hlsearch with two ESCAPEs
key_mapper("n", "<esc><esc>", "<cmd>nohls<CR>")

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
