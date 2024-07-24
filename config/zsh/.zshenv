# .zshenv
#
# This file is sourced each time zsh is initialised and contains environment and path variables.

# Environment variables
export EDITOR=nvim
export DOTFILES=~/dev/dotfiles

export JULIA_DEPOT_PATH="~/.julia/$JULIA_DEPOT_PATH"

# Path
path+=("$HOME/dev/dotfiles/bin")
path+=("$HOME/.local/bin")
path+=("$HOME/.cargo/bin")
path+=("$HOME/bin")
export PATH
. "$HOME/.cargo/env"
