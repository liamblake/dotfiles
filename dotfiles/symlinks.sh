# Evnironment variables
source $(pwd)/system/.env

# Bash configs
for dir in ".bash_aliases" ".bashrc"; do
    ln -si $(pwd)/bash/$dir "$HOME"/
done

# Git config
ln -si $(pwd)/git/.gitconfig "$HOME"/

# Create links in .config/dir
for dir in "git" "terminator"; do
    ln -si $(pwd)/$dir "$HOME"/.config/
done

# VSCode setup
# TODO: Generalise the above so that this can be performed in the loop

ln -si $(pwd)/vscode/settings.json "$HOME"/.config/Code/User/
