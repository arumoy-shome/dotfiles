# make sure PATHS contains valid entries, this is intentionally left to be done
# manually for performance (it can be expensive to check if entries are valid if
# PATHS is long).

# FIXME: tmux runs as a login shell thus it reruns /usr/libexec/path_helper to
# build the path which duplicates our custom paths, I have not been able to
# find a suitable solution for this yet.
set -l PATHS /usr/local/opt/coreutils/libexec/gnubin \
  /usr/local/lib/ruby/gems/2.6.0/bin \
  /usr/local/opt/ruby/bin \
  $HOME/.local/bin \

set PATH $PATHS $PATH
