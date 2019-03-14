function g -d "without arguments call hub status else delegate to hub"
    if test "$argv"
        command hub $argv
    else
        command hub status
    end
end
