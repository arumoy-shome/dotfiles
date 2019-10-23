abbr -a py "python"
abbr -a ipy "ipython"
abbr -a jp "jupyter"

# do not modify prompt when virtualenv is active, I will do it myself
set -gx VIRTUAL_ENV_DISABLE_PROMPT false

if test -n "$VIRTUAL_ENV"
  source $VIRTUAL_ENV/bin/activate.fish
end
