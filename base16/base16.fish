# load base16-shell when not in emacs
if not test eterm-color = "$TERM"
    source "$BASE16_HOME/profile_helper.fish"
end
