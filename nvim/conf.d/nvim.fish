set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx MANPAGER "nvim --noplugin -Rc 'set ft=man' -"

abbr -a v "nvim"
