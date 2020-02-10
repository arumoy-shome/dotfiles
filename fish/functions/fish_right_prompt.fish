set -g __pure_new_session 1

function fish_right_prompt
  # skip right prompt line for near-instant initial load
  if test $__pure_new_session
    set -l cmd_duration (__pure_cmd_duration)
    if test -n "$cmd_duration"
      printf '%s' (set_color --italics yellow) $cmd_duration
    end

    set -l git_working_tree (command git rev-parse --show-toplevel 2>/dev/null)
    if test -n "$git_working_tree"
      __pure_git_fetch $git_working_tree
      __pure_git_update_workdir $git_working_tree
      printf ' %s' (set_color brblue) (__pure_git_info $git_working_tree)

      set -l git_arrows (__pure_git_arrows $git_working_tree)
      test -n "$git_arrows"; and printf '%s' (set_color brcyan) $git_arrows
      set -q __pure_fetching; and printf '%s' (set_color yellow) "•"
    end
  end

  printf ' %s' (set_color --italics blue)(prompt_pwd)(set_color normal)
  set __pure_new_session 0
end
