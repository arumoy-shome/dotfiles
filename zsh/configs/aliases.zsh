# Unix
alias ll="ls -al"
alias ln="ln -v"
alias mkdir="mkdir -p"
alias e="$EDITOR"
alias v="$VISUAL"

# Bundler
alias b="bundle"

# Rails
alias migrate="rake db:migrate db:rollback && rake db:migrate db:test:prepare"
alias s="rspec"

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# Git
alias g="git"
alias gb="git branch"
alias gc="git commit -v"
alias gco="git checkout"
alias gfm="git pull origin"
alias gia="git add"
alias gp="git push origin"
alias grbi="git rebase --interactive"
alias gwd="git diff"
alias gws="git status"

# Bundler
alias be="bundle exec"

# Rails
alias kill-server="lsof -wni tcp:3000"

# Tmux
alias tkill="tmux kill-session -t"
alias tls="tmux ls"
alias ta="tmux a -t"

# Docker
alias d="docker"
alias dc="docker-compose"
alias dm="docker-machine"

# Python
alias py="python3"
