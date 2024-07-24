alias l="ls -a"

# Commonly used directories - assumes dev dir is in home
alias dev="cd $HOME/dev"
alias dbx="cd $HOME/Dropbox"

alias tmux='tmux -2'

# Commonly used commands
alias g="git"
alias n="nvim"
alias mux="tmuxinator"

# Create all required directories with mkdir
alias mkdir="mkdir -p"

# Python is Python3
alias python=python3

# Reload .zshrc
alias zshrc="source ~/.zshrc && source ~/.zshenv && source ~/aliases.zsh && source ~/local_aliases.zsh"
