#
# Global
#

# Create a hash table for globally stashing variables without polluting main
# scope with a bunch of identifiers.
typeset -A __ARU

__ARU[ITALIC_ON]=$'\e[3m'
__ARU[ITALIC_OFF]=$'\e[23m'

#
# Teh H4xx
#

if [ "$(uname)" = "Darwin" ]; then
  # Suppress unwanted Homebrew-installed stuff.
  if [ -e /usr/local/share/zsh/site-functions/_git ]; then
    mv -f /usr/local/share/zsh/site-functions/{,disabled.}_git
  fi

  # Set 60 fps key repeat rate
  #
  # Equivalent to the fatest rate acheivable with:
  #
  #     defaults write NSGlobalDomain KeyRepeat -int 1
  #
  # But doesn't require a logout and will get restored every time we open a
  # shell (for example, if somebody manipulates the slider in the UI).
  #
  # Fastest rate available from UI corresponds to:
  #
  #     defaults write NSGlobalDomain KeyRepeat -int 2
  #
  # Slowest rate available from UI corresponds to:
  #
  #     defaults write NSGlobalDomain KeyRepeat -int 120
  #
  # Values at each slider position in UI, from slowest to fastest:
  #
  # - 120 -> 2 seconds (ie. .5 fps)
  # - 90 -> 1.5 seconds (ie .6666 fps)
  # - 60 -> 1 second (ie 1 fps)
  # - 30 -> 0.5 seconds (ie. 2 fps)
  # - 12 -> 0.2 seconds (ie. 5 fps)
  # - 6 -> 0.1 seconds (ie. 10 fps)
  # - 2 -> 0.03333 seconds (ie. 30 fps)
  #
  # See: https://github.com/mathiasbynens/dotfiles/issues/687
  #
  if command -v dry &> /dev/null; then
    dry 0.0166666666667 > /dev/null
  fi
fi

#
# Config
#

for f in $ZDOTDIR/*.zsh; do source $f; done

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

# an alternative to looking up man pages for zsh builtins (similar to fish's help) from man zshcontrib(1)@56
# it is unaliased first since run-help is usually symlinked to man on most unix systems
unalias run-help && autoload -U run-help

#
# Plugins
#

[[ -d "$ZDOTDIR/zsh-syntax-highlighting" ]] && \
  source "$ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

[[ -d "$ZDOTDIR/zsh-autosuggestions" ]] && \
  source "$ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'
