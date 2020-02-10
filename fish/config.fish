# change the greeting message
set fish_greeting 'welcome, '(whoami)'.'
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -g XDG_DATA_BIN "$HOME/.local/bin"
set -g FDOTDIR "$XDG_CONFIG_HOME/fish"
set -x LC_ALL en_US.UTF-8
set -gx EDITOR vim
set -gx VISUAL $EDITOR
