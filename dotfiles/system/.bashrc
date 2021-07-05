# direnv setup
# Python venv fix
show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}
export -f show_virtual_env
PS1='$(show_virtual_env)'$PS1

eval "$(direnv hook bash)"


# Aliases
alias venv="source venv/bin/activate"
alias codehere="code -n ."

# Commonly used directories - assumes dev dir is in home
alias dev="cd $HOME/dev"
alias dotfiles="cd $HOME/dev/useful/dotfiles"
alias dbr="cd $HOME/Dropbox"
alias uni="cd $HOME/Dropbox/university"

alias mail="thunderbird"