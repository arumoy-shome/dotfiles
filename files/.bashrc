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

if [[ -x  "$(command -v emacs)" ]]
then
    export VISUAL="emacsclient -c"
    export EDITOR="emacsclient -t"
fi

if [[ -x "$(command -v nvim)" ]]
then
  export EDITOR=nvim
  alias vim="nvim"
else
  export EDITOR=vim
fi

if [[ "$TERM" == "dumb-emacs-ansi" && "$INSIDE_EMACS" ]]
then
    PAGER="cat"
    alias less="cat"
    TERM=dumb-emacs-ansi
    COLORTERM=1
    EDITOR="emacsclient -a emacs -t r"
    VISUAL="emacsclient -a emacs -t r"
else
    export PAGER=less
    # filename (if known), line number if known, falling back to percent if known,
    # falling back to byte offset, falling back to dash
    export LESSPROMPT='?f%f .?ltLine %lt:?pt%pt\%:?btByte %bt:-...'

fi
export MANPAGER=$PAGER
export LC_ALL=en_GB.UTF-8
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_BIN="$HOME/.local/bin"

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

# simple prompt (stolen from protesilaos)
if [ -n "$SSH_CONNECTION" ]
then
    export PS1="\u@\h: \w \$ "
else
    export PS1="\w \$ "
fi
export PS2="> "

if [[ "$TERM" =~ 'xterm' ]]
then
  # Color man pages.
  export LESS_TERMCAP_mb=$'\E[01;31m'
  export LESS_TERMCAP_md=$'\E[01;38;5;208m'
  export LESS_TERMCAP_me=$'\E[0m'
  export LESS_TERMCAP_se=$'\E[0m'
  export LESS_TERMCAP_ue=$'\E[0m'
  export LESS_TERMCAP_us=$'\E[04;38;5;111m'

  # fzf
  if [[ -x "$(command -v fzf)" ]]; then

    eval "$(fzf --bash)"

    if [[ -x "$(command -v fd)" ]]; then
      export FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude '.git'"
      # following stolen from fzf README
      # Use fd instead of the default find command for listing path candidates.
      # - The first argument to the function ($1) is the base path to start traversal
      # - See the source code (completion.{bash,zsh}) for the details.
      _fzf_compgen_path() {
        fd --hidden --follow --exclude ".git" . "$1"
      }

      # Use fd to generate the list for directory completion
      _fzf_compgen_dir() {
        fd --type d --hidden --follow --exclude ".git" . "$1"
      }
    else
      export FZF_DEFAULT_COMMAND="find . -type f -not -path '*git*'"
    fi

    export FZF_COMPLETION_OPTS="--border --info=inline"
    export FZF_DEFAULT_OPTS="--reverse --height=~40% --no-scrollbar --color=gutter:-1"
  fi
fi

#vim: foldmethod=marker
