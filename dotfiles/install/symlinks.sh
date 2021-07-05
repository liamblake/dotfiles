# Evnironment variables
source $(pwd)/../system/.env

# Bash aliases
ln -si $(pwd)/../system/.bash_aliases "$HOME"

# Create links in .config/dir
for dir in "git" "terminator"
do 
    ln -si $(pwd)/../$dir "$HOME"/.config/
done

