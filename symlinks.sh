# Evnironment variables
source $(pwd)/config/system/.env

# Git config
ln -si $(pwd)/git/.gitconfig "$HOME"/

# Create links in .config/dir
for dir in "git" "terminator"; do
    ln -si $(pwd)/config/$dir "$HOME"/.config/
done


### The following symlinks behave differently ###
# Bash configs
for dir in ".bash_aliases" ".bashrc"; do
    ln -si $(pwd)/bash/$dir "$HOME"/
done

# VSCode setup
mkdir -p "$HOME"/.config/Code/User/
ln -si $(pwd)/vscode/settings.json "$HOME"/.config/Code/User/

# TeX style files
mkdir -p "$HOME/texmf/tex/latex/"
ln -si $(pwd)/tex/latex/* "$HOME/texmf/tex/latex/"
# Only symlinking the files and not the full directory prevents any clutter from locally installed packages.