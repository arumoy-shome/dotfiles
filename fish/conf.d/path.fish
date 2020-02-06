# NOTE: fish sources config.fish all files under conf.d on startup, thus they
# get sourced twice if we launch tmux (once when we lauch the terminal and then
# again when we lauch a tmux session). The fix is simply to manipulate PATH if
# we are not in tmux.

if test -z "$TMUX"
# make sure PATHS contains valid entries, this is intentionally left to be done
# manually for performance (it can be expensive to check if entries are valid if
# PATHS is long).
  set -l PATHS /usr/local/opt/coreutils/libexec/gnubin \
    /usr/local/lib/ruby/gems/2.6.0/bin \
    /usr/local/opt/ruby/bin \
    $HOME/.local/bin \

  set PATH $PATHS $PATH
end

# NOTE: tmux runs /usr/libexec/path_helper to build the path which APPENDS our
# custom paths, the simplest (albeit hacky) way to fix this is in fish is to
# reverse PATH. See https://scriptingosx.com/2017/05/where-paths-come-from/.
test -n "$TMUX"; and set PATH $PATH[-1..1]
