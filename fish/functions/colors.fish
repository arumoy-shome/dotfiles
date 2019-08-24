function colors -d "switch to a dark of light theme"
    set base "$XDG_DATA_HOME/base16"
    set color $argv[1]

    test "$color" = "light"; and set theme "base16-default-light"
    test "$color" = "dark"; and set theme "base16-default-dark"

    # grab the hex codes
    set bg (grep color_background= "$base/$theme.sh" | cut -d \" -f2 | sed -e 's#/##g')
    set cc (grep color18= "$base/$theme.sh" | cut -d \" -f2 | sed -e 's#/##g')

    # update tmux window and pane colours to dim inactive panes
    if test -n "$TMUX"
      command tmux set -a window-active-style "bg=#$bg"
      command tmux set -a window-style "bg=#$cc"
      command tmux set -g pane-active-border-style "bg=#$cc"
      command tmux set -g pane-border-style "bg=#$cc"
    end

    ln -sfh ~/.local/share/base16/$theme.sh ~/.local/share/base16/current-theme.sh

    # let vim know what theme to use
    echo -e "if !exists('g:colors_name') || g:colors_name != '$theme'\n  colorscheme $theme\nendif" >  ~/.vim/.background

    # finally, set the theme
    eval sh "$base/$theme.sh"
end
