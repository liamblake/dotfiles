# Create links in .config/dir
for dir in "git" "terminator"; do
    ln -si $(pwd)/config/$dir "$HOME"/.config/
done

### The following symlinks behave differently ###
# Git config
ln -si $(pwd)/git/.gitconfig "$HOME"/

# Bash configs
for dir in ".bash_aliases" ".bashrc"; do
    ln -si $(pwd)/bash/$dir "$HOME"/
done

# .inputrc
ln -si $(pwd)/config/system/.inputrc "$HOME"/

# VSCode setup
mkdir -p "$HOME"/.config/Code/User/
ln -si $(pwd)/vscode/settings.json "$HOME"/.config/Code/User/

# TeX style files
mkdir -p "$HOME/texmf/tex/latex/"
ln -si $(pwd)/tex/latex/* "$HOME/texmf/tex/latex/"
# Only symlinking the files and not the full directory prevents any clutter from locally installed packages.

# Install .fzf
source $(pwd)/ext/fzf/install --completion --key-bindings --all