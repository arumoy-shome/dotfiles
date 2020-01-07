# use fd instead of find if available
if command -sq fd
  set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
  set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
end
