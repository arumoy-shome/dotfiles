function colors --description 'switch to a dark of light theme'
    if set -q XDG_DATA_HOME
        set base "$XDG_DATA_HOME/base16"
    else
        set base "$HOME/.config/base16-shell"
    end
    
    set color $argv[1]

    test "$color" = "light"; and set theme "base16-solarized-light"
    test "$color" = "dark"; and set theme "base16-tomorrow-night"

    sh "$base/scripts/$theme.sh"

    echo -e "if !exists('g:colors_name') || g:colors_name != '$theme'\n  colorscheme $theme\nendif" >  ~/.vim/plugin/background.vim
end
