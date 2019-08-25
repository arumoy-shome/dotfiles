set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx MANPAGER "nvim -Rc 'set ft=man' -"

# add the path to ruby gems installed by brew so that neovim can locate the ruby
# provider
set PATH /usr/local/lib/ruby/gems/2.6.0/bin /usr/local/opt/ruby/bin $PATH

abbr -a v "nvim"
