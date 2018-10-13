set base "$HOME/.config/base16-shell/scripts/"

function colors
  if _is_interactive; and _valid_color $argv
    eval sh $HOME/.config/base16-shell/scripts/base16-$argv.sh
    echo "theme set successfully!"
  else
    _list_colors
    echo 'invalid scheme selection, please choose a theme from above...'
  end
end

function _list_colors
  set options (ls $base)

  for option in $options
    string match -r 'base16-(.*).sh' $option
  end
end

function _is_interactive
  status --is-interactive
end

function _valid_color
  set options (_list_colors)

  for option in $options
    if string match "$argv" $option
      break
    else
      false
    end
  end
end
