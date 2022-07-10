###  settings
HISTCONTROL=ignoreboth # no duplicates or lines starting with space in history
HISTSIZE=1000
HISTFILESIZE=2000
CDPATH="$HOME"
[[ -d "$HOME/code" ]] && CDPATH+=":$HOME/code"
[[ -d "$HOME/Documents" ]] && CDPATH+=":$HOME/Documents"

shopt -s histappend   # append to history file, don't overwrite it.
shopt -s checkwinsize # [default] check window size after each command
shopt -s autocd       # .. for cd ..
shopt -s cdspell      # check minor file spell errors
shopt -s dirspell     # check minor dir spell errors
shopt -s direxpand

###  exports
export PAGER=less
export MANPAGER=$PAGER
export EDITOR=vim
export CLICOLOR=true # color in ls output without -G, works across shells
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

###  alias

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
alias E="emacsclient --alternate-editor '' --no-wait --quiet --create-frame"

###  completions
if [[ -d /usr/local/etc/bash_completion.d ]]; then
  for completion in /usr/local/etc/bash_completion.d/*; do
      source "$completion"
  done
fi

###  prompt
GIT_PS1_SHOWDIRTYSTATE=true
PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'

### path
paths=("$HOME/dotfiles/bin")
paths+=("$HOME/.emacs.d/bin")
paths+=("$HOME/.cargo/bin")

for p in "${paths[@]}"; do
  [[ -d "$p" ]] && PATH+=":$p"
done

# wezterm shell integration
[[ -e "/Applications/WezTerm.app/Contents/Resources/wezterm.sh" ]] &&
    source "/Applications/WezTerm.app/Contents/Resources/wezterm.sh"

