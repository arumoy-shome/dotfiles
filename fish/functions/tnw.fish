function tnw -d "name tmux window to current basename"
    test $TMUX; and tmux rename-window (basename (pwd))
end
