create_home_symlink() {
	SRC=$(pwd)/$1
	TARGET=$HOME/$2

	ln -si $SRC $TARGET
}

# Make .config dir if it doesn't already exist
mkdir -p "$HOME/.config"

# Create links in ~/.config/dir
for dir in "git" "tmuxinator" "nvim" "alacritty" "rstudio" "zsh" "tmux"; do
	create_home_symlink config/$dir .config/
done

# VSCode setup
mkdir -p "$HOME"/.config/Code/User/
create_home_symlink config/vscode/settings.json .config/Code/User

# TeX style files - this will only work on MacOS
mkdir -p "$HOME/Library/texmf/tex/latex"
create_home_symlink tex/latex/lb.sty Library/texmf/tex/latex
create_home_symlink tex/latex/lb_style.sty Library/texmf/tex/latex

# Julia config
create_home_symlink julia/config .julia/config

# TPM setup
if [ ! -e "$HOME/.tmux/plugins/tpm" ]; then
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Taken from https://github.com/samoshkin/tmux-config/blob/master/install.sh
tmux new -d -s __noop >/dev/null 2>&1 || true
tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "~/.tmux/plugins"
"$HOME"/.tmux/plugins/tpm/bin/install_plugins || true
tmux kill-session -t __noop >/dev/null 2>&1 || true
