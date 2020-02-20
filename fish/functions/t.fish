function __session_exists -S
  tmux list-sessions | sed -E 's/:.*$//' | grep -q '^'$SESSION_NAME'$'
end

function __create_detached_session -S
  tmux new-session -Ad -s "$SESSION_NAME"
end

function t -d "attach to tmux session if it exists, or create a new one with no args envoke tmux when args are passed"
  # If provided with args, pass them through.
  if test -n "$argv"
    tmux "$argv"
    return
  end

  # Attach to existing session, or create one, based on current directory.
  set -l SESSION_NAME (basename "$PWD" | tr . -)

  if test -z "$TMUX"
    tmux new -A -s "$SESSION_NAME"
  else
    if not __session_exists; __create_detached_session; end
    tmux switch-client -t "$SESSION_NAME"
  end
end
