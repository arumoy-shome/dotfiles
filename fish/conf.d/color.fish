# note that we cannot use $XDG_DATA_HOME here since it is not loaded yet
# NOTE: base16-shell temporarily disabled since it injects escape sequences
# that are exported to subprocesses (such as fzf).
# sh ~/.local/share/base16/current-theme.sh
test -n "$TMUX"; and sync_tmux_colors
