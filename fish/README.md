# fish

Install [fish](https://fishshell.com) and set it as the default shell.

## Highlights

![prompt](../images/prompt-dark.png)

![prompt](../images/prompt-light.png)

1. A fast and clean prompt that includes the basename of current dir (left),
   background job indicator (blue arrow), git branch and untracked, modified &
   staged files indicated by color and finally shortened pwd (right)
2. A [git
   wrapper](https://github.com/arumoy-shome/dotfiles/blob/master/fish/functions/g.fish)
   exposed as a single function `g` which envokes `git status` when called
   without any arguments (inspired by [Thoughtbot
   dotfiles](https://github.com/thoughtbot/dotfiles/blob/master/zsh/functions/g))
3. Automatically `ls` after `cd`
4. a [colors
   function](https://github.com/arumoy-shome/dotfiles/blob/master/fish/functions/colors.fish)
   to quickly switch between a light and dark theme

## Dependencies

`colors` requires topic
[base16](https://github.com/arumoy-shome/dotfiles/tree/master/base16) to be enabled.
