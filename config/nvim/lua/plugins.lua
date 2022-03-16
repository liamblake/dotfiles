require("util")

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
	use({ "folke/tokyonight.nvim" })
	use({
		"rmehri01/onenord.nvim",
		config = function()
			require("onenord").setup({ italics = { comments = true, keywords = false } })
		end,
	})
	use({
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("indent_blankline").setup({
				char = "│",
				buftype_exclude = { "terminal", "help" },
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
	use("kyazdani42/nvim-web-devicons")

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		setup = function()
			require("conf.lsp").setup()
		end,
		config = function()
			require("conf.lsp").config()
		end,
	})

	use({ "williamboman/nvim-lsp-installer" })
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
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("conf.null_ls").setup()
		end,
	})

	-- Completions
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			-- Sources
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
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
	use("LandonSchropp/vim-stamp")
	use("tpope/vim-repeat")

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
			require("telescope").load_extension("file_browser")

			-- TODO: These should be in conf/telescope.lua
			KeyMapper("n", "<leader>ff", ':lua require"conf.telescope".project_files()<CR>')
			KeyMapper("n", "<leader>fr", ':lua require"telescope.builtin".lsp_references()<CR>')
			KeyMapper("n", "<leader>ft", ':lua require"telescope.builtin".live_grep()<CR>')
			KeyMapper("n", "<leader>fs", ':lua require"telescope.builtin".treesitter()<CR>')
			KeyMapper("n", "<leader>fws", ':lua require"telescope.builtin".lsp_workspace_symbols()<CR>')
			KeyMapper("n", "<leader>fd", ':lua require"conf.telescope".search_dotfiles()<CR>')
			KeyMapper("n", "<leader>fn", ':lua require"conf.telescope".search_notes()<CR>')
			KeyMapper("n", "<leader>fb", ':lua require"telescope".extensions.file_browser.file_browser()<CR>')
			KeyMapper("n", "<leader>fgs", ':lua require"telescope.builtin".git_stash()<CR>')
			KeyMapper("n", "<leader>fgb", ':lua require"telescope.builtin".git_branches()<CR>')
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
		"tpope/vim-fugitive",
		config = function()
			KeyMapper("n", "<leader>sg", ":Git<CR>")
		end,
	})

	-- Snippets
	use({
		"sirver/ultisnips",
		config = function()
			vim.g.UltiSnipsExpandTrigger = "<tab>"
		end,
	})

	-- Annotation generation
	use({
		"danymat/neogen",
		config = function()
			require("conf.neogen").config()
		end,
		requires = "nvim-treesitter/nvim-treesitter",
	})

	use({
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({ auto_open = false, auto_preview = false })

			KeyMapper("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
			KeyMapper("n", "<leader>xw", "<cmd>TroubleToggle lsp_workspace_diagnostics<cr>")
			KeyMapper("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
			KeyMapper("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
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

	-- Markdown
	use({
		"jakewvincent/mkdnflow.nvim",
		ft = { "md", "rmd", "markdown" },
		config = function()
			require("mkdnflow").setup({ new_file_prefix = [['']] })
		end,
	})

	-- Syntax highlightings
	use({
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("conf.treesitter").config()
		end,
	})

	-- Typing helps
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("conf.autopairs").config()
		end,
	})

	-- Play nice with TMUX
	use({
		"christoomey/vim-tmux-navigator",
		cond = function()
			return vim.api.nvim_eval('exists("$TMUX")')
		end,
	})

	-- For debugging slow startup
	use({ "dstein64/vim-startuptime" })
end)
