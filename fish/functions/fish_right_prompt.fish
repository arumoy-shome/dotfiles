# taken from https://github.com/matchai/spacefish
function __util_human_time -d "Humanize a time interval for display"
    command awk '
    function hmTime(time,   stamp) {
    split("h:m:s:ms", units, ":")
    for (i = 2; i >= -1; i--) {
    if (t = int( i < 0 ? time % 1000 : time / (60 ^ i * 1000) % 60 )) {
    stamp = stamp t units[sqrt((i - 2) ^ 2) + 1] " "
    }
    }
    if (stamp ~ /^ *$/) {
    return "0ms"
    }
    return substr(stamp, 1, length(stamp) - 1)
    }
    {
    print hmTime($0)
    }
    '
end

# from oh-my-fish/plugin-vcs
function __vcs_present
  type -q git; or return 1
  test -d .git; and return 0
end

function __vcs_branch
  command git symbolic-ref --short HEAD 2>/dev/null
    or command git show-ref --head -s --abbrev | head -n1 2>/dev/null
end

function __vcs_dirty
  not command git diff --no-ext-diff --quiet --exit-code 2>/dev/null
end

function __vcs_staged
  not command git diff --cached --no-ext-diff --quiet --exit-code
end

function __vcs_untracked
  not command git diff-index --cached --quiet HEAD -- >/dev/null 2>&1
  or not command git diff --no-ext-diff --quiet --exit-code >/dev/null 2>&1
end

function __vcs_stashed
  command git rev-parse --verify --quiet refs/stash 2>/dev/null
end

function fish_right_prompt
    # Allow for compatibility between fish 2.7 and 3.0
    set -l command_duration "$CMD_DURATION$cmd_duration"
    set -l human_command_duration (echo $command_duration | __util_human_time)
    # show exec time only when greater than max_time_elapsed
    set -l max_time_elapsed 1
    set -l vcs

    if test -n "$command_duration" -a "$command_duration" -gt (math "$max_time_elapsed * 1000")
        printf '%s' (set_color --italics yellow)$human_command_duration(set_color normal)
    end

    if __vcs_present
      set vcs (printf '[%s' (__vcs_branch))
      __vcs_dirty; and set vcs $vcs(printf '%s' (set_color red)●(set_color normal))
      __vcs_staged; and set vcs $vcs(printf '%s' (set_color blue)●(set_color normal))
      __vcs_untracked; and set vcs $vcs(printf '%s' (set_color green)●(set_color normal))
      __vcs_stashed; and set vcs $vcs(printf '%s' (set_color yellow)●(set_color normal))
      set vcs $vcs']'
    end

    printf ' %s' $vcs
    printf ' %s' (set_color blue)(prompt_pwd)(set_color normal)
end
