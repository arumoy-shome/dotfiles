# NOTE: the completion options are not cached in a variable by choice since that
# results in outdated completions being presented.
# NOTE: `$` in the -a flag argument needs to be escaped due to fish's variable
# expansion.

function _completions
  find $PWD -path '*/bin/python' -maxdepth 3 | sed -E 's|/bin/python$||' | sed -E 's@.*/@@'
end

complete -f -c venv -s c -l create -d "create a virtualenv"
complete -f -c venv -s d -l deactivate -d "deactivate a virtualenv"
complete -f -c venv -s D -l delete -a "(_completions)" -d "delete a virtualenv"
complete -f -c venv -s a -l activate -a "(_completions)" -d "activate a virtualenv"
complete -f -c venv -a "(_completions)" -d "virtualenv"
complete -f -c venv -s l -l ls -d "list virtualenvs"
