function g
    if test "$argv"
        command hub $argv
    else
        command hub status
    end
end
