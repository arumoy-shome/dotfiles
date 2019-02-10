[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_OPTS="--height 70% --border"
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
