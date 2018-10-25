set base "$XDG_CONFIG_HOME/base16-shell/scripts"

function _list_colors
    # look after '-' and before '.'
    string match -r '(?<=-)[\S\d]*(?=\.)' (ls $base)
end

complete -c colors -a "(_list_colors)"
