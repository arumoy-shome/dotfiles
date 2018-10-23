set base "$XDG_CONFIG_HOME/base16-shell/scripts"

function _list_colors
    # look after '-' and before '.'
    string match -r '(?<=-)[\S\d]*(?=\.)' (ls $base)
end

function _valid_color
    set colors (_list_colors)

    contains $argv $colors
end

function colors
    if _valid_color $argv
        eval base16-$argv
        echo "theme set successfully!"
    else
        _list_colors
    end
end
