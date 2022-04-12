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
if (( $+commands[nvim] )); then
  export EDITOR=nvim
else
  export EDITOR=vim
fi

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
alias vim="$EDITOR" # nvim when available else vim (see exports)
alias mkdir="mkdir -p"
if (( $+commands[emacs] )); then
  alias e="emacsclient --alternate-editor '' --no-wait --quiet"
  alias E="emacsclient --alternate-editor ''  --no-wait --quiet --create-frame"
fi
alias grep='grep -inE --color' # --case-insensitive --line-number --extended-regexp
alias rgrep='grep -inE --color --exclude-dir ".git" -R' # --recursive

alias -s pdf='open -a "PDF Expert.app"'
alias -s html='open -a "Firefox.app"'
# End alias }}}

# {{{ path
[[ -d "$HOME/dotfiles/bin" ]] &&
  path=($path "$HOME/dotfiles/bin")
# End path }}}

# vim: foldmethod=marker
