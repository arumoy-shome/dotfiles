function colors -d "switch to a dark of light theme"
    set base "$XDG_DATA_HOME/base16"
    set color $argv[1]

    test "$color" = "light"; and set theme "base16-solarized-light"
    test "$color" = "dark"; and set theme "base16-tomorrow-night"

    kitty @ set-colors --all --configured "$base/$theme.conf"

    ln -sfh ~/.local/share/base16/$theme.conf ~/.local/share/base16/current-theme.conf

    echo -e "if !exists('g:colors_name') || g:colors_name != '$theme'\n  colorscheme $theme\nendif" >  ~/.vim/.background
end
