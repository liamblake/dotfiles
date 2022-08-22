# .zshenv
#
# This file is sourced each time zsh is initialised and contains environment and path variables.

# Environment variables
export EDITOR=nvim
export DOTFILES=~/dev/dotfiles

# Path
path+=("$HOME/dev/dotfiles/bin")
path+=("$HOME/.local/bin")
path+=("$HOME/.cargo/bin")
path+=("$HOME/bin")
export PATH
