export LC_ALL=en_US.UTF-8

#
# Path
#

# from http://zsh.sourceforge.net/Guide/zshguide02.html#l24
# this prevents duplicates in path by dropping the duplicate from the tail
typeset -U path
# add ruby to path, required by neovim
# cannot use $XDG_DATA_BIN here since it is not defined yet
path=(/usr/local/lib/ruby/gems/2.6.0/bin /usr/local/opt/ruby/bin $HOME/.local/bin $path)
