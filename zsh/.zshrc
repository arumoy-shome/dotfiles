#
# Config
#

for f in $ZDOTDIR/*.zsh; do source $f; done

#
# Autoloads
#

fpath=("$ZDOTDIR/functions" $fpath)

# NOTE: (double)quotes don't work here, probably because it's a glob pattern?
for f in $ZDOTDIR/functions/*; do autoload -U ${f:t}; done

#
# History
#

export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

#
# Others
#

# an alternative to looking up man pages for zsh builtins (similar to fish's help) from man zshcontrib(1)@56
# it is unaliased first since run-help is usually symlinked to man on most unix systems
unalias run-help && autoload -U run-help

#
# Plugins
#

[[ -d "$ZDOTDIR/zsh-syntax-highlighting" ]] && \
  source "$ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

[[ -d "$ZDOTDIR/zsh-autosuggestions" ]] && \
  source "$ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=59'

#
# prompt (stolen from radox502/radian)
#

# Enable parameter expansion and other substitutions in the $PROMPT.
setopt prompt_subst

# Load some associative arrays (color, fg, and bg) that give us
# convenient access to color-changing escape codes.
autoload -U colors && colors

# Here we define a prompt that displays the current directory and git
# branch, and turns red on a nonzero exit code. Adapted heavily from
# [1], with supporting functions extracted from Oh My Zsh [2] so that
# we don't have to load the latter as a dependency.
#
# [1]: https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/mgutz.zsh-theme
# [2]: https://github.com/robbyrussell/oh-my-zsh/blob/3705d47bb3f3229234cba992320eadc97a221caf/lib/git.zsh

# Display the user@hostname. Then change the color and display the
# working directory.
aru_prompt_prefix='%{$fg[yellow]%}{%n@%m} %(?.%{$fg[blue]%}.%{$fg[red]%})%c'

# Change the color and then display a '%' or '#', then reset the color
# for the user's input.
aru_prompt_suffix='%(?.%{$fg[blue]%}.%{$fg[red]%}) %# %{$reset_color%}'

PROMPT=

if (( $+commands[git] )); then

    # Usage: aru_prompt_git_dirty
    #
    # Print an asterisk if the working directory is dirty.
    function aru_prompt_git_dirty {
        emulate -LR zsh
        if [[ $(command git status --porcelain 2>/dev/null | tail -n1) ]]; then
            echo "*"
        fi
    }

    # Usage: aru_prompt_git_info
    #
    # If inside a Git repository, print the branch or abbreviated
    # revision of the current HEAD, surrounded by square brackets and
    # followed by an asterisk if the working directory is dirty.
    function aru_prompt_git_info {
        emulate -LR zsh
        local ref
        ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
            ref=$(command git rev-parse --short HEAD 2> /dev/null) || \
            return 0
        echo "[${ref#refs/heads/}$(aru_prompt_git_dirty)]"
    }

    # Reset the color and display the Git branch and modification
    # status.
    PROMPT='%{$reset_color%}$(aru_prompt_git_info)'

fi

PROMPT="${aru_prompt_prefix}${PROMPT}"
PROMPT="${PROMPT}${aru_prompt_suffix}"

# Base16 Shell (only when not in emacs)
[[ -r "$XDG_DATA_HOME/base16/current-theme.sh" ]] && \
    [[ $TERM != "eterm-color" ]] && \
    sh "$XDG_DATA_HOME/base16/current-theme.sh"

#
# hooks
#

# ls -FA after cd
autoload -U add-zsh-hook
add-zsh-hook -Uz chpwd (){ ls -FA; }
