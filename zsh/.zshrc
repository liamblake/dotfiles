# Add bin to path
path+=("$HOME/dev/dotfiles/bin")
path+=("$HOME/.local/bin")
path+=("$HOME/.cargo/bin")

export PATH
# Aliases - use bash aliases
source "$HOME/.bash_aliases"

# No globbing when calling pip
alias pip='noglob pip'

#
# oh-my-zsh config
#

export ZSH=$HOME/.oh-my-zsh

# Prompt
show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}

source ~/dev/dotfiles/bin/.git-prompt.sh
eval "$(direnv hook zsh)"

setopt PROMPT_SUBST ; PS1='%F{123}$(show_virtual_env) %F{171}%B%~ %F{041}$(__git_ps1 "(%s)")%F{123}> %f%b'

# zoxide
eval "$(zoxide init zsh)"

source $ZSH/oh-my-zsh.sh

# Plugins
plugins=(zsh-syntax-highlighting)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
