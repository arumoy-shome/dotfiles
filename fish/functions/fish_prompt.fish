function fish_prompt
    echo
    
    # redirect output to stdout and stderror to /dev/null
    # taken from fish documentation>syntax overview>i/o redirection
    jobs > /dev/null ^&1; and set job (set_color blue)'❯'(set_color normal)
    set suffix (set_color white)'❯'(set_color normal)

    printf '%s ' (set_color $fish_color_cwd)(basename (pwd))(set_color normal)
    printf '%s' $job
    printf '%s ' $suffix
end
