# Absolute path of root of dotfiles
SCRIPT=$(readlink -f "$0")
DOTFILES_ROOT=$(dirname "$SCRIPT")/../../
echo $DOTFILES_ROOT

create_home_symlink() {
  SRC=$1
  TARGET=$2
  ln -si $DOTFILES_ROOT/$SRC $HOME/$TARGET
}

# Make .config dir if it doesn't already exist
mkdir -p "$HOME/.config"

# Create links in .config/dir
# TODO: Move more files to .config, will reduce repetition in this file.
for dir in "git" "tmuxinator" "nvim"; do
    create_home_symlink config/$dir .config/
done

### The following symlinks behave differently ###
# Bash configs
for dir in ".bash_aliases" ".bashrc"; do
    create_home_symlink bash/$dir .
done

# .inputrc
create_home_symlink config/system/.inputrc .

# zsh
create_home_symlink zsh/.zshrc .
create_home_symlink zsh/.zshenv .

# Link plugins to oh-my-zsh dir
mkdir -p "$HOME"/.config/zsg/plugins
for dir in $(ls config/zsh/plugins/); do
  create_home_symlink zsh/plugins/$dir .oh-my-zsh/plugins/
done


# VSCode setup
mkdir -p "$HOME"/.config/Code/User/
# TODO: Replace this with a ls
for dir in "settings.json" "keybindings.json"; do
  create_home_symlink config/vscode/$dir .config/Code/User/
done

# TeX style files
mkdir -p "$HOME/texmf/tex/latex/"
create_home_symlink tex/latex/* texmf/tex/latex/
# Only symlinking the files and not the full directory prevents any clutter from locally installed packages.

# tmux setup
# TPM setup
if [ ! -e "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

create_home_symlink tmux/tmux.conf .tmux.conf

# Taken from https://github.com/samoshkin/tmux-config/blob/master/install.sh
tmux new -d -s __noop >/dev/null 2>&1 || true 
tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "~/.tmux/plugins"
"$HOME"/.tmux/plugins/tpm/bin/install_plugins || true
tmux kill-session -t __noop >/dev/null 2>&1 || true

# If dev isn't already in home, add a symlink
if [ ! -d "$HOME"/dev ]; then
  create_home_symlink /../../dev/ .
fi
