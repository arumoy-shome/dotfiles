function fish_right_prompt
    # Allow for compatibility between fish 2.7 and 3.0
    set -l command_duration "$CMD_DURATION$cmd_duration"
    set -l human_command_duration (echo $command_duration | _util_human_time)
    # show exec time only when greater than max_time_elapsed
    set -l max_time_elapsed 1

    set -g __fish_git_prompt_describe_style default
    set -g __fish_git_prompt_showcolorhints true
    set -g __fish_git_prompt_showdirtystate true
    set -g __fish_git_prompt_showuntrackedfiles true

    set -g __fish_git_prompt_char_dirtystate ●
    set -g __fish_git_prompt_char_stagedstate ●
    set -g __fish_git_prompt_char_untrackedfiles ●
    set -g __fish_git_prompt_char_invalidstate ✖

    if test -n "$command_duration" -a "$command_duration" -gt (math "$max_time_elapsed * 1000")
        printf '%s' (set_color --italics yellow)$human_command_duration(set_color normal)
    end

    printf '%s' (__fish_git_prompt)
    printf ' %s' (prompt_pwd)
end

# taken from https://github.com/matchai/spacefish
function _util_human_time -d "Humanize a time interval for display"
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
