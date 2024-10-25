# {{{ history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt SHARE_HISTORY
setopt HIST_VERIFY
setopt HIST_IGNORE_DUPS
setopt NO_HIST_IGNORE_ALL_DUPS
# End history }}}
# {{{ completion
autoload -Uz compinit
compinit -u

zstyle :compinstall filename '/Users/aru/.zshrc'

# Make completion:
# - Try exact (case-sensitive) match first.
# - Then fall back to case-insensitive.
# - Accept abbreviations after . or _ or - (ie. f.b -> foo.bar).
# - Substring complete (ie. bar -> foobar).
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}' '+m:{_-}={-_}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# end completion}}}
# {{{ options
setopt autocd
unsetopt beep

cdpath=($HOME)
[[ -d "$HOME/code" ]] && cdpath+=("$HOME/code")
[[ -d "$HOME/phd" ]] && cdpath+=("$HOME/phd")
[[ -d "$HOME/Documents/phd" ]] && cdpath+=("$HOME/Documents/phd")
# End options}}}
# {{{ keybindings
bindkey -e
# End keybindings }}}
# {{{ prompt
autoload -Uz promptinit
promptinit
autoload -U colors
colors

prompt walters
# End prompt }}}
# {{{ exports
export PAGER=less
export MANPAGER=$PAGER

if (( $+commands[nvim] ))
then
  export EDITOR=nvim
  alias vim=nvim
else
  export EDITOR=vim
fi

if (( $+commands[code] ))
then
  export VISUAL="code --reuse-window"
fi

# filename (if known), line number if known, falling back to percent if known,
# falling back to byte offset, falling back to dash
export LESSPROMPT='?f%f .?ltLine %lt:?pt%pt\%:?btByte %bt:-...'

# i: search case insensitive
# M: show detailed prompt
# F: exit if output fits on one screen
# R: ansi color support
# X: suppress alternate screen
export LESS=iFMRX

# color in ls output without -G, works across shells
export CLICOLOR=true
export LC_ALL=en_GB.UTF-8
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_BIN="$HOME/.local/bin"

export RIPGREP_CONFIG_PATH="$HOME/.rgrc"

# color man pages.
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;208m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;111m'
# End exports }}}
# {{{ alias
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias ls="ls -FA --color"
alias ll="ls -FAlh --color"
alias ln="ln -v"
alias mkdir="mkdir -p"
if (( $+commands[emacs] )); then
  alias e="emacsclient -nw --alternate-editor '' --quiet"
  alias E="emacsclient --alternate-editor ''  --no-wait --quiet --create-frame"
fi
alias grep='grep --ignore-case --line-number --extended-regexp --color'
alias rgrep='grep --ignore-case --line-number --extended-regexp --color --exclude-dir ".git" --recursive'
alias rsync='rsync -azvhP'

alias -s pdf='open -a "PDF Expert.app"'
alias -s html='open -a "Firefox.app"'
alias -s md='glow --pager --width 70'

if [[ "$TERM" =~ 'kitty' ]]; then
  alias ssh='kitty +kitten ssh'
fi

if (( $+commands[docker] ))
then
  alias drun='docker run -it --rm --v "$(pwd):/app"'
fi
# End alias }}}
# {{{ path
paths=(
  "$HOME/.emacs.d/bin"
  "/opt/homebrew/opt/coreutils/libexec/gnubin"
  "$HOME/dotfiles/bin"
)

for p in $paths; do
  [[ -d $p ]] && path=($p $path)
done

# End path }}}
# plugins {{{

# NOTE: must come before zsh-history-substring-search & zsh-syntax-highlighting.
autoload -U select-word-style
select-word-style bash # only alphanumeric chars are considered WORDCHARS

bindkey ' ' magic-space # do history expansion on space

# Replace standard history-incremental-search-{backward,forward} bindings.
# These are the same but permit patterns (eg. a*b) to be used.
bindkey "^r" history-incremental-pattern-search-backward
bindkey "^s" history-incremental-pattern-search-forward

# Mac-like wordwise movement (Opt/Super plus left/right) in Kitty.
bindkey "^[[1;3C" forward-word # For macOS.
bindkey "^[[1;3D" backward-word # For macOS.
bindkey "^[[1;5C" forward-word # For Arch.
bindkey "^[[1;5D" backward-word # For Arch.

if (( $+commands[fzf] ))
then
  source <(fzf --zsh)
  if (( $+commands[fd] )); then
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

if (( $+commands[conda] ))
then
  eval "$(conda "shell.$(basename "${SHELL}")" hook)"
fi
# End plugins}}}

[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"
# vim: foldmethod=marker ts=2 sw=2 et
