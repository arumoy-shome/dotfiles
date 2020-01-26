# note that we cannot use $XDG_DATA_HOME here since it is not loaded yet
sh ~/.local/share/base16/current-theme.sh
test -n "$TMUX"; and sync_tmux_colors
