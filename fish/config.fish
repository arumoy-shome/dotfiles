if status is-interactive
  # Commands to run in interactive sessions can go here
  alias b="brew"
  alias v="nvim"

  set -x XDG_CONFIG_HOME "$HOME/.config"
  set -x XDG_DATA_HOME "$HOME/.local/share"
  set -x XDG_DATA_BIN "$HOME/.local/bin"
  set -a PATH  "$XDG_DATA_BIN"

  set fish_cursor_default block
end
