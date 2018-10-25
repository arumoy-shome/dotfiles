# load base16-shell when not in emacs
if not test eterm-color = "$TERM"
    source "$XDG_CONFIG_HOME/base16/profile_helper.fish"
end
