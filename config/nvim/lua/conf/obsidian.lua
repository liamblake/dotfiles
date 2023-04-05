local M = {}

M.new_obsidian_note = function()
	local fname = vim.fn.input("Name of the new file: ")
	vim.fn.ObsidianNew(fname)
end

M.config = function()
	require("obsidian").setup({
		dir = "~/Dropbox/notes",
		completion = {
			nvim_cmp = true,
		},
		disable_frontmatter = true,
	})

	-- Keybindings
	require("which-key").register({
		["<leader>o"] = {
			name = "+obsidian",
			o = { "<cmd>ObsidianOpen<cr>", "open in Obsidian" },
			-- n = "new Obsidian note",
		},
		["<leader>f"] = { o = { "<cmd>ObsidianQuickSwitch<cr>", "Obsidian notes" } },
	})
	-- vim.api.nvim_set_keymap("n", "<leader>on", M.new_obsidian_note, { expr = true })
end

return M
