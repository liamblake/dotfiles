create_home_symlink() {
  SRC=$1
  TARGET=$2
  ln -si $SRC $TARGET
}

# Symlink to dotfiles in home for easy access
ln -s $(pwd)/. "$HOME"/dotfiles

# Make .config dir if it doesn't already exist
mkdir -p "$HOME/.config"

# Create links in .config/dir
for dir in "git" "tmuxinator"; do
    ln -si $(pwd)/config/$dir "$HOME"/.config/
done

### The following symlinks behave differently ###
# Bash configs
for dir in ".bash_aliases" ".bashrc"; do
    ln -si $(pwd)/bash/$dir "$HOME"/
done

# .inputrc
ln -si $(pwd)/config/system/.inputrc "$HOME"/

# zsh
ln -si $(pwd)/config/zsh/.zshrc "$HOME"/
# Dracula theme
ln -si $(pwd)/ext/zsh-dracula/dracula.zsh-theme "$HOME"/.oh-my-zsh/themes/dracula.zsh-theme

# VSCode setup
mkdir -p "$HOME"/.config/Code/User/
ln -si $(pwd)/config/vscode/settings.json "$HOME"/.config/Code/User/

# TeX style files
mkdir -p "$HOME/texmf/tex/latex/"
ln -si $(pwd)/tex/latex/* "$HOME/texmf/tex/latex/"
# Only symlinking the files and not the full directory prevents any clutter from locally installed packages.

# tmux setup
# TPM setup
if [ ! -e "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi


ln -si $(pwd)/tmux/tmux.conf "$HOME"/.tmux.conf

# Taken from https://github.com/samoshkin/tmux-config/blob/master/install.sh
tmux new -d -s __noop >/dev/null 2>&1 || true 
tmux set-environment -g TMUX_PLUGIN_MANAGER_PATH "~/.tmux/plugins"
"$HOME"/.tmux/plugins/tpm/bin/install_plugins || true
tmux kill-session -t __noop >/dev/null 2>&1 || true

# Install .fzf
source $(pwd)/ext/fzf/install --completion --key-bindings --all
