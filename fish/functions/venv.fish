function venv -d "python virtualenv management"

  function _create_venv -a venv -d "create a new virtualenv"
    test -n "$venv"; or set venv 'venv'

    if test ! -d "$venv"
      python3 -m venv "$venv"; and _activate_venv "$venv"
      test -f requirements.txt; and pip install -r requirements.txt
    else
      echo "Directory $venv already exists."
    end
  end

  function _delete_venv -a venv -d "delete virtualenv"
    test -n "$venv"; or set venv 'venv'

    _deactivate_venv

    if test -d "$venv"
      echo "Deleting virtualenv $venv"
      rm -rf "$venv"
    else
      echo "No virtualenv available in this directory."
    end
  end

  function _deactivate_venv -d "deactivate current virtualenv"
    if test -n "$VIRTUAL_ENV"
      echo "Deactivating virtualenv $VIRTUAL_ENV."
      deactivate
      test -n "$TMUX"; and tmux set-environment -u VIRTUAL_ENV
    end
  end

  function _activate_venv -a venv -d "activate virtualenv if it exists"
    set script venv/bin/activate.fish
    test -n "$venv"; and set script "$venv/bin/activate.fish"

    if test -r "$script"
      echo "Activating virtualenv $script."
      source "$script"
      test -n "$TMUX"; and tmux set-environment VIRTUAL_ENV "$VIRTUAL_ENV"
    else
      echo "No virtualenv available in this directory."
    end
  end

  argparse --name venv --exclusive 'c,a,d,D' 'c/create=?' 'a/activate=?' 'd/deactivate' 'D/delete=?' -- $argv
    or return

  if set -q _flag_c
    _create_venv $argv
  else if set -q _flag_a
    _activate_venv $argv
  else if set -q _flag_d
    _deactivate_venv
  else if set -q _flag_D
    _delete_venv $argv
  else
    _activate_venv $argv
  end
end
