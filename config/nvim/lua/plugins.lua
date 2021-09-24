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
	use("folke/tokyonight.nvim")
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
	use({
		"sunjon/Shade.nvim",
		config = function()
			require("shade").setup()
		end,
	})

	-- Completions
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			-- Sources
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "ray-x/cmp-treesitter" },
			{ "hrsh7th/cmp-path" },
			{ "quangnguyen30192/cmp-nvim-ultisnips" },
		},
	})

	-- LSP
	use("neovim/nvim-lspconfig")
	use({ "kabouzeid/nvim-lspinstall" })
	use({
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({ hint_enable = false, floating_window_above_curr_line = false })
		end,
	})
	use("onsails/lspkind-nvim")
	use({ "jose-elias-alvarez/null-ls.nvim" })

	-- Typing helps
	use("tpope/vim-commentary")
	use("tpope/vim-surround")
	use("tpope/vim-unimpaired")

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
		"shadmansaleh/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

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
	use({ "tpope/vim-fugitive" })

	-- Snippets
	use({
		"sirver/ultisnips",
		config = function()
			vim.g.UltiSnipsExpandTrigger = "<tab>"
		end,
	})

	use({
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({ auto_open = false, auto_preview = false })
		end,
	})

	-- Language-specific support
	use({
		"lervag/vimtex",
		config = function()
			vim.g.vimtex_compiler_latexmk = { build_dir = "build", continuous = 1 }
			-- Trouble will be opened automatically instead
			vim.g.vimtex_quickfix_mode = 0
			vim.g.vimtex_view_method = "zathura"
			vim.g.vimtex_toc_config = {
				show_help = 0,
				fold_enabled = 1,
				indent_levels = 1,
				split_pos = "vert rightbelow",
			}
			-- Start compilation automatically
			-- Automatically open trouble if compilation failed
			-- Clean auxillary files on close
			vim.cmd([[
				augroup vimtex_events
					au!
					au user VimtexEventInitPost VimtexCompile
					au user VimtexEventCompileFailed Trouble quickfix
					au user VimtexEventCompileSuccess TroubleClose
					au User VimtexEventQuit VimtexClean
			]])
		end,
		ft = { "tex", "bib" },
	})
	use({
		"JuliaEditorSupport/julia-vim",
		-- TODO: This causes the error "Unknown function: LaTeXtoUnicode#Refresh"
		-- ft = "julia"
	})
	use({
		"kdheepak/JuliaFormatter.vim",
		ft = "julia",
		config = function()
			vim.g.JuliaFormatter_always_launch_server = true
		end,
	})
	use({
		"jalvesaq/Nvim-R",
		ft = "r",
		config = function()
			vim.g.R_external_term = 1
			vim.g.R_notmuxconf = 1
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

	use({
		"akinsho/toggleterm.nvim",
		config = function()
			require("toggleterm").setup({})
		end,
	})

	-- Play nice with TMUX
	use({ "christoomey/vim-tmux-navigator" })

	-- Scrollbar
	use({
		"LiamBlake/nvim-scrollview",
		branch = "main", -- "minimal",
		config = function()
			vim.g.scrollview_auto_mouse = 0
			vim.g.scrollview_character = "|"
			-- require("scrollview").setup({ auto_mouse = 0 })
		end,
	})

	-- For debugging slow startup
	use({ "dstein64/vim-startuptime" })
end)

-- TODO: Get these working in use
require("plugin-config.completion").setup()
require("plugin-config.treesitter").setup()
require("plugin-config.autopairs").setup()
require("plugin-config.telescope").setup()
require("plugin-config.tree").setup()
require("plugin-config.lualine").setup()
require("plugin-config.symbols-outline").setup()
require("plugin-config.lsp").lspkind_setup()

-- Setup LSP servers
require("plugin-config.null-ls").setup()
require("plugin-config.lsp").setup_servers()
