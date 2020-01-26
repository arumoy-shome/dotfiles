function __session_exists -S
  tmux list-sessions | sed -E 's/:.*$//' | grep -q '^'$SESSION_NAME'$'
end

function __create_detached_session -S
  tmux new-session -Ad -s "$SESSION_NAME"
end

function t -d "attach to tmux session if it exists, or create a new one with no args envoke tmux when args are passed"
  # Make sure even pre-existing tmux sessions use the latest SSH_AUTH_SOCK.
  # (Inspired by: https://gist.github.com/lann/6771001)
  set -l SOCK_SYMLINK ~/.ssh/ssh_auth_sock
  if test -r "$SSH_AUTH_SOCK" -a ! -L "$SSH_AUTH_SOCK"
    ln -sf "$SSH_AUTH_SOCK" "$SOCK_SYMLINK"
  end

  # If provided with args, pass them through.
  if test -n "$argv"
    env SSH_AUTH_SOCK=$SOCK_SYMLINK tmux "$argv"
    return
  end

  # Attach to existing session, or create one, based on current directory.
  set -l SESSION_NAME (basename "$PWD" | tr . -)

  if test -z "$TMUX"
    env SSH_AUTH_SOCK=$SOCK_SYMLINK tmux new -A -s "$SESSION_NAME"
  else
    if not __session_exists; __create_detached_session; end
    tmux switch-client -t "$SESSION_NAME"
  end
end
