# vim:filetype=zsh

export PAGER=less

#
# Editor
#

export EDITOR=$(which nvim)
export VISUAL=$EDITOR

# filename (if known), line number if known, falling back to percent if known,
# falling back to byte offset, falling back to dash
export LESSPROMPT='?f%f .?ltLine %lt:?pt%pt\%:?btByte %bt:-...'

# i = case-insensitive searches, unless uppercase characters in search string
# F = exit immediately if output fits on one screen
# M = verbose prompt
# R = ANSI color support
# S = chop long lines (rather than wrap them onto next line)
# X = suppress alternate screen
export LESS=iFMRSX

# Color man pages.
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;208m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;111m'

# colour ls listings
export CLICOLOR=true

export GPG_TTY=$(tty)

#
# Path
#

SYSTEM_PATH=$PATH
unset PATH

if [[ -d "/usr/local/opt/ruby@2.7/bin" ]]; then
  PATH="/usr/local/opt/ruby@2.7/bin"
fi
if [[ -d "/usr/local/lib/ruby/gems/2.7.0/bin" ]]; then
  PATH="$PATH:/usr/local/lib/ruby/gems/2.7.0/bin"
fi
if [[ -d "/usr/local/opt/python@3.8/libexec/bin" ]]; then
  PATH="$PATH:/usr/local/opt/python@3.8/libexec/bin"
fi
if [[ -d "/usr/local/opt/coreutils/libexec/gnubin" ]]; then
  PATH="$PATH:/usr/local/opt/coreutils/libexec/gnubin"
fi
PATH="$PATH:$SYSTEM_PATH"
export PATH
