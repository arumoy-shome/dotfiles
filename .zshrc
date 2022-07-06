# {{{ history
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# End history }}}

# {{{ options
setopt autocd
unsetopt beep

cdpath=($HOME)
[[ -d "$HOME/code" ]] && cdpath+=("$HOME/code")
[[ -d "$HOME/Documents" ]] && cdpath+=("$HOME/Documents")
# End options}}}

# {{{ keybindings
bindkey -e
# End keybindings }}}

# {{{ completion
zstyle :compinstall filename '/Users/aru/.zshrc'

autoload -Uz compinit
compinit
# End completion }}}

# {{{ prompt
autoload -Uz promptinit
promptinit
prompt walters
# End prompt }}}

# {{{ exports
export EDITOR=vim
export CLICOLOR=true # color in ls output without -G, works across shells
export LC_ALL=en_GB.UTF-8
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_BIN="$HOME/.local/bin"
# End exports }}}

# {{{ alias
alias cp='cp -v'
alias mv='mv -v'
alias rm='rm -v'
alias ls="ls -FA"
alias ll="ls -FAlrh"
alias ln="ln -v"
alias mkdir="mkdir -p"
if (( $+commands[emacs] )); then
  alias e="emacsclient -nw --alternate-editor '' --quiet"
  alias E="emacsclient --alternate-editor ''  --no-wait --quiet --create-frame"
fi
alias grep='grep --ignore-case --line-number --extended-regexp --color'
alias rgrep='grep --ignore-case --line-number --extended-regexp --color --exclude-dir ".git" --recursive'

alias -s pdf='open -a "PDF Expert.app"'
alias -s html='open -a "Firefox.app"'
# End alias }}}

# {{{ path
[[ -d "$HOME/dotfiles/bin" ]] &&
  path=($path "$HOME/dotfiles/bin")
# End path }}}

# vim: foldmethod=marker
