# Absolute path of root of dotfiles
SCRIPT=$(readlink -f "$0")
DOTFILES_ROOT=$(dirname "$SCRIPT")/../..

create_home_symlink() {
  SRC=$DOTFILES_ROOT/$1
  TARGET=$HOME/$2

  ln -si $SRC $TARGET
}

# Create links in home
for dir in "bash" "system" "zsh" "formatting" "tmux"; do
	echo $(ls $DOTFILES_ROOT/$dir)
	for f in $(ls -a $DOTFILES_ROOT/$dir); do
		create_home_symlink $dir/$f .
	done
done

# Make .config dir if it doesn't already exist
mkdir -p "$HOME/.config"

# Create links in ~/.config/dir
# TODO: Move more files to .config, will reduce repetition in this file.
for dir in "git" "tmuxinator" "nvim" "alacritty" "ranger" "i3" "i3status"; do
    create_home_symlink config/$dir .config/
done

# VSCode setup
mkdir -p "$HOME"/.config/Code/User/
loop_dir_symlink config/vscode/ .config/Code/User/

# TODO: TeX style files

# TPM setup
if [ ! -e "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Taken from https://github.com/samoshkin/tmux-config/blob/master/install.sh
tmux new -d -s __noop >/dev/null 2>&1 || true
tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "~/.tmux/plugins"
"$HOME"/.tmux/plugins/tpm/bin/install_plugins || true
tmux kill-session -t __noop >/dev/null 2>&1 || true

# If dev isn't already in home, add a symlink
if [ ! -d "$HOME"/dev ]; then
  create_home_symlink /../../dev/ .
fi
