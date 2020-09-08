##############
#  settings  #
##############
HISTCONTROL=ignoreboth # no duplicates or lines starting with space in history
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s histappend   # append to history file, don't overwrite it.
shopt -s checkwinsize # [default] check window size after each command
shopt -s autocd       # .. for cd ..
shopt -s cdspell      # check minor file spell errors
shopt -s dirspell     # check minor dir spell errors
shopt -s direxpand

#############
#  exports  #
#############
export PAGER=less
export MANPAGER=$PAGER
export EDITOR=vim
[[ -d $HOME/Documents/notes ]] && \
  export NOTESDIR="$HOME/Documents/notes"
[[ -r $NOTESDIR/slipbox.md ]] && \
  export SLIPBOX="$NOTESDIR/slipbox.md"

# filename (if known), line number if known, falling back to percent if known,
# falling back to byte offset, falling back to dash
export LESSPROMPT='?f%f .?ltLine %lt:?pt%pt\%:?btByte %bt:-...'

# i: search case insensitive
# M: show detailed prompt
# F: exit if output fits on one screen
# R: ansi color support
# X: suppress alternate screen
export LESS=iFMRX

# colour ls listings, do not have to use -G flag
# and works across shells
export CLICOLOR=true

###########
#  alias  #
###########

###########
#  path  #
###########
export PATH="/usr/local/opt/python@3.8/libexec/bin:$PATH"

# safer defaults for cp, mv and rm
# verbose output and ask for confirmation if existing file is affected
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'

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

alias b='brew'
alias bc='brew cask'

alias jp='jupyter'

alias g='git'

#################
#  completions  #
#################
[[ -r /usr/local/etc/bash_completion.d/git-completion.bash ]] && \
    source /usr/local/etc/bash_completion.d/git-completion.bash

[[ -r /usr/local/etc/bash_completion.d/git-prompt.sh ]] && \
    source /usr/local/etc/bash_completion.d/git-prompt.sh

[[ -r /usr/local/etc/bash_completion.d/tmux ]] && \
    source /usr/local/etc/bash_completion.d/tmux

[[ -r /usr/local/etc/bash_completion.d/brew ]] && \
    source /usr/local/etc/bash_completion.d/brew

[[ -r /usr/local/etc/bash_completion.d/brew-service ]] && \
    source /usr/local/etc/bash_completion.d/brew-service

############
#  prompt  #
############
GIT_PS1_SHOWDIRTYSTATE=true
PS1='\[\033[37m\][\j \w$(__git_ps1 " (%s)")] \$ \[\033[00m\]'

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

z() {
  if [[ -r $NOTESDIR/inbox.md ]]; then
    $EDITOR $NOTESDIR/inbox.md
  fi
}
