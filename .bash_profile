[[ -f $HOME/.bashrc ]] && source $HOME/.bashrc

[[ "$TERM" =~ "xterm" ]] &&
    [[ -e "${HOME}/.iterm2_shell_integration.bash" ]] &&
    source "${HOME}/.iterm2_shell_integration.bash"

