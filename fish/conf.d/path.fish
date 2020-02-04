# NOTE: fish sources config.fish all files under conf.d on startup, thus they
# get sourced twice if we launch tmux (once when we lauch the terminal and then
# again when we lauch a tmux session).

if test -z "$TMUX"
  set -l PATHS $HOME/.local/bin \
    /usr/local/lib/ruby/gems/2.6.0/bin \
    /usr/local/opt/ruby/bin \
    $HOME/.emacs.d/bin

    for P in $PATHS
      test -d $P; and set PATH $P $PATH
    end
end
