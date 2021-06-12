# Evnironment variables
source $(pwd)/system/.env

# System symlinks
ln -si $(pwd)/system/.bash_aliases "$HOME"

# git symlinks
ln -si $(pwd)/git/.gitconfig "$HOME"

# TeX style files
mkdir -p "$HOME/texmf/tex/latex/"
ln -si $(pwd)/../tex/latex/* "$HOME/texmf/tex/latex/"
# TODO: Shared/local