set -gx PATH '/Users/aru/.pyenv/shims' $PATH
set -gx PYENV_SHELL fish

source '/Users/aru/.config/pyenv/libexec/../completions/pyenv.fish'
command pyenv rehash 2>/dev/null
function pyenv
    set command $argv[1]
    set -e argv[1]

    switch "$command"
        case rehash shell
            source (pyenv "sh-$command" $argv|psub)
        case '*'
            command pyenv "$command" $argv
    end
end
