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

# for java
STUDIO_JDK=/home/adib/sys_local/standalone/jdk1.8.0_102
export STUDIO_JDK
JAVA_HOME=/home/adib/sys_local
export JAVA_HOME

SCALA_HOME=/home/adib/sys_local/standalone/scala-2.12.0
export SCALA_HOME

SPARK_HOME=/media/Linux/sys_local/standalone/spark-2.2.0-bin-hadoop2.7
export SPARK_HOME

PATH=$PATH:/home/adib/sys_local/bin
export PATH

# for python disable write byte code
PYTHONDONTWRITEBYTECODE=1
export PYTHONDONTWRITEBYTECODE

# for python library 
PYTHONPATH=$PYTHONPATH:/media/D/work
export PYTHONPATH

