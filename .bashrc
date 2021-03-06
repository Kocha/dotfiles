# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias l.='ls -d .*'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# ===============================================
# User define
# http://www.cyberciti.biz/tips/bash-aliases-mac-centos-linux-unix.html

# ----------------------------------------------
# System
PS1='[\u@\! \w]\$> '
# PS1='[\u@\!]\$> '

# -----------------------------------------------
# diff = colordiff
alias diff='colordiff'

# -----------------------------------------------
# Alias
alias sl=ls
alias h=history

# -----------------------------------------------
# ModelSim Setup
# MODELSIM_HOME=/home/kocha/tools/modelsim/11.1sp1/modelsim_ase
MODELSIM_HOME=/home/kocha/tools/modelsim/12.0/modelsim_ase
PATH="$PATH":$MODELSIM_HOME/bin

MTI_HOME=/home/kocha/tools/modelsim/12.0/modelsim_ase
export MODELSIM_HOME
export MTI_HOME
# -----------------------------------------------
# SystemC Setup
# SYSTEMC_HOME=/home/kocha/library/systemc/systemc-2.3.0_pub_rev_20111121
SYSTEMC_HOME=/usr/local/lib/systemc-2.2.0
SYSTEMC_AMS_HOME=/home/kocha/library/systemc-ams/systemc-ams-1.0Beta2
TARGET_ARCH=linux
export SYSTEMC_HOME
export SYSTEMC_AMS_HOME
export TARGET_ARCH
# -----------------------------------------------
# TLM Setup
TLM_HOME=/home/kocha/library/TLM/TLM-2009-07-15
export TLM_HOME

# -----------------------------------------------
# UVM Setup
# UVM_HOME=/home/kocha/shared/uvm/uvm-1.0p1
# UVM_HOME=/home/kocha/shared/uvm/uvm-1.1a
UVM_HOME=/home/kocha/shared/uvm/uvm-1.1b
UVMC_HOME=/home/kocha/shared/uvm/uvmc-2.1.4

export UVM_HOME
export UVMC_HOME

# -----------------------------------------------
# CodeSourcery Setup
export CROSS_COMPILE=arm-xilinx-linux-gnueabi-
export PATH=~/CodeSourcery/Sourcery_CodeBench_Lite_for_Xilinx_GNU_Linux/bin:$PATH

