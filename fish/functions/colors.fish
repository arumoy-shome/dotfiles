function colors -d "switch to a dark of light theme"
  set base "$XDG_DATA_HOME/base16"

  if test -n "$argv[1]"
    set scheme "$argv[1]"
  else
    echo "No scheme given, using default."
    set scheme default
  end

  if test -n "$argv[2]"
    set color "$argv[2]"
  else
    echo "No color given, using dark."
    set color dark
  end

  set theme "base16-$scheme-$color"

  if test -e "$base/$theme.sh"
    ln -sfh ~/.local/share/base16/$theme.sh ~/.local/share/base16/current-theme.sh

    # let vim know what theme to use
    echo -e "$theme\n$color" >  ~/.vim/.background

    # finally, set the theme
    eval sh "$base/$theme.sh"

    sync_tmux_colors
  else
    echo "Scheme $theme does not exist."
    return 1
  end
end
