# .zshrc
#
# Main configuration for zsh.
#

#########################
# General configuration #
#########################

# Aliases
source "$ZDOTDIR/aliases.zsh"
source "$HOME/local_aliases.zsh"

# Enable vi mode
bindkey -v

# No globbing when calling pip
alias pip='noglob pip'

fpath+=$ZDOTDIR/.zsh_functions

PLUGINS_DIR=$ZDOTDIR/plugins

# Add homebrew to path
export PATH="/opt/homebrew/bin:$PATH"


###########
# Options #
###########

# History options
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY

HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history

# autocompletion using arrow keys (based on history)
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

# Tab completing a directory appends the name with a slash
setopt AUTOPARAMSLASH

# Enable substitution in the prompt
setopt PROMPT_SUBST

#########
# Hooks #
#########

autoload -Uz add-zsh-hook

# zoxide
eval "$(zoxide init zsh)"

# direnv
eval "$(direnv hook zsh)"

# Async VCS information
# TODO: Get this working
autoload -Uz vcs_info
_vbe_vcs_info() {
	cd -q $1
	vcs_info
	print ${vcs_info_msg_0_}
}

# Use the zsh-async plugin
# TODO: Move away from this eventually
source $PLUGINS_DIR/zsh-async/async.zsh
async_init
async_start_worker vcs_info
async_register_callback vcsinfo _vbe_vcs_info_done

_vbe_vcs_info_done() {
	local stdout=$3
	vcs_info_msg_0_=$stdout
	zle reset-prompt
}

# Schedule the wrapper in the worker queue before displaying the prompt
_vbe_vcs_precmd() {
	async_flush_jobs vcs_info
	async_job vcs_info _vbe_vcs_info $PWD
}

add-zsh-hook precmd vcs_info

##########
# Prompt #
##########

autoload -Uz _fill_line && _fill_line

# Show venv in prompt
# TODO: This is quite buggy
show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
	  echo "(%B%F{yellow} $(basename $VIRTUAL_ENV)%b%F{white})"
  fi
}

# Show git information in prompt
zstyle ':vcs_info:git:*' formats '%F{999}on %F{green} %B%b'
zstyle ':vcs_info:git:*' actionformats '%F{999}on %F{green} %B%b (%a%u%c)'

# Define the prompt itself
PROMPT=$'\n'$(_fill_line ' %F{yellow} %F{magenta}%B%~%b ${vcs_info_msg_0_}%b' ' $(show_virtual_env)')$'\n'' %F{cyan}%f%b '

###############
# Keymappings #
###############

# Search history, using whatever is already in the prompt, with the up and down keys
# TODO: Vi mode?
bindkey "\eOA" up-line-or-search
bindkey "\eOB" down-line-or-search

#################
# Other plugins #
#################

source $PLUGINS_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
chruby ruby-3.1.3 # run chruby to see actual version

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
