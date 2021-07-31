local vim = vim

-- Set spacebar to be map leader
vim.g.mapleader = ' '

-- Helper function to set key mappings
local key_mapper = function(mode, key, result)
    vim.api.nvim_set_keymap(
      mode,
      key,
      result,
      {noremap = true, silent = true}
    )
  end

-- To force myself to stop using arrow keys, remove the mappings
key_mapper('', '<up>', '<nop>')
key_mapper('', '<down>', '<nop>')
key_mapper('', '<left>', '<nop>')
key_mapper('', '<right>', '<nop>')

-- Plugin setup, from https://bryankegley.me/posts/nvim-getting-started/
local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn
-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end
vim.cmd('packadd packer.nvim')
local packer = require'packer'
local util = require'packer.util'
packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})
--- startup and add configure plugins
packer.startup(function()
  local use = use
  -- add you plugins here like:
  -- use 'neovim/nvim-lspconfig'
  use 'mofiqul/dracula.nvim'
  end
)

-- Set colourscheme
vim.cmd("colorscheme dracula")