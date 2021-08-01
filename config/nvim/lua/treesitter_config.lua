require('helpers')

require('nvim-treesitter.configs').setup {
    -- one of "all", "language", or a list of languages
    ensure_installed = {"bash", "c", "cpp", "python", "julia", "rust"}
}

-- Key mappings
key_mapper('n', '<C-p>', ':lua require"telescope.builtin".find_files()<CR>')
key_mapper('n', '<leader>fs', ':lua require"telescope.builtin".live_grep()<CR>')
key_mapper('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>')
key_mapper('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>')