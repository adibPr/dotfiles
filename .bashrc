#!/bin/bash

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias ls='ls --color=auto'
alias ll='ls -al'

# export PS1="\[\e[00;37m\]\u : \[\e[0m\]"
arrow=$'\u00BB'
color="\[$(tput setaf 6)\]"
color2="\[$(tput setaf 5)\]"
__git_branch='`git branch 2> /dev/null | grep -e ^*| sed -e "s/\(^\*\ \)\(.*\)/\|\2\| /g"`'
# PS1=$color" \u \[$(tput sgr0)\]\[$(tput setaf 5)\]"$arrow"\[$(tput sgr0)\] "
PS1=$color" \u \[$(tput sgr0)\]\[$(tput setaf 3)\]"${__git_branch}""$color2$arrow"\[$(tput sgr0)\] "
export PS1
alias tmux=TERM='xterm-256color tmux'

# removing command-not-found annoying message
unset command_not_found_handle

# to disable auto completion
shopt -u progcomp 

# call env.sh
source ~/env.sh

# autocutsel to automatically sync primary and secondary buffer
autocutsel &
autocutsel -s PRIMARY &
