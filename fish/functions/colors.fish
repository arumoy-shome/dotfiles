# Takes a hex color in the form of "RRGGBB" and outputs its luma (0-255, where
# 0 is black and 255 is white).
#
# Based on: https://github.com/lencioni/dotfiles/blob/b1632a04/.shells/colors
function __luma -a COLOR_HEX

  if test -z "$COLOR_HEX"
    echo "Error: Missing argument hex color (RRGGBB)"
    return 1
  end

  # Extract hex channels from background color (RRGGBB).
  set -l COLOR_HEX_RED   (echo "$COLOR_HEX" | cut -c 1-2)
  set -l COLOR_HEX_GREEN (echo "$COLOR_HEX" | cut -c 3-4)
  set -l COLOR_HEX_BLUE  (echo "$COLOR_HEX" | cut -c 5-6)

  # Convert hex colors to decimal.
  set -l COLOR_DEC_RED   (printf "%d" 0x$COLOR_HEX_RED)
  set -l COLOR_DEC_GREEN (printf "%d" 0x$COLOR_HEX_GREEN)
  set -l COLOR_DEC_BLUE  (printf "%d" 0x$COLOR_HEX_BLUE)

  # Calculate perceived brightness of background per ITU-R BT.709
  # https://en.wikipedia.org/wiki/Rec._709#Luma_coefficients
  # http://stackoverflow.com/a/12043228/18986
  set -l COLOR_LUMA_RED   (math "0.2126 * $COLOR_DEC_RED")
  set -l COLOR_LUMA_GREEN (math "0.7152 * $COLOR_DEC_GREEN")
  set -l COLOR_LUMA_BLUE  (math "0.0722 * $COLOR_DEC_BLUE")

  set -l COLOR_LUMA (math -s 0 "$COLOR_LUMA_RED + $COLOR_LUMA_GREEN + $COLOR_LUMA_BLUE")

  echo "$COLOR_LUMA"
end

function __scheme -a ARGV
  set -l SCHEME "base16-$ARGV"
  set -l BASE "$FDOTDIR/base16-shell/scripts"
  set -l SCRIPT "$BASE/$SCHEME.sh"

  if test -e "$SCRIPT"
    set -l BG (grep color_background= "$SCRIPT" | cut -d \" -f2 | sed -e 's#/##g')
    set -l LUMA (__luma "$BG")
    set -l BACKGROUND dark
    test "$LUMA" -gt 127.5; and set BACKGROUND light

    test -d "$XDG_DATA_HOME/base16"; or mkdir -p "$XDG_DATA_HOME/base16"
    ln -sfh "$SCRIPT" "$XDG_DATA_HOME/base16/current-theme.sh"
    # let vim know what theme to use
    echo -e "$SCHEME\n$BACKGROUND" >  "$HOME/.vim/.background"
    # finally, set the theme
    sh "$XDG_DATA_HOME/base16/current-theme.sh"
    test -n "$TMUX"; and sync_tmux_colors
  else
    echo "Scheme $SCRIPT does not exist."
    return 1
  end
end

function colors
  set -l BASE "$FDOTDIR/base16-shell/scripts"

  switch "$argv[1]"
  case ls
    echo 'Available colorschemes:'
    echo
    find "$BASE" -name 'base16-*.sh' | sed -E 's|.+/base16-||' | sed -E 's/\.sh//' | column
  case help
    echo 'USAGE:'
    echo '  colors [scheme] to change colorscheme'
    echo '  colors ls to list all available colorschemes'
    echo '  colors help to print this help message'
  case '*'
    __scheme "$argv[1]"
  end
end
