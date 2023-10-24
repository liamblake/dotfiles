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

-- Start up and add configure plugins
packer.startup({
	function(use)
		-- Packer can manage itself
		use("wbthomason/packer.nvim")

		-- Theme and visuals
		use({
			"rebelot/kanagawa.nvim",
			config = function()
				require("conf.kanagawa").setup()
			end,
		})

		use({
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("ibl").setup({
					indent = { char = "│" },
					scope = { enabled = false },
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
		use("kyazdani42/nvim-web-devicons")

		-- Distraction-free working
		use({
			"Pocco81/true-zen.nvim",
			config = function()
				require("conf.true_zen").setup()
			end,
		})

		-- LSP - the order of plugins is important
		use({
			"williamboman/mason.nvim",
			config = function()
				-- require("mason").setup()
			end,
		})
		use({
			"williamboman/mason-lspconfig.nvim",
			config = function()
				-- require("mason-lspconfig").setup()
			end,
		})
		use({
			"neovim/nvim-lspconfig",
			setup = function()
				require("conf.lsp").setup()
			end,
			config = function()
				require("conf.lsp").config()
			end,
		})

		use({
			"ray-x/lsp_signature.nvim",
			config = function()
				require("lsp_signature").setup({
					hint_enable = false,
					floating_window_above_curr_line = false,
					handler_opts = { border = "single" },
				})
			end,
		})

		-- Completions
		use({
			"hrsh7th/nvim-cmp",
			requires = {
				-- Sources
				{ "hrsh7th/cmp-nvim-lsp" },
				{ "hrsh7th/cmp-path" },
				{ "hrsh7th/cmp-omni" },
				{ "quangnguyen30192/cmp-nvim-ultisnips" },
				{ "kdheepak/cmp-latex-symbols" },
			},
			config = function()
				require("conf.completion").config()
			end,
		})

		-- Typing helps
		use("tpope/vim-commentary")
		use("tpope/vim-surround")
		use("tpope/vim-unimpaired")
		use("LandonSchropp/vim-stamp")
		use("tpope/vim-repeat")
		use("wellle/targets.vim")
		use({
			"windwp/nvim-autopairs",
			config = function()
				require("conf.autopairs").config()
			end,
		})

		-- Treesitter-powered spellchecking
		use({
			"lewis6991/spellsitter.nvim",
			config = function()
				require("spellsitter").setup({ captures = { "comment", "string" } })
			end,
		})

		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			requires = {
				{ "nvim-lua/popup.nvim" },
				{ "nvim-lua/plenary.nvim" },
				{ "nvim-telescope/telescope-file-browser.nvim" },
			},
			config = function()
				require("conf.telescope").config()
			end,
		})

		-- Status line
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
			config = function()
				require("conf.lualine").config()
			end,
		})

		-- Git integration
		use({
			"lewis6991/gitsigns.nvim",
			config = function()
				require("gitsigns").setup({
					signs = { untracked = { text = "│" } },
					current_line_blame = false,
					current_line_blame_opts = {
						delay = 250,
						virt_text_post = "right_align",
					},
				})
			end,
		})

		-- Snippets
		use({
			"sirver/ultisnips",
			config = function()
				vim.g.UltiSnipsExpandTrigger = "<tab>"
				vim.g.UltiSnipsSnippetDirectories = { "ultisnips" }
			end,
		})

		use({
			"folke/which-key.nvim",
			config = function()
				require("conf.whichkey").setup()
			end,
		})

		-- Language-specific support
		use({
			"lervag/vimtex",
			config = function()
				require("conf.vimtex").setup()
			end,
			ft = { "tex", "bib" },
		})

		-- Syntax highlightings
		use({
			"nvim-treesitter/nvim-treesitter",
			config = function()
				require("conf.treesitter").config()
			end,
		})

		-- HTML
		use({
			"windwp/nvim-ts-autotag",
			config = function()
				require("nvim-ts-autotag").setup()
			end,
		})

		-- Color highlights
		use({
			"NvChad/nvim-colorizer.lua",
			config = function()
				require("colorizer").setup({ user_default_options = { names = false } })
			end,
		})

		-- Play nice with TMUX
		use({
			"christoomey/vim-tmux-navigator",
			cond = function()
				return vim.api.nvim_eval('exists("$TMUX")')
			end,
		})
	end,
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "single" })
			end,
		},
	},
})
