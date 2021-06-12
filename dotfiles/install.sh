# Evnironment variables
source $(pwd)/system/.env

# System symlinks
ln -si $(pwd)/system/.bash_aliases "$HOME"

# git symlinks
ln -si $(pwd)/git/.gitconfig "$HOME"