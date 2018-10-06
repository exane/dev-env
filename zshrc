# vi:set ft=sh :
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
plugins=(git)
eval "$(ssh-agent -s)" > /dev/null

source $ZSH/oh-my-zsh.sh

export TERM=xterm
export SHELL=zsh

unsetopt prompt_cr prompt_sp

[[ -f ~/.inputrc ]] && export INPUTRC=~/.inputrc

bindkey "5C" forward-word
bindkey "5D" backward-word

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

export PROMPT=$(whoami)" "$(env | sed -En "s/^PORT_(.*)=.*/\1/p" | xargs echo)" "$PROMPT

stty sane
stty erase ^H

mkdir -p /store/zsh/

# vim hack to make vim color scheme usable in docker.
# TERM=linux has to be set for vim (does not work if set in vimrc).
# If set globally it fucks zsh and everything else.
# So this wrapper it is.
export EDITOR="TERM=linux vim"
export VISUAL="$EDITOR"
alias vim="sudo $EDITOR"
git config --global --replace-all core.editor "$EDITOR"
