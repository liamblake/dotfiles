# Allow easy access of dotfiles path
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# System symlinks
ln -si $(pwd)/system/.bash_aliases "$HOME"

# git symlinks
ln -si $(pwd)/git/.gitconfig "$HOME"