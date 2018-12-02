# change the greeting message
set fish_greeting 'welcome, '(whoami)'.'

set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"

set -g XDG_DATA_BIN "$HOME/.local/bin"
set -g FISH_CONFIG_HOME "$XDG_CONFIG_HOME/fish/conf.d"

abbr -a jp "jupyter"
