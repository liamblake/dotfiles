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

-- - startup and add configure plugins
packer.startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Theme and visuals
	-- use("dracula/vim")
	use("folke/tokyonight.nvim")
	-- use("sainnhe/edge")
	-- use("sainnhe/sonokai")

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
			vim.cmd([[command! InstallLspServers execute 'lua require("plugin-config.lsp").install_lsp_servers()']])
		end,
	})
	use({
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({ hint_enable = false, floating_window_above_curr_line = false })
		end,
	})
	use("onsails/lspkind-nvim")

	-- Typing helps
	use("tpope/vim-commentary")
	use("tpope/vim-surround")

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
	})

	-- Tabline
	use({
		"akinsho/bufferline.nvim",
		config = function()
			require("bufferline").setup({
				options = {
					numbers = "buffer_id",
					offsets = { { filetype = "NvimTree", text = "Explorer" } },
					show_buffer_close_icons = false,
					show_close_icons = false,
					diagnostics = "nvim_lsp",
				},
			})
		end,
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
	use({
		"sindrets/diffview.nvim",
		config = function()
			require("diffview").setup({})
		end,
	})

	-- Autocompletions
	use({ "hrsh7th/nvim-compe" })

	-- Snippets
	use({
		"sirver/ultisnips",
		config = function()
			vim.g.UltiSnipsExpandTrigger = "<tab>"
		end,
	})

	-- Additional linters
	use({
		"mfussenegger/nvim-lint",
		config = function()
			require("lint").linters_by_ft = {
				python = { "flake8" },
			}
			vim.api.nvim_exec(
				[[
		au BufWritePost <buffer> lua require('lint').try_lint()
	]],
				true
			)
		end,
	})

	-- Language-specific support
	use({
		"lervag/vimtex",
		config = function()
			vim.g.vimtex_compiler_latexmk = { build_dir = "build", continuous = 1 }
			-- Only automatically open the quickfix window after compilation if there are errors.
			vim.g.vimtex_quickfix_open_on_warning = 0
			vim.g.vimtex_view_method = "zathura"
		end,
	})
	use({ "JuliaEditorSupport/julia-vim" })

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

	use({
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({})
		end,
	})
end)

-- TODO: Get these working in use
require("plugin-config.formatter").setup()
require("plugin-config.compe").setup()
require("plugin-config.treesitter").setup()
require("plugin-config.autopairs").setup()
require("plugin-config.telescope").setup()
require("plugin-config.tree").setup()
require("plugin-config.lualine").setup()
require("plugin-config.symbols-outline").setup()
require("plugin-config.lsp").lspkind_setup()

-- Setup LSP servers
require("plugin-config.lsp").setup_servers()
