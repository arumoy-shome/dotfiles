function activate -d "mirror the deactivate function provided by virtualenv"
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
    else
        echo "No virtualenv available in this directory."
    end
end
