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
if type nvim > /dev/null; then
  export EDITOR=nvim
else
  export EDITOR=vim
fi

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

# safer defaults for cp, mv and rm
# verbose output and ask for confirmation if existing file is affected
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'

# G: enable colored output
# F: append '/' after directory and '*' after executables
# A: do not list '.' and '..'
# @: with `l`, display extended attribute keys and size
# h: with `l`, use unit siffixes for file size
# T: with `l`, display complete time info
alias ls='ls -FA'
alias ll='ls -FAlhT'

#################
#  completions  #
#################
if [[ -d /usr/local/etc/bash_completion.d ]]; then
  for completion in /usr/local/etc/bash_completion.d/*; do
    source completion
  done
fi

############
#  prompt  #
############
GIT_PS1_SHOWDIRTYSTATE=true
PS1='\[\033[37m\][\j \w$(__git_ps1 " (%s)")] \$ \[\033[00m\]'

