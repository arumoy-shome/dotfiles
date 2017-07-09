# give us access to ^Q
stty -ixon

# vi mode
bindkey -v
bindkey "^F" vi-cmd-mode

# handy keybindings
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^T" history-incremental-search-backward
bindkey "^P" history-search-backward
bindkey "^N" history-search-forward
