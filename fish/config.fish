# change the greeting message
set fish_greeting 'welcome, '(whoami)'.'

# base16-shell
source "$XDG_CONFIG_HOME/base16-shell/profile_helper.fish"

# define some useful abbreviations
# abbreviations are like alias but with nicer gui
abbr -a b "brew"
abbr -a bc "brew cask"
abbr -a bci "brew cask install"
abbr -a bcs "brew cask search"
abbr -a bi "brew install"
abbr -a bs "brew search"
abbr -a cl "clear"
abbr -a g "git"
abbr -a gco "git checkout"
abbr -a gco "git checkout"
abbr -a gfm "git pull origin"
abbr -a gia "git add"
abbr -a gp "git push origin"
abbr -a gwd "git diff"
abbr -a gws "git status"
abbr -a jp "jupyter"
abbr -a pip "pip3"
abbr -a py "python3"
abbr -a py2 "python2"
abbr -a ipy "ipython3"
abbr -a t "tmux"

# define aliases
alias tmux "tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
alias git "hub"
