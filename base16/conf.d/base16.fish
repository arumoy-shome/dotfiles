# note that we cannot use $XDG_DATA_HOME here since it is not loaded yet
set theme ~/.local/share/base16/current-theme.sh
eval sh "$theme"

sync_tmux_colors
