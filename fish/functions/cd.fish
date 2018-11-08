function cd -d "do a ls after cd"
    builtin cd $argv; and ls
end
