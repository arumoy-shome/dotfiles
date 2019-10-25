function scd -d "cd into alternate directory if it exists in a new tmux split"
set alt_cwd (python3 "$XDG_DATA_BIN/fish-projectionist" (pwd))

if test -n $alt_cwd
  if test -n "$TMUX"
    tmux split-window -v -c $alt_cwd
  else
    cd $alt_cwd
  end
else
  echo "no alternate directory found."
end
end
