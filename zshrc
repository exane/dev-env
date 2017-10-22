export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh

export TERM=xterm

unsetopt prompt_cr prompt_sp

[[ -f ~/.inputrc ]] && export INPUTRC=~/.inputrc

bindkey "5C" forward-word
bindkey "5D" backward-word

export PROMPT=$(whoami)" "$PROMPT

stty sane
stty erase ^H
