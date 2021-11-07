# vim: foldmethod=marker

# Unix {{{
if (( $+commands[exa] )); then
  alias ls="exa -Fa --group-directories-first" # --classify --all
  alias ll="exa -Falrh --group-directories-first" # --classify --all --list --reverse --header
fi
alias ln="ln -v"
alias mkdir="mkdir -p"
alias v="$EDITOR" #nvim when available else vim (see $ZDOTDIR/exports)
alias help=run-help
alias e="emacsclient -nq"       # --no-wait --quiet
alias E="emacsclient -nqc"      # --no-wait --quiet --create-frame
alias path='echo $PATH | tr -s ":" "\n"' # Pretty print the path
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
