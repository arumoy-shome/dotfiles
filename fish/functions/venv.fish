function venv -d "python virtualenv management"

  function _create_venv -d "create a new virtualenv"
    python3 -m venv venv

    _activate_venv

    if test -f requirements.txt
      pip install -r requirements.txt
    end
  end

  function _delete_venv -d "delete virtualenv"
    _deactivate_venv

    if test -d venv
      rm -rf venv
    end
  end

  function _deactivate_venv -d "deactivate current virtualenv"
    if test -n "$VIRTUAL_ENV"
      deactivate
    end

    if test -n "$TMUX"
      tmux set-environment -u VIRTUAL_ENV
    end
  end

  function _activate_venv -d "activate virtualenv if it exists"
    # fish does not allow command substitution in lists longer than 1
    # so we have so save the result of the command first
    set dir_basename (basename (pwd))
    set venv_names "env/" "venv/" "virtualenv/" "$dir_basename/"
    set listing (ls -d */ (pwd)) # list only directories

    for name in $venv_names
      contains $name $listing; and set venv_basename $name; and break
    end

    if test -n "$venv_basename"
      source $venv_basename/bin/activate.fish
      if test -n "$TMUX"
        tmux set-environment VIRTUAL_ENV $VIRTUAL_ENV
      end
    else
      echo "No virtualenv available in this directory."
    end
  end

  if not test -n "$argv"
    _activate_venv
  else
    switch $argv
      case create
        _create_venv
      case activate
        _activate_venv
      case deactivate
        _deactivate_venv
      case delete
        _delete_venv
      case '*'
        echo $argv is not a valid argument.
    end
  end
end
