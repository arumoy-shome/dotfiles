# fish evaulates files in conf.d before config.fish
# this is the first file that is evaluated in conf.d
# thus we set fish_user_abbreviations at global scope here
set -g fish_user_abbreviations
abbr -a b "brew"
abbr -a bc "brew cask"
