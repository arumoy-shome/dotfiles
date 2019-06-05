if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

abbr -a dark "base16-tomorrow-night"
abbr -a light "base16-tomorrow"
