# Absolute path of root of dotfiles
DOTFILES_ROOT=$(cd "$(dirname "$0")"; pwd -P)

Echo $SCRIPT
echo $DOTFILES_ROOT 

create_home_symlink() {
	SRC=$DOTFILES_ROOT/$1
	TARGET=$HOME/$2

	ln -si $SRC $TARGET
}

# Create links in home
for dir in "zsh" "formatting" "tmux"; do
	for f in $(ls -a $DOTFILES_ROOT/$dir); do
		create_home_symlink $dir/$f .
	done
done

# These files are placed in other hidden directories in home
for dir in "julia"; do
	for f in $(ls -a $DOTFILES_ROOT/$dir); do
		create_home_symlink $dir/$f .$dir/
	done
done

# Make .config dir if it doesn't already exist
mkdir -p "$HOME/.config"

# Create links in ~/.config/dir
# TODO: Move more files to .config, will reduce repetition in this file.
for dir in "git" "tmuxinator" "nvim" "alacritty"; do
	create_home_symlink config/$dir .config/
done

# VSCode setup
mkdir -p "$HOME"/.config/Code/User/
create_home_symlink config/vscode/settings.json .config/Code/User

# TODO: TeX style files
# create_home_symlink tex .miktex/texmfs/install/lb/te

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
