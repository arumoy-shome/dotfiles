# vim:filetype=zsh

export PAGER=less

#
# Editor
#

if (( $+commands[nvim] )); then
  export EDITOR=$(which nvim)
else
  export EDITOR=$(which vim)
fi
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

# for the benefit of CPAN and potentially others
export FTP_PASSIVE=1

# colour ls listings
export CLICOLOR=true

export GPG_TTY=$(tty)

# See: https://docs.brew.sh/Analytics
export HOMEBREW_NO_ANALYTICS=1

