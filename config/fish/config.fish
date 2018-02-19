# change the greeting message
set fish_greeting 'welcome, aru.'

# Base16 Shell
if status --is-interactive
    eval sh $HOME/.config/base16-shell/scripts/base16-tomorrow-night.sh
end

# load ~/.bin for personal commands
set PATH $HOME/.bin $PATH

# define some useful abbreviations
# abbreviations are like alias but with nicer gui
if status --is-interactive
  set -g fish_user_abbreviations
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
end
