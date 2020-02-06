set -l venvs (find $PWD -path '*/bin/python' -maxdepth 3 | sed -E 's|/bin/python$||' | sed -E 's@.*/@@')
complete -f -c venv -s c -l create -d "create a virtualenv"
complete -f -c venv -s D -l delete -a "$venvs" -d "delete a virtualenv"
complete -f -c venv -s a -l activate -a "$venvs" -d "activate a virtualenv"
complete -f -c venv -s d -l deactivate -d "deactivate a virtualenv"
complete -f -c venv -a "$venvs" -d "virtualenv"
