[[ -r /usr/local/etc/bash_completion.d/git-completion.bash ]] && \
    source /usr/local/etc/bash_completion.d/git-completion.bash

[[ -r /usr/local/etc/bash_completion.d/git-prompt.sh ]] && \
    source /usr/local/etc/bash_completion.d/git-prompt.sh

GIT_PS1_SHOWDIRTYSTATE=true

PS1='\[\033[36m\][\w$(__git_ps1 " (%s)")] \$ \[\033[00m\]'
