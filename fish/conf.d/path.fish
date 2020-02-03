# NOTE: fish sources config.fish all files under conf.d on startup, thus they
# get sourced twice if we launch tmux (once when we lauch the terminal and then
# again when we lauch a tmux session).

if test -z "$TMUX"
  set PATH $HOME/.local/bin $PATH # add $HOME/.local/bin containing local scripts
  set PATH /usr/local/lib/ruby/gems/2.6.0/bin /usr/local/opt/ruby/bin $PATH # required by nvim
  set PATH $HOME/.emacs.d/bin $PATH # contains the doom executable
end
