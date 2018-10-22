function fish_prompt
    set last_status $status

    test $last_status -eq 0; and set -l suffix (set_color green)'❯'
    test $last_status -eq 1; and set -l suffix (set_color red)'❯'

    printf '%s' (set_color -i $fish_color_cwd)(basename (pwd))
    echo
    printf '%s ' $suffix
end
