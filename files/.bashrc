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

# export neovim as EDITOR when available, fall back to vim

if [[ -x "$(command -v nvim)" ]]; then
  export EDITOR=nvim
  alias vim=nvim
else
  export EDITOR=vim
fi

export PAGER=less
export MANPAGER=$PAGER
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

# Color man pages.
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;208m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;111m'
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
alias ls='ls -FA --color'
alias ll='ls -FAlh --color'
if [[ "$TERM" =~ 'kitty' ]]; then
  alias ssh='kitty +kitten ssh'
fi
# }}}

# path {{{
# append to path
paths=("$HOME/dotfiles/bin")
paths+=("$HOME/.cargo/bin")

for p in "${paths[@]}"; do
  [[ -d "$p" ]] && PATH+=":$p"
done

## prepend to path
PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
# }}}

if [[ "$TERM" =~ 'dumb' ]]; then
    source "$HOME/.bashrc.dumb"
else
    source "$HOME/.bashrc.xterm"
fi

# vim: foldmethod=marker
