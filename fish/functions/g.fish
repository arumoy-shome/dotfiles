function g -d "without arguments call git status else delegate to git"
    if test "$argv"
        command git $argv
    else
        command git status
    end
end
