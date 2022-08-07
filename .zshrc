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
# NOTE make sure to install using brew prior to sourcing
prompt pure
# End prompt }}}

# {{{ exports
if [[ -x "$(command -v nvim)" ]]; then
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

# plugins {{{
# zsh-syntax-highlighting
# NOTE must be the last plugin installed
# NOTE make sure to install using brew prior to sourcing
# NOTE zsh-history-substring should be the last plugin
# <https://github.com/zsh-users/zsh-history-substring-search#usage>

# early return if we are not operating in xterm
[[ "$TERM" =~ 'dumb' ]] && exit

plugins=(
    "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
    "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
    "$(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh"
)


for plugin in $plugins; do
    [[ -e $plugin ]] && source $plugin
done

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

if [[ -x "$(command -v fzf)" ]]; then

    # uncomment to enable default keybindings
    # [[ -f "$HOME/.fzf.zsh" ]] &&
	# source "$HOME/.fzf.zsh"

    if [[ -x "$(command -v fd)" ]]; then
	export FZF_DEFAULT_COMMAND="fd --type f --hidden --no-ignore --exclude '.git'"
    else
	export FZF_DEFAULT_COMMAND="find . -type f -not -path '*git*'"
    fi
fi
# end plugins }}}

# vim: foldmethod=marker
