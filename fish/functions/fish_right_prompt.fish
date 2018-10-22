function fish_right_prompt
    set -g __fish_git_prompt_describe_style default
    set -g __fish_git_prompt_showcolorhints true
    set -g __fish_git_prompt_showdirtystate true
    printf '%s' (__fish_git_prompt)
end
