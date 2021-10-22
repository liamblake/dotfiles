-- Helper function to set key mappings
function KeyMapper(mode, key, result)
	vim.api.nvim_set_keymap(mode, key, result, { noremap = true, silent = true })
end
