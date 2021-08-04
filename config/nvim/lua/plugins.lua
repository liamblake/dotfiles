-- Plugin setup, from https://bryankegley.me/posts/nvim-getting-started/
local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn
-- ensure that packer is installed
local install_path = fn.stdpath"data" .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
	execute("packadd packer.nvim")
end
vim.cmd("packadd packer.nvim")
local packer = require"packer"
local util = require"packer.util"
packer.init{
	package_root = util.join_paths(vim.fn.stdpath"data", "site", "pack")
}

-- Language servers
install_lsp_servers = function()
  local language_servers = {"cmake", "cpp", "latex", "lua", "python"}
  for _, server in pairs(language_servers) do
      require('lspinstall').install_server(server)
  end
end

-- - startup and add configure plugins
packer.startup(function()
	local use = use
  -- Theme
	use "Mofiqul/dracula.nvim"

	-- LSP
	use "neovim/nvim-lspconfig"
	use "nvim-lua/completion-nvim"
	use {
    "kabouzeid/nvim-lspinstall",
    config=function()
      vim.cmd[[command! InstallLspServers execute 'lua install_lsp_servers()']]
    end
  }

	-- Syntax highlightings
	use "nvim-treesitter/nvim-treesitter"

  -- Typing helps
  use "steelsojka/pears.nvim"

  -- Git blame
  use {
    "APZelos/blamer.nvim",
    config = function()
      vim.g.blamer_enabled = 1
      vim.g.blamer_delay = 500
    end
  }

	-- Telescope
	use{
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } }
	}

	-- Directory tree
	use "kyazdani42/nvim-tree.lua"
	use "kyazdani42/nvim-web-devicons"
  use "simrat39/symbols-outline.nvim"

	-- Bubbles
  use {'datwaft/bubbly.nvim', config = function()
    -- Here you can add the configuration for the plugin
    vim.g.bubbly_palette = {
      -- Dracula colour palette: https://draculatheme.com/contribute
      background = "#F8F8F2",
      foreground = "#f8f8f2",
      black = "#F8F8F2",
      current = "#44475a",
      comment = "#6272a4",
      cyan = "#8be9fd",
      green = "#50fa7b",
      orange = "#ffb86c",
      pink = "#ff79c6",
      purple = "#bd93f9",
      red = "#ff5555",
      yellow = "#f1fa8c"
    }
    vim.g.bubbly_statusline = {
      'mode',

      'path',
      'branch',

      'divisor',

      'filetype',
      'progress',
    }
  end}

	-- Autoformatting and other actions on save
	use "mhartington/formatter.nvim"
end)

-- Treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = {"bash", "c", "cpp", "python", "julia", "rust"},
  highlight = {
    enable=true,
    additional_vim_regex_highlighting = false,
  }
}

-- Formatters
require('formatter').setup({
  logging = false,
  filetype = {
    python = {
      -- black and isort
      function()
        return {
          exe = {"black", "isort"},
          args = {},
          stdin = true,
        }
      end
    },
    cpp = {
        -- clang-format
       function()
          return {
            exe = "clang-format",
            args = {"--assume-filename", vim.api.nvim_buf_get_name(0)},
            stdin = true,
            cwd = vim.fn.expand('%:p:h')  -- Run clang-format in cwd of the file.
          }
        end
    }
  }
})

-- Format on save
vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.py,*.cpp,*.hpp,*.h FormatWrite
augroup END
]], true)

-- Tree
vim.g.nvim_tree_side = 'left' 
vim.g.nvim_tree_width = 40
vim.g.nvim_tree_gitignore = 0
vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_auto_close = 1 
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_indent_markers = 1 
vim.g.nvim_tree_hide_dotfiles = 1 
vim.g.nvim_tree_git_hl = 0
vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_root_folder_modifier = ':~'
vim.g.nvim_tree_tab_open = 1 
vim.g.nvim_tree_auto_resize = 0 
vim.g.nvim_tree_disable_netrw = 0
vim.g.nvim_tree_hijack_netrw = 0
vim.g.nvim_tree_add_trailing = 1
vim.g.nvim_tree_group_empty = 1 
vim.g.nvim_tree_lsp_diagnostics = 1
vim.g.nvim_tree_disable_window_picker = 1 
vim.g.nvim_tree_hijack_cursor = 0 
vim.g.nvim_tree_icon_padding = ' ' 
vim.g.nvim_tree_update_cwd = 1
vim.g.nvim_tree_show_icons = {
  git = 0,
  folders = 1,
  files = 1,
  folder_arrows = 1
}

-- Bracket pairing
require("pears").setup()

-- Symbols outline
vim.g.symbols_outline = {
  highlight_hovered_item = true,
  show_guides = true,
  auto_preview = true,
  position = 'right',
  width = 25,
  show_numbers = false,
  show_relative_numbers = false,
  show_symbol_details = true,
  keymaps = { -- These keymaps can be a string or a table for multiple keys
      close = {"<Esc>", "q"},
      goto_location = "<Cr>",
      focus_location = "o",
      hover_symbol = "<C-space>",
      rename_symbol = "r",
      code_actions = "a",
  },
  lsp_blacklist = {},
  symbol_blacklist = {},
  symbols = {
      File = {icon = "", hl = "TSURI"},
      Module = {icon = "", hl = "TSNamespace"},
      Namespace = {icon = "", hl = "TSNamespace"},
      Package = {icon = "", hl = "TSNamespace"},
      Class = {icon = "𝓒", hl = "TSType"},
      Method = {icon = "ƒ", hl = "TSMethod"},
      Property = {icon = "", hl = "TSMethod"},
      Field = {icon = "", hl = "TSField"},
      Constructor = {icon = "", hl = "TSConstructor"},
      Enum = {icon = "ℰ", hl = "TSType"},
      Interface = {icon = "ﰮ", hl = "TSType"},
      Function = {icon = "", hl = "TSFunction"},
      Variable = {icon = "", hl = "TSConstant"},
      Constant = {icon = "", hl = "TSConstant"},
      String = {icon = "𝓐", hl = "TSString"},
      Number = {icon = "#", hl = "TSNumber"},
      Boolean = {icon = "⊨", hl = "TSBoolean"},
      Array = {icon = "", hl = "TSConstant"},
      Object = {icon = "⦿", hl = "TSType"},
      Key = {icon = "🔐", hl = "TSType"},
      Null = {icon = "NULL", hl = "TSType"},
      EnumMember = {icon = "", hl = "TSField"},
      Struct = {icon = "𝓢", hl = "TSType"},
      Event = {icon = "🗲", hl = "TSType"},
      Operator = {icon = "+", hl = "TSOperator"},
      TypeParameter = {icon = "𝙏", hl = "TSParameter"}
  }
}

