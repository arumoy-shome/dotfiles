# bash-completion lives in a different place on every platform; source the
# first one that exists.
completions=(
  "/usr/share/bash-completion/bash_completion"        # debian derivatives
  "/etc/profile.d/bash_completion.sh"                 # debian derivatives
  "/opt/homebrew/etc/profile.d/bash_completion.sh"    # homebrew, arm
  "/usr/local/etc/profile.d/bash_completion.sh"       # homebrew, intel
)

for c in "${completions[@]}"; do
  if [[ -r "$c" ]]; then
    . "$c"
    break
  fi
done

[[ -f $HOME/.bashrc ]] && source $HOME/.bashrc
