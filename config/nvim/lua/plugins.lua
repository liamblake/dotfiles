-- Plugin setup, from https://bryankegley.me/posts/nvim-getting-started/
local execute = vim.api.nvim_command
local fn = vim.fn
-- ensure that packer is installed
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	execute("packadd packer.nvim")
end
vim.cmd("packadd packer.nvim")
local packer = require("packer")
local util = require("packer.util")
packer.init({
	package_root = util.join_paths(vim.fn.stdpath("data"), "site", "pack"),
})

-- Language servers
install_lsp_servers = function()
	for lang in { "cmake", "cpp", "html", "latex", "lua", "python", "typescript" } do
		require("lspinstall").install_server(lang)
	end
end

-- - startup and add configure plugins
packer.startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Theme
	use("LiamBlake/dracula-vim")

	-- LSP
	use("neovim/nvim-lspconfig")
	use("nvim-lua/completion-nvim")
	use({
		"kabouzeid/nvim-lspinstall",
		config = function()
			vim.cmd([[command! InstallLspServers execute 'lua install_lsp_servers()']])
		end,
	})

	-- Syntax highlightings
	use("nvim-treesitter/nvim-treesitter")

	-- Typing helps
	use("steelsojka/pears.nvim")
	use("tpope/vim-commentary")
	use("tpope/vim-surround")

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
	})

	-- Directory tree
	use("kyazdani42/nvim-tree.lua")
	use("kyazdani42/nvim-web-devicons")

	-- Symbol outline
	use("simrat39/symbols-outline.nvim")

	-- Status line
	use({
		"hoob3rt/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- Bufferline
	use({ "akinsho/nvim-bufferline.lua", requires = "kyazdani42/nvim-web-devicons" })

	-- Formatting
	use("mhartington/formatter.nvim")

	-- Git integration
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("gitsigns").setup({
				current_line_blame = true,
				current_line_blame_delay = 250,
			})
		end,
	})

	-- Autocompletions
	use("hrsh7th/nvim-compe")

	-- Snippets
	--use("sirver/ultisnips")
end)

-- Treesitter
require("nvim-treesitter.configs").setup({
	ensure_installed = { "bash", "c", "cpp", "python", "julia", "rust" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

-- Formatters
require("formatter").setup({
	logging = false,
	filetype = {
		python = {
			-- black
			function()
				return {
					exe = { "black" },
					args = {},
					stdin = true,
				}
			end,
			-- isort
			function()
				return {
					exe = { "isort" },
					args = {},
					stdin = true,
				}
			end,
		},
		cpp = {
			-- clang-format
			function()
				return {
					exe = "clang-format",
					args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
					stdin = true,
					cwd = vim.fn.expand("%:p:h"), -- Run clang-format in cwd of the file.
				}
			end,
		},
		lua = {
			-- stylua
			function()
				return {
					exe = "stylua",
					args = {},
					stdin = true,
				}
			end,
		},
	},
})

-- Format on save
vim.api.nvim_exec(
	[[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.py,*.cpp,*.hpp,*.h FormatWrite
augroup END
]],
	true
)

-- Bracket pairing
require("pears").setup()

-- NvimTree
vim.g.nvim_tree_side = "left"
vim.g.nvim_tree_width = 40
vim.g.nvim_tree_ignore = {".git", "$null"}
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_auto_close = 0
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_hide_dotfiles = 0
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_root_folder_modifier = ":~"
vim.g.nvim_tree_tab_open = 1
vim.g.nvim_tree_auto_resize = 0
vim.g.nvim_tree_disable_netrw = 0
vim.g.nvim_tree_hijack_netrw = 0
vim.g.nvim_tree_add_trailing = 1
vim.g.nvim_tree_group_empty = 1
vim.g.nvim_tree_lsp_diagnostics = 1
vim.g.nvim_tree_disable_window_picker = 1
vim.g.nvim_tree_hijack_cursor = 0
vim.g.nvim_tree_icon_padding = " "
vim.g.nvim_tree_update_cwd = 1
vim.g.nvim_tree_show_icons = {
	git = 0,
	folders = 1,
	files = 1,
	folder_arrows = 1,
}

-- Symbols outline
vim.g.symbols_outline = {
	highlight_hovered_item = true,
	show_guides = true,
	auto_preview = true,
	position = "right",
	width = 25,
	show_numbers = false,
	show_relative_numbers = false,
	show_symbol_details = true,
	keymaps = { -- These keymaps can be a string or a table for multiple keys
		close = { "<Esc>", "q" },
		goto_location = "<Cr>",
		focus_location = "o",
		hover_symbol = "<C-space>",
		rename_symbol = "r",
		code_actions = "a",
	},
	lsp_blacklist = {},
	symbol_blacklist = {},
	symbols = {
		File = { icon = "", hl = "TSURI" },
		Module = { icon = "", hl = "TSNamespace" },
		Namespace = { icon = "", hl = "TSNamespace" },
		Package = { icon = "", hl = "TSNamespace" },
		Class = { icon = "𝓒", hl = "TSType" },
		Method = { icon = "ƒ", hl = "TSMethod" },
		Property = { icon = "", hl = "TSMethod" },
		Field = { icon = "", hl = "TSField" },
		Constructor = { icon = "", hl = "TSConstructor" },
		Enum = { icon = "ℰ", hl = "TSType" },
		Interface = { icon = "ﰮ", hl = "TSType" },
		Function = { icon = "", hl = "TSFunction" },
		Variable = { icon = "", hl = "TSConstant" },
		Constant = { icon = "", hl = "TSConstant" },
		String = { icon = "𝓐", hl = "TSString" },
		Number = { icon = "#", hl = "TSNumber" },
		Boolean = { icon = "⊨", hl = "TSBoolean" },
		Array = { icon = "", hl = "TSConstant" },
		Object = { icon = "⦿", hl = "TSType" },
		Key = { icon = "🔐", hl = "TSType" },
		Null = { icon = "NULL", hl = "TSType" },
		EnumMember = { icon = "", hl = "TSField" },
		Struct = { icon = "𝓢", hl = "TSType" },
		Event = { icon = "🗲", hl = "TSType" },
		Operator = { icon = "+", hl = "TSOperator" },
		TypeParameter = { icon = "𝙏", hl = "TSParameter" },
	},
}

-- Bufferline
require("bufferline").setup({
	options = {
		numbers = "ordinal",
		diagnostics = "nvim_lsp",
		show_buffer_icons = true,
		show_buffer_close_icons = false,
	},
})

-- Status line
require("lualine").setup({
	options = { theme = "dracula" },
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch" },
		lualine_c = { "filename" },
		lualine_x = { "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
})

-- Telescope
require("telescope").setup({
	file_ignore_patterns = {"venv"}
})

-- Snippets
vim.g.UltiSnipsSnippetDirectories = "snippets"
