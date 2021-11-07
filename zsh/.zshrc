# vim: foldmethod=marker

# Global {{{
# Create a hash table for globally stashing variables without polluting main
# scope with a bunch of identifiers.
typeset -A __ARU

__ARU[ITALIC_ON]=$'\e[3m'
__ARU[ITALIC_OFF]=$'\e[23m'
# End Global }}}

# Autoloads {{{
fpath=("$ZDOTDIR/functions" $fpath)

# NOTE: (double)quotes don't work here, probably because it's a glob pattern?
for f in $ZDOTDIR/functions/*; do autoload -U ${f:t}; done
# End Autoloads }}}

# History {{{
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
# End History }}}

# Others {{{
# an alternative to looking up man pages for zsh builtins (similar to fish's
# help) from man zshcontrib(1)@56 it is unaliased first since run-help is
# usually symlinked to man on most unix systems
unalias run-help && autoload -U run-help
# End Others }}}

# Plugins {{{
[[ -d "$ZDOTDIR/zsh-syntax-highlighting" ]] && \
  source "$ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

if [[ -d "$ZDOTDIR/zsh-autosuggestions" ]]; then
  source "$ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'
  ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)
fi

if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
  if (( $+commands[fd] )); then
    # use fd instead of find
    # search hidden files & directories (except .git)
    export FZF_DEFAULT_COMMAND='fd --type file --hidden --follow --exclude .git'
  fi
fi

# Base16 Shell (only when not in emacs)
[[ -r "$XDG_DATA_HOME/base16/current-theme.sh" ]] && \
    sh "$XDG_DATA_HOME/base16/current-theme.sh"
# End Plugins }}}

# Config {{{
source $ZDOTDIR/prompt.zsh
source $ZDOTDIR/bindings.zsh
source $ZDOTDIR/completion.zsh
source $ZDOTDIR/options.zsh
source $ZDOTDIR/exports.zsh
source $ZDOTDIR/alias.zsh # must come after exports
source $ZDOTDIR/hooks.zsh
# End Config }}}
