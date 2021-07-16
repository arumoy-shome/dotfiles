#
# Global
#

# Create a hash table for globally stashing variables without polluting main
# scope with a bunch of identifiers.
typeset -A __ARU

__ARU[ITALIC_ON]=$'\e[3m'
__ARU[ITALIC_OFF]=$'\e[23m'

#
# Autoloads
#

fpath=("$ZDOTDIR/functions" $fpath)

# NOTE: (double)quotes don't work here, probably because it's a glob pattern?
for f in $ZDOTDIR/functions/*; do autoload -U ${f:t}; done

#
# History
#

export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

#
# Others
#

# an alternative to looking up man pages for zsh builtins (similar to fish's
# help) from man zshcontrib(1)@56 it is unaliased first since run-help is
# usually symlinked to man on most unix systems
unalias run-help && autoload -U run-help

#
# Plugins
#

[[ -d "$ZDOTDIR/zsh-syntax-highlighting" ]] && \
  source "$ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

[[ -d "$ZDOTDIR/zsh-autosuggestions" ]] && \
  source "$ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'

#
# prompt
#

if [[ -d "$ZDOTDIR/pure" ]]; then
  fpath+="$ZDOTDIR/pure"
  autoload -U promptinit; promptinit
  prompt pure
  zstyle :prompt:pure:git:stash show yes
fi

# Base16 Shell (only when not in emacs)
[[ -r "$XDG_DATA_HOME/base16/current-theme.sh" ]] && \
    [[ $TERM != "eterm-color" ]] && \
    sh "$XDG_DATA_HOME/base16/current-theme.sh"

#
# Config
#

source $ZDOTDIR/bindings.zsh
source $ZDOTDIR/completion.zsh
source $ZDOTDIR/options.zsh
source $ZDOTDIR/exports.zsh
source $ZDOTDIR/alias.zsh
source $ZDOTDIR/prompt.zsh

#
# hooks
#

# ls -FA after cd
autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd (){ ls -FA; }
