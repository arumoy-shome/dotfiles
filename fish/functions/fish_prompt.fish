function fish_prompt
    echo
    set last_status $status

    # redirect output to stdout and stderror to /dev/null
    # taken from fish documentation>syntax overview>i/o redirection
    jobs > /dev/null ^&1; and set -l job (set_color blue)'❯'
    test $last_status -eq 0; and set suffix (set_color white)'❯'
    test $last_status -eq 1; and set suffix (set_color red)'❯'

    printf '%s' (set_color $fish_color_cwd)(basename (pwd))
    echo
    printf '%s' $job
    printf '%s ' $suffix
end
