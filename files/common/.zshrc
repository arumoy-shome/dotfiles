# Shared with bash. Must come first: it builds PATH, and everything below
# gates on `command -v`.
. "$HOME/.config/sh/rc"

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
# {{{ completion
# NOTE: after the shared rc, so completions for anything it puts on PATH are
# picked up.
autoload -Uz compinit
compinit -u

zstyle :compinstall filename "$HOME/.zshrc"

# Make completion:
# - Try exact (case-sensitive) match first.
# - Then fall back to case-insensitive.
# - Accept abbreviations after . or _ or - (ie. f.b -> foo.bar).
# - Substring complete (ie. bar -> foobar).
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}' '+m:{_-}={-_}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# end completion}}}
# {{{ prompt
# starship is handled by the shared rc; this is the fallback when it is
# absent, and has no bash equivalent.
if ! (( $+commands[starship] ))
then
  autoload -Uz promptinit
  promptinit
  autoload -U colors
  colors

  prompt walters
fi
# End prompt }}}
# {{{ keybindings
bindkey -e

# NOTE: must come before zsh-syntax-highlighting.
autoload -U select-word-style
select-word-style bash # only alphanumeric chars are considered WORDCHARS

bindkey ' ' magic-space # do history expansion on space

# Replace standard history-incremental-search-{backward,forward} bindings.
# These are the same but permit patterns (eg. a*b) to be used.
bindkey "^r" history-incremental-pattern-search-backward
bindkey "^s" history-incremental-pattern-search-forward

# Wordwise movement with Opt/Ctrl plus left/right.
bindkey "^[[1;3C" forward-word # For macOS.
bindkey "^[[1;3D" backward-word # For macOS.
bindkey "^[[1;5C" forward-word # For Arch.
bindkey "^[[1;5D" backward-word # For Arch.
# End keybindings }}}
# {{{ alias
# Suffix aliases have no bash equivalent, so they stay here.
alias -s pdf=o
alias -s html=o

alias grep='grep --ignore-case --line-number --extended-regexp --color'
alias rgrep='grep --ignore-case --line-number --extended-regexp --color --exclude-dir ".git" --recursive'

if (( $+commands[emacs] )); then
  alias e="emacsclient -nw --alternate-editor '' --quiet"
  alias E="emacsclient --alternate-editor ''  --no-wait --quiet --create-frame"
fi

if (( $+commands[docker] ))
then
  alias drun='docker run -it --rm --v "$(pwd):/app"'
fi
# End alias }}}
# {{{ plugins
plugins=(
  "/opt/homebrew/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
  "/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  # debian derivatives; no fast-syntax-highlighting package, plain
  # zsh-syntax-highlighting is the equivalent. It has to be sourced last,
  # hence autosuggestions first.
  "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
)

for plugin in $plugins
do
  [[ -f $plugin ]] && source $plugin
done
# End plugins}}}

[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

true # exit code 0 at the very end
# vim: foldmethod=marker ts=2 sw=2 et
