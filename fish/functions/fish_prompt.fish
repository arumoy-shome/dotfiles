function fish_prompt
    set -g last_status $status
    echo

    # redirect output to stdout and stderror to /dev/null
    # taken from fish documentation>syntax overview>i/o redirection
    jobs > /dev/null ^&1; and set job (set_color blue)'❯'(set_color normal)

    # although $status has the same scope, it can't be used to do this check
    if test $last_status -eq 0
      set suffix (set_color white)'❯'(set_color normal)
    else
      set suffix (set_color red)'❯'(set_color normal)
    end

    printf '%s ' (set_color $fish_color_cwd)(basename (pwd))(set_color normal)
    printf '%s' $job
    printf '%s ' $suffix
end
