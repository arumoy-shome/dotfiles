function acd -d "cd into alternate directory if it exists"
set alt_cwd (python3 "$XDG_DATA_BIN/fish-projectionist" (pwd))

if test -n $alt_cwd
  cd $alt_cwd
else
  echo "no alternate directory found."
end
end
