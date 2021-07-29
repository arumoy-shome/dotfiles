# Unix
alias ls="ls -FA --color"
alias ll="ls -FAlh --color"
alias ln="ln -v"
alias mkdir="mkdir -p"
alias v="$EDITOR" #nvim when available else vim (see $ZDOTDIR/exports)
alias help=run-help
alias e="emacsclient -nq"       # --no-wait --quiet
alias E="emacsclient -nqc"      # --no-wait --quiet --create-frame

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# Brew
if (( $+commands[brew] )); then
  alias b="brew"
  alias bc="brew cask"
fi

#
# Suffix aliases
#

alias -s md='open -a "iA Writer.app"'
alias -s pdf='open -a "PDF Expert.app"'
alias -s html='open -a "Google Chrome.app"'
