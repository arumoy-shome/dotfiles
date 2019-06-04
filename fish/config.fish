# change the greeting message
set fish_greeting 'welcome, '(whoami)'.'

set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"

set -g XDG_DATA_BIN "$HOME/.local/bin"
set -g FISH_CONFIG_HOME "$XDG_CONFIG_HOME/fish/conf.d"

set PATH $XDG_DATA_BIN $PATH

set PATH /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/ $PATH

# use neovim as the pager
set -gx MANPAGER "nvim --noplugin -Rc 'set ft=man' -"
