# Unix
alias l="ls -F"
alias ll="ls -laF"
alias ln="ln -v"
alias mkdir="mkdir -p"
alias v="$EDITOR" #nvim when available else vim (see $ZDOTDIR/exports)
alias help=run-help

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# Python
(( $+commands[python3] )) && alias py="python3"

# Brew
if (( $+commands[brew] )); then
  alias b="brew"
  alias bc="brew cask"
fi

# nvim
(( $+commands[nvim] )) && alias vim="nvim" # use \vim or command vim to get real vim

#
# Suffix aliases
#

# "foo.md" to open Markdown files in "Marked 2.app"
alias -s md='open -a "Marked 2.app"'