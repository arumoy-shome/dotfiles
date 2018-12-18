# use fd instead of find
# depends on fd (https://github.com/sharkdp/fd)
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git'
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
