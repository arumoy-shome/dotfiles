set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx MANPAGER "nvim -Rc 'set ft=man' -"

abbr -a v "nvim"
