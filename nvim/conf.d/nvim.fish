if command -sq nvim
  set -gx EDITOR nvim
else
  set -gx EDITOR vim
end
set -gx VISUAL $EDITOR

alias v $EDITOR
