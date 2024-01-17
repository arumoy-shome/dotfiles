#  settings {{{
HISTCONTROL=ignoreboth # no duplicates or lines starting with space in history
HISTSIZE=1000
HISTFILESIZE=2000
CDPATH="$HOME"
[[ -d "$HOME/code" ]] && CDPATH+=":$HOME/code"
[[ -d "$HOME/phd" ]] && CDPATH+=":$HOME/phd"

shopt -s histappend   # append to history file, don't overwrite it.
shopt -s checkwinsize # [default] check window size after each command
shopt -s autocd       # .. for cd ..
shopt -s cdspell      # check minor file spell errors
shopt -s dirspell     # check minor dir spell errors
shopt -s direxpand
# }}}

#  exports {{{
export PAGER=less
export MANPAGER=$PAGER
export EDITOR=vim
export LC_ALL=en_GB.UTF-8
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_BIN="$HOME/.local/bin"

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
export RIPGREP_CONFIG_PATH="$HOME/.rgrc"
# }}}

#  alias {{{

# safer defaults for cp, mv and rm
# verbose output and ask for confirmation if existing file is affected
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias ln='ln -v'
alias mkdir='mkdir -p'

# F: append '/' after directory and '*' after executables
# A: do not list '.' and '..'
# h: with `l`, use unit siffixes for file size
# T: with `l`, display complete time info
# l: list format
alias ls='ls -FA'
alias ll='ls -FAlhT'
# }}}

# path {{{
paths=("$HOME/dotfiles/bin")
paths+=("$HOME/.cargo/bin")

for p in "${paths[@]}"; do
  [[ -d "$p" ]] && PATH+=":$p"
done
# }}}

if [[ "$TERM" =~ 'dumb' ]]; then
    source "$HOME/.bashrc.dumb"
else
    source "$HOME/.bashrc.xterm"
fi

# vim: foldmethod=marker
