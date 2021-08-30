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

	-- Theme and visuals
	use("dracula/vim")
	use("folke/tokyonight.nvim")
	-- use("sainnhe/edge")
	use("sainnhe/sonokai")
	-- use({
	-- 	"Pocco81/Catppuccino.nvim",
	-- 	config = function()
	-- 		local catppuccino = require("catppuccino")
	-- 		catppuccino.setup({
	-- 			colorscheme = "neon_latte",
	-- 			-- transparency = true,
	-- 			integrations = { indent_blankline = true, barbar = true, telescope = true },
	-- 		}, {
	-- 			bg = "#24283b",
	-- 			green = "#97c374",
	-- 		})

	-- 		-- catppuccino.load()
	-- 	end,
	-- })

	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				char = "│",
				buftype_exclude = { "terminal" },
				use_treesitter = true,
			})
		end,
	})

	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({
				highlight = {
					-- Only highlight the keyword and not the space around it
					keyword = "bg",
				},
				search = { pattern = [[\b(KEYWORDS)]] },
			})
		end,
	})

	-- LSP
	use("neovim/nvim-lspconfig")
	use("nvim-lua/completion-nvim")
	use({
		"kabouzeid/nvim-lspinstall",
		config = function()
			vim.cmd([[command! InstallLspServers execute 'lua install_lsp_servers()']])
		end,
	})
	use({
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup()
		end,
	})
	use("onsails/lspkind-nvim")

	use("tpope/vim-commentary")
	use("tpope/vim-surround")

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
	})

	-- Tabline
	use({
		"romgrk/barbar.nvim",
		requires = { "kyazdani42/nvim-web-devicons" },
	})

	-- Directory tree
	use({ "kyazdani42/nvim-tree.lua" })
	use("kyazdani42/nvim-web-devicons")

	-- Symbol outline
	use("simrat39/symbols-outline.nvim")

	-- Status line
	use({
		"hoob3rt/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- Formatting
	use({ "mhartington/formatter.nvim" })

	-- Git integration
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("gitsigns").setup({
				current_line_blame = false,
				current_line_blame_opts = {
					delay = 250,
					virt_text_post = "right_align",
				},
			})
		end,
	})

	-- Autocompletions
	use({
		"hrsh7th/nvim-compe",
	})

	-- Snippets
	use("sirver/ultisnips")

	-- Additional linters
	use("mfussenegger/nvim-lint")

	-- Language-specific support
	use({
		"lervag/vimtex",
		config = function()
			vim.g.vimtex_compiler_latexmk = { build_dir = "build", continuous = true }
		end,
	})

	-- Focus
	use({
		"folke/zen-mode.nvim",
		config = function()
			require("zen-mode").setup({ window = { width = 0.85, height = 1 }, plugins = { tmux = { enabled = true } } })
		end,
	})

	-- Zoxide integration
	use("nanotee/zoxide.vim")

	-- Syntax highlightings
	use({ "nvim-treesitter/nvim-treesitter" })

	-- Typing helps
	use({ "windwp/nvim-autopairs" })
end)

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

-- Status line
require("lualine").setup({
	options = { theme = "tokyonight", section_separators = { "", "" }, component_separators = { "|", "|" } },
	sections = {
		lualine_a = { "mode" },
		lualine_b = { "branch", "diff" },
		lualine_c = { { "filename", path = 1 } },
		lualine_x = {
			{
				"diagnostics",
				sources = { "nvim_lsp" },
				-- displays diagnostics from defined severity
				sections = { "error", "warn", "info", "hint" },
			},
		},
		lualine_y = { "filetype" },
		lualine_z = { "location" },
	},
	tabline = {
		lualine_a = { "filename" },
	},
	extensions = { "nvim-tree" },
})
-- Snippets
vim.g.UltiSnipsExpandTrigger = "<tab>"

-- Linters
require("lint").linters_by_ft = {
	python = { "flake8" },
}
vim.api.nvim_exec(
	[[
		au BufWritePost <buffer> lua require('lint').try_lint()
	]],
	true
)

-- NvimTree
vim.g.nvim_tree_side = "left"
vim.g.nvim_tree_width = 40
vim.g.nvim_tree_ignore = { ".git", "$null" }
vim.g.nvim_tree_gitignore = 1
vim.g.nvim_tree_auto_open = 0
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

require("config.formatter").setup()
require("config.compe").setup()
require("config.treesitter").setup()
require("config.autopairs").setup()
require("config.telescope").setup()
