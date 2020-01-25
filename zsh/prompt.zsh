if [[ -d "$ZDOTDIR/pure" ]]; then
  fpath+=("$ZDOTDIR/pure")
  autoload -U promptinit; promptinit
  prompt pure
fi
