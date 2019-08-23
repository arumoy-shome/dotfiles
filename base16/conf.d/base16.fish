set theme $XDG_DATA_HOME/base16/current-theme.sh
eval sh '"'(realpath $theme)'"'

# reapply tmux window and pane colors such that inactive windows remain dim
set bg (grep color_background= "$theme" | cut -d \" -f2 | sed -e 's#/##g')
set cc (grep color18= "$theme" | cut -d \" -f2 | sed -e 's#/##g')

if test -n "$TMUX"
    command tmux set -a window-active-style "bg=#$bg"
    command tmux set -a window-style "bg=#$cc"
    command tmux set -g pane-active-border-style "bg=#$cc"
    command tmux set -g pane-border-style "bg=#$cc"
end
