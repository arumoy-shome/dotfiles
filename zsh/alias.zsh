# vim: foldmethod=marker

# Unix {{{
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias ls="ls -FA"
alias ll="ls -FAlrh"
alias ln="ln -v"
alias mkdir="mkdir -p"
alias v="$EDITOR" # nvim when available else vim (see $ZDOTDIR/exports)
alias help=run-help
if (( $+commands[emacs] )); then
  alias e="emacsclient -anq"       # --alternate-editor --no-wait --quiet
  alias E="emacsclient -anqc"      # --alternate-editor --no-wait --quiet --create-frame
fi
alias path='echo $PATH | tr -s ":" "\n"' # Pretty print the path
alias grep='grep -inE --color' # --case-insensitive --line-number --extended-regexp
alias rgrep='grep -inE --color --exclude-dir ".git" -R' # --recursive
# End Unix }}}

# Brew {{{
if (( $+commands[brew] )); then
  alias b="brew"
  alias bc="brew cask"
fi
# End Brew }}}

# Suffix {{{
alias -s pdf='open -a "PDF Expert.app"'
alias -s html='open -a "Firefox.app"'
# End Suffix }}}

# Python {{{
alias python='python3'
alias py='python3'
alias pip='pip3'
# End Python}}}
