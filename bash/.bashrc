# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# enable programmable completion features
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Use tab to cycle through options
bind TAB:menu-complete

# direnv setup
# Python venv fix
show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    echo "($(basename $VIRTUAL_ENV))"
  fi
}
export -f show_virtual_env

eval "$(direnv hook bash)"

# Add bin to path
export PATH="$(pwd)/bin:$PATH"

# Set PS1, dependent on whether the shell has colour support.
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
  # We have color support; assume it's compliant with Ecma-48
  # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
  # a case would tend to support setf rather than setaf.)
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]$(show_virtual_env) \[\033[01;34m\]\w\[\033[01;35m\]$(__git_ps1 " (%s)")\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}$(show_virtual_env) \w(__git_ps1 " (%s)")\$ '
fi

# Aliases
. ~/.bash_aliases

# Local configuration - overwrites any conflicts here
if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi

# Env vars
export EDITOR="code"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
