# Evnironment variables
source $(pwd)/system/.env

# Bash configs
for dir in $(ls -a bash/)
do
    if [ $dir -eq "." -or$dir -eq ".."]
    then
        continue
    fi

    ln -si $(pwd)/bash/$dir "$HOME"/
done

# Create links in .config/dir
for dir in "git" "terminator"
do 
    ln -si $(pwd)/$dir "$HOME"/.config/
done

# VSCode setup
# TODO: Generalise the above so that this can be performed in the loop

ln -si $(pwd)/vscode/settings.json "$HOME"/.config/Code/User/