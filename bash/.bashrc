##############
#  settings  #
##############
# no duplicates or lines starting with space in history
HISTCONTROL=ignoreboth

# append to history file, don't overwrite it.
shopt -s histappend

HISTSIZE=1000
HISTFILESIZE=2000

# check window size after each command and lazy update LINES and COLUMNS
shopt -s checkwinsize

#############
#  exports  #
#############
export PAGER=less
export MANPAGER=$PAGER
export EDITOR=vim

# filename (if known), line number if known, falling back to percent if known,
# falling back to byte offset, falling back to dash
export LESSPROMPT='?f%f .?ltLine %lt:?pt%pt\%:?btByte %bt:-...'

# i: search case insensitive
# M: show detailed prompt
# F: exit if output fits on one screen
# R: ansi color support
# X: suppress alternate screen
export LESS=iFM

# colour ls listings, do not have to use -G flag
# and works across shells
export CLICOLOR=true

###########
#  alias  #
###########
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# safer defaults for cp, mv and rm
# verbose output and ask for confirmation if existing file is affected
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -Iv'

# G: enable colored output
# F: append '/' after directory and '*' after executables
# A: do not list '.' and '..'
# @: with `l`, display extended attribute keys and size
# h: with `l`, use unit siffixes for file size
# T: with `l`, display complete time info
alias ls='ls -FA'
alias ll='ls -FAl@hT'

# E: use extended regex
# i: case insensitive
# n: show line number
alias grep='grep -inE --color=auto'

#################
#  completions  #
#################
[[ -r /usr/local/etc/bash_completion.d/git-completion.bash ]] && \
    source /usr/local/etc/bash_completion.d/git-completion.bash

[[ -r /usr/local/etc/bash_completion.d/git-prompt.sh ]] && \
    source /usr/local/etc/bash_completion.d/git-prompt.sh

############
#  prompt  #
############
GIT_PS1_SHOWDIRTYSTATE=true
PS1='\[\033[36m\][\w$(__git_ps1 " (%s)")] \$ \[\033[00m\]'

###############
#  functions  #
###############

# Colourise man pages
man() {
  env \
  LESS_TERMCAP_mb=$(tput bold; tput setaf 6) \
  LESS_TERMCAP_md=$(tput bold; tput setaf 6) \
  LESS_TERMCAP_me=$(tput sgr0) \
  LESS_TERMCAP_se=$(tput rmso; tput sgr0) \
  LESS_TERMCAP_ue=$(tput rmul; tput sgr0) \
  LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 4) \
  LESS_TERMCAP_mr=$(tput rev) \
  LESS_TERMCAP_mh=$(tput dim) \
  LESS_TERMCAP_ZN=$(tput ssubm) \
  LESS_TERMCAP_ZV=$(tput rsubm) \
  LESS_TERMCAP_ZO=$(tput ssupm) \
  LESS_TERMCAP_ZW=$(tput rsupm) \
  man "$@"
}

# Enter directory and list contents
cd() {
  if [ -n "$1" ]; then
    builtin cd "$@" && ls -FA
  else
    builtin cd ~ && ls -FA
  fi
}
