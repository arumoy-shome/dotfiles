function colors -d "switch to a dark of light theme"
  set base "$XDG_DATA_HOME/base16"

  set color $argv[1]

  test "$color" = "light"; and set theme "base16-default-light"
  test "$color" = "dark"; and set theme "base16-default-dark"

  ln -sfh ~/.local/share/base16/$theme.sh ~/.local/share/base16/current-theme.sh

  # let vim know what theme to use
  echo -e "$theme\n$color" >  ~/.vim/.background

  # finally, set the theme
  eval sh "$base/$theme.sh"

  sync_tmux_colors
end
