function g
    if test "$argv"
        command git $argv
    else
        command git status
    end
end
