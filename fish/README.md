# fish

Install [fish](https://fishshell.com) and set it as the default shell.

## Highlights

1. A fast and clean prompt based off of [pure](https://github.com/sindresorhus/pure) that includes:
    - [left](https://github.com/arumoy-shome/dotfiles/blob/master/fish/functions/fish_prompt.fish): virtualenv if active, background job indicator (blue arrow) and prompt separator (white arrow) which turns red if the last exit status was not successful.
    - [right](https://github.com/arumoy-shome/dotfiles/blob/master/fish/functions/fish_right_prompt.fish): execution time of last command if it takes longer than 1 second, git branch + dirty indicator and finally shortened pwd.
2. A [git wrapper](https://github.com/arumoy-shome/dotfiles/blob/master/fish/functions/g.fish) exposed as a single function `g` which envokes `git status` when called without any arguments (inspired by [Thoughtbot dotfiles](https://github.com/thoughtbot/dotfiles/blob/master/zsh/functions/g)).
3. A [venv](https://github.com/arumoy-shome/dotfiles/blob/master/fish/functions/venv.fish) function to manage Python virtualenv.
4. a [tmux wrapper](https://github.com/arumoy-shome/dotfiles/blob/master/fish/functions/t.fish) exposed as a single function `t` which starts a tmux session with the basename of the current PWD as session name when no args are given. With args it passes them through to tmux.
