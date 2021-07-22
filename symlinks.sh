# Make .config dir if it doesn't already exist
mkdir -p "$HOME/.config"

# Create links in .config/dir
for dir in "git" "terminator"; do
    ln -si $(pwd)/config/$dir "$HOME"/.config/
done

### The following symlinks behave differently ###
# Bash configs
for dir in ".bash_aliases" ".bashrc"; do
    ln -si $(pwd)/bash/$dir "$HOME"/
done

# .inputrc
ln -si $(pwd)/config/system/.inputrc "$HOME"/

# VSCode setup
mkdir -p "$HOME"/.config/Code/User/
ln -si $(pwd)/config/vscode/settings.json "$HOME"/.config/Code/User/

# TeX style files
mkdir -p "$HOME/texmf/tex/latex/"
ln -si $(pwd)/tex/latex/* "$HOME/texmf/tex/latex/"
# Only symlinking the files and not the full directory prevents any clutter from locally installed packages.

# Jupyter config
ln -si $(pwd)/config/.jupyter/jupyter_notebook_config.py "$HOME/.jupyter/"

# Install .fzf
source $(pwd)/ext/fzf/install --completion --key-bindings --all

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