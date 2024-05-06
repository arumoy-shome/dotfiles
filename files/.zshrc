
# Create a hash table for globally stashing variables without polluting main
# scope with a bunch of identifiers.
typeset -A __WINCENT

__WINCENT[ITALIC_ON]=$'\e[3m'
__WINCENT[ITALIC_OFF]=$'\e[23m'

# {{{ history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt SHARE_HISTORY
setopt HIST_VERIFY
setopt HIST_IGNORE_DUPS
setopt NO_HIST_IGNORE_ALL_DUPS

# End history }}}
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

# Colorize completions using default `ls` colors.
zstyle ':completion:*' list-colors ''

# Allow completion of ..<Tab> to ../ and beyond.
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(..) ]] && reply=(..)'

# $CDPATH is overpowered (can allow us to jump to 100s of directories) so tends
# to dominate completion; exclude path-directories from the tag-order so that
# they will only be used as a fallback if no completions are found.
zstyle ':completion:*:complete:(cd|pushd):*' tag-order 'local-directories named-directories'

# Categorize completion suggestions with headings:
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %F{default}%B%{$__WINCENT[ITALIC_ON]%}--- %d ---%{$__WINCENT[ITALIC_OFF]%}%b%f

# Enable keyboard navigation of completions in menu
# (not just tab/shift-tab but cursor keys as well):
zstyle ':completion:*' menu select
# End completion }}}
# {{{ prompt
autoload -Uz promptinit
promptinit
# autoload -U colors
# colors
# use the original pure prompt; much faster than starship's implementation
prompt pure

# prompt walters
# End prompt }}}
# {{{ exports
export PAGER=less
export MANPAGER=$PAGER

if (( $+commands[nvim] )); then
  export EDITOR=nvim
  alias vim=nvim
