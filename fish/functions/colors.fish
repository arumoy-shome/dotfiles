function _list_colors
    set base "$BASE16_HOME/scripts"

    # look after '-' and before '.'
    string match -r '(?<=-)[\S\d]*(?=\.)' (ls $base)
end

function _valid_color
    set colors (_list_colors)

    contains $argv $colors
end

function _current_theme
    string match -r '(?<=-)[\S\d]*(?=\.)' (realpath "$BASE16_HOME/.base16_theme")
end

function colors

    set options (fish_opt -s l)
    argparse -n colors $options -- $argv

    test $_flag_l; and _list_colors

    test $argv; and _valid_color $argv; and eval base16-$argv

    echo "current theme set to: "(_current_theme)
end
