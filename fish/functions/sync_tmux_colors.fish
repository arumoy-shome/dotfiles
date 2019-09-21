function sync_tmux_colors -d "reapply tmux window and pane colors such that inactive windows remain dim"
  set theme ~/.local/share/base16/current-theme.sh
  set bg (grep color_background= "$theme" | cut -d \" -f2 | sed -e 's#/##g')
  set cc (grep color18= "$theme" | cut -d \" -f2 | sed -e 's#/##g')
  set fg (grep color_foreground= "$theme" | cut -d \" -f2 | sed -e 's#/##g')
  set red (grep color01= "$theme" | cut -d \" -f2 | sed -e 's#/##g')

  if test -n "$TMUX"
    command tmux set -a window-active-style "bg=#$bg"
    command tmux set -a window-style "bg=#$cc"
    command tmux set -g window-status-current-style "bg=#$cc,fg=#$red,bold,italics"
    command tmux set -g pane-active-border-style "bg=#$cc"
    command tmux set -g pane-border-style "bg=#$cc"
    command tmux set -g status-style "bg=#$cc,fg=#$fg,bold,italics"
    command tmux set -g window-status-bell-style "fg=#$red,bold,underscore"
  end
end
