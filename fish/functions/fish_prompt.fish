function fish_prompt
  set last_status $status

  echo

  # root or ssh session
  set -l uid (id -u)
  if test \( $uid -eq 0 -o -n "$SUDO_USER" \) -o -n "$SSH_CONNECTION"
    echo -sn (set_color brblue) $USER "@" (command hostname) " "
  end

  test -n "$VIRTUAL_ENV"; and printf '%s ' (set_color --italics blue)(basename $VIRTUAL_ENV)
  jobs -q; and printf '%s' (set_color yellow) "❯"
  set prompt_color (set_color brblue)
  test $last_status -ne 0; and set prompt_color (set_color red)
  printf '%s' $prompt_color "❯ " (set_color normal)
end