else
  export EDITOR=vim
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
# End alias }}}
# {{{ path
paths=(
  "$HOME/.emacs.d/bin"
  "/usr/local/opt/coreutils/libexec/gnubin"
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

# zsh-syntax-highlighting
# NOTE must be the last plugin installed
# NOTE make sure to install using brew prior to sourcing
# NOTE zsh-history-substring should be the last plugin
# <https://github.com/zsh-users/zsh-history-substring-search#usage>

plugins=(
  "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  "$(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
)


for plugin in $plugins; do
  [[ -e $plugin ]] && source $plugin
done

# For speed:
# https://github.com/zsh-users/zsh-autosuggestions#disabling-automatic-widget-re-binding
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)

# Note that this will only ensure unique history if we supply a prefix
# before hitting "up" (ie. we perform a "search"). HIST_FIND_NO_DUPS
# won't prevent dupes from appearing when just hitting "up" without a
# prefix (ie. that's "zle up-line-or-history" and not classified as a
# "search"). So, we have HIST_IGNORE_DUPS to make life bearable for that
# case.
#
# https://superuser.com/a/1494647/322531
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

# Use "cbt" capability ("back_tab", as per `man terminfo`), if we have it:
if tput cbt &> /dev/null; then
  bindkey "$(tput cbt)" reverse-menu-complete # make Shift-tab go to previous completion
fi

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^x' edit-command-line

bindkey ' ' magic-space # do history expansion on space

# Replace standard history-incremental-search-{backward,forward} bindings.
# These are the same but permit patterns (eg. a*b) to be used.
bindkey "^r" history-incremental-pattern-search-backward
bindkey "^s" history-incremental-pattern-search-forward

# Make CTRL-Z background things and unbackground them.
function fg-bg() {
  if [[ $#BUFFER -eq 0 ]]; then
    fg
  else
    zle push-input
  fi
}
zle -N fg-bg
bindkey '^Z' fg-bg

# Mac-like wordwise movement (Opt/Super plus left/right) in Kitty.
bindkey "^[[1;3C" forward-word # For macOS.
bindkey "^[[1;3D" backward-word # For macOS.
bindkey "^[[1;5C" forward-word # For Arch.
bindkey "^[[1;5D" backward-word # For Arch.


# if [[ -x "$(command -v fzf)" ]]; then

  # uncomment to enable default keybindings
  # [[ -f "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"

  # if [[ -x "$(command -v fd)" ]]; then
  #   export FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude '.git'"
    # following stolen from fzf README
    # Use fd instead of the default find command for listing path candidates.
    # - The first argument to the function ($1) is the base path to start traversal
    # - See the source code (completion.{bash,zsh}) for the details.
    # _fzf_compgen_path() {
    #   fd --hidden --follow --exclude ".git" . "$1"
    # }

    # Use fd to generate the list for directory completion
    # _fzf_compgen_dir() {
    #   fd --type d --hidden --follow --exclude ".git" . "$1"
    # }
  # else
    # export FZF_DEFAULT_COMMAND="find . -type f -not -path '*git*'"
  # fi

  # export FZF_COMPLETION_OPTS="--border --info=inline"
  # export FZF_DEFAULT_OPTS="--reverse --height=~40% --no-scrollbar --color=gutter:-1"
# fi

# if [[ -x "$(command -v direnv)" ]]; then
#   eval "$(direnv hook zsh)"
# fi

# starship prompt when the terminal supports it
# NOTE make sure to install using brew prior to sourcing
# eval "$(starship init zsh)"

# end plugins }}}
# hooks {{{
autoload -U add-zsh-hook

function -set-tab-and-window-title() {
  emulate -L zsh
  local TITLE="${1:gs/$/\\$}"
  print -Pn "\e]0;$TITLE:q\a"
}

# $HISTCMD (the current history event number) is shared across all shells
# (due to SHARE_HISTORY). Maintain this local variable to count the number of
# commands run in this specific shell.
__WINCENT[HISTCMD_LOCAL]=0

function -forkless-basename() {
  emulate -L zsh
  echo "${PWD##*/}"
}

# Show first distinctive word of command (for use in tab titles).
function -title-command() {
  emulate -L zsh
  setopt EXTENDED_GLOB

  # Mostly stolen from:
  #
  #   https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/termsupport.zsh
  #
  # Via `man zshall`, $2, passed into a preexec function:
  #
  #     the second argument is a single-line, size-limited version of the
  #     command (with things like function bodies elided)
  #
  # - Due to EXTENDED_GLOB, $2 will be expanded as follows.
  # - `[(wr)...]` is for array manipulation ([w]ord split, and [r]emove).
  # - `^` exclude patterns.
  # - `*=*` will remove env vars (eg. `foo=bar`, anything containing an "=").
  # - `mosh`/`ssh`/`sudo` get removed too.
  # - `-*` removes anything starting with a hyphen.
  # - `:gs/%/%%` ensures that any "%" (rare) gets escaped as "%%".
  echo "${1[(wr)^(*=*|mosh|ssh|sudo|-*)]:gs/%/%%}"
}

# Executed before displaying prompt.
function -update-title-precmd() {
  emulate -L zsh
  setopt EXTENDED_GLOB
  setopt KSH_GLOB
  if [[ __WINCENT[HISTCMD_LOCAL] -eq 0 ]]; then
    # About to display prompt for the first time; nothing interesting to show in
    # the history. Show $PWD.
    -set-tab-and-window-title "$(-forkless-basename)"
  else
    local LAST=$(fc -l -1)
    LAST="${LAST## #}" # Trim leading whitespace.
    LAST="${LAST##*([^[:space:]])}" # Remove first word (history number).
    LAST="${LAST## #}" # Trim leading whitespace.
    if [ -n "$TMUX" ]; then
      # Inside tmux, just show the last command: tmux will prefix it with the
      # session name (for context).
      -set-tab-and-window-title "$(-title-command "$LAST")"
    else
      # Outside tmux, show $PWD (for context) followed by the last command.
      -set-tab-and-window-title "$(-forkless-basename) • $(-title-command "$LAST")"
    fi
  fi
}
add-zsh-hook precmd -update-title-precmd

# Executed before executing a command: $2 is one-line (truncated) version of
# the command.
function -update-title-preexec() {
  emulate -L zsh
  __WINCENT[HISTCMD_LOCAL]=$((++__WINCENT[HISTCMD_LOCAL]))
  if [ -n "$TMUX" ]; then
    # Inside tmux, show the running command: tmux will prefix it with the
    # session name (for context).
    -set-tab-and-window-title "$(-title-command "$2")"
  else
    # Outside tmux, show $PWD (for context) followed by the running command.
    -set-tab-and-window-title "$(-forkless-basename) • $(-title-command "$2")"
  fi
}
add-zsh-hook preexec -update-title-preexec

function -auto-ls-after-cd() {
  emulate -L zsh
  # Only in response to a user-initiated `cd`, not indirectly (eg. via another
  # function).
  if [ "$ZSH_EVAL_CONTEXT" = "toplevel:shfunc" ]; then
    ls -a
  fi
}
add-zsh-hook chpwd -auto-ls-after-cd

# adds `cdr` command for navigating to recent directories
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs

# enable menu-style completion for cdr
zstyle ':completion:*:*:cdr:*:*' menu selection

# fall through to cd if cdr is passed a non-recent dir as an argument
zstyle ':chpwd:*' recent-dirs-default true

# }}}

# vim: foldmethod=marker ts=2 sw=2 et
