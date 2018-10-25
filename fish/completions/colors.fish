function _list_colors
    set base "$BASE16_HOME/scripts"
    # look after '-' and before '.'
    string match -r '(?<=-)[\S\d]*(?=\.)' (ls $base)
end

complete -c colors -a "(_list_colors)"
