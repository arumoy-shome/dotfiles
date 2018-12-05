function colors -d "switch to a dark of light theme"
    set base "$XDG_DATA_HOME/base16"
    set color $argv[1]

    test "$color" = "light"; and sh "$base/base16-solarized-light.sh"
    test "$color" = "dark"; and sh "$base/base16-tomorrow-night.sh"
end
