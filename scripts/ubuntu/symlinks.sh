# Absolute path of root of dotfiles
SCRIPT=$(readlink -f "$0")
DOTFILES_ROOT=$(dirname "$SCRIPT")/../..
echo $DOTFILES_ROOT

create_home_symlink() {
  SRC=$1
  TARGET=$2
  ln -si $DOTFILES_ROOT/$SRC $HOME/$TARGET
}

loop_dir_symlink() {
  DIR=$1
  TARGET=$2
  for f in $(ls $DOTFILES_ROOT/$DIR); do
    create_home_symlink $DIR/$f $TARGET
  done
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
loop_dir_symlink bash/ .

# .inputrc
create_home_symlink config/system/.inputrc .

# zsh
create_home_symlink zsh/.zshrc .
create_home_symlink zsh/.zshenv .

# Link plugins to oh-my-zsh dir
mkdir -p "$HOME"/.config/zsg/plugins
loop_dir_symlink zsh/plugins/ .oh-my-zsh/plugins/

# VSCode setup
mkdir -p "$HOME"/.config/Code/User/
loop_dir_symlink config/vscode/ .config/Code/User/

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
