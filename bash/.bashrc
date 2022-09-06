function add_to_path() {
    if [ -d "$1" ]; then
        export PATH="$1:$PATH"
    fi
}

add_to_path "$HOME/dev/dotfiles/bin"
add_to_path "$HOME/.local/bin"
add_to_path "$HOME/.cargo/bin"
add_to_path "$HOME/bin"
. "$HOME/.cargo/env"
