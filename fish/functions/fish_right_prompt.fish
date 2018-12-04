function fish_right_prompt
    set -g __fish_git_prompt_describe_style default
    set -g __fish_git_prompt_showcolorhints true
    set -g __fish_git_prompt_showdirtystate true
    set -g __fish_git_prompt_showuntrackedfiles true
    set -g __fish_git_prompt_showupstream auto informative

    set -g __fish_git_prompt_char_dirtystate ●
    set -g __fish_git_prompt_char_stagedstate ●
    set -g __fish_git_prompt_char_untrackedfiles ●
    set -g __fish_git_prompt_char_invalidstate ✖
    set -g __fish_git_prompt_char_upstream_ahead ↑
    set -g __fish_git_prompt_char_upstream_behind ↓
    set -g __fish_git_prompt_char_upstream_diverged ↓↑
    printf '%s' (__fish_git_prompt)
end
