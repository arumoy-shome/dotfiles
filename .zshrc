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
[[ -d "$HOME/Documents/phd" ]] && cdpath+=("$HOME/Documents/phd")
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
alias -s md='glow --pager --width 70'
alias neovide='neovide --frame=none'
# End alias }}}

# {{{ path
paths=(
  "$HOME/dotfiles/bin"
  "$HOME/.emacs.d/bin"
  "/usr/local/opt/coreutils/libexec/gnubin"
)

for p in $paths; do
  [[ -d $p ]] && path=($p $path)
done

# End path }}}

# plugins {{{
# zsh-syntax-highlighting
# NOTE must be the last plugin installed
# NOTE make sure to install using brew prior to sourcing
# NOTE zsh-history-substring should be the last plugin
# <https://github.com/zsh-users/zsh-history-substring-search#usage>

# load plugins if not in dumb terminal
if [[ ! "$TERM" =~ 'dumb' ]]; then

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

  if [[ -x "$(command -v direnv)" ]]; then
    eval "$(direnv hook zsh)"
  fi

  # starship prompt when the terminal supports it
  # NOTE make sure to install using brew prior to sourcing
  eval "$(starship init zsh)"
fi

# end plugins }}}

# hooks {{{
autoload -U add-zsh-hook

function -set-tab-and-window-title() {
  emulate -L zsh
  local CMD="${1:gs/$/\\$}"
  print -Pn "\e]0;$CMD:q\a"
}

# $HISTCMD (the current history event number) is shared across all shells
# (due to SHARE_HISTORY). Maintain this local variable to count the number of
# commands run in this specific shell.
HISTCMD_LOCAL=0

# Executed before displaying prompt.
function -update-window-title-precmd() {
  emulate -L zsh
  if [[ HISTCMD_LOCAL -eq 0 ]]; then
    # About to display prompt for the first time; nothing interesting to show in
    # the history. Show $PWD.
    -set-tab-and-window-title "$(basename $PWD)"
  else
    local LAST=$(history | tail -1 | awk '{print $2}')
    if [ -n "$TMUX" ]; then
      # Inside tmux, just show the last command: tmux will prefix it with the
      # session name (for context).
      -set-tab-and-window-title "$LAST"
    else
      # Outside tmux, show $PWD (for context) followed by the last command.
      -set-tab-and-window-title "$(basename $PWD) > $LAST"
    fi
  fi
}

# Executed before executing a command: $2 is one-line (truncated) version of
# the command.
function -update-window-title-preexec() {
  emulate -L zsh
  setopt EXTENDED_GLOB
  HISTCMD_LOCAL=$((++HISTCMD_LOCAL))

  # Skip ENV=settings, sudo, ssh; show first distinctive word of command;
  # mostly stolen from:
  #   https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/termsupport.zsh
  local TRIMMED="${2[(wr)^(*=*|mosh|ssh|sudo)]}"
  if [ -n "$TMUX" ]; then
    # Inside tmux, show the running command: tmux will prefix it with the
    # session name (for context).
    -set-tab-and-window-title "$TRIMMED"
  else
    # Outside tmux, show $PWD (for context) followed by the running command.
    -set-tab-and-window-title "$(basename $PWD) > $TRIMMED"
  fi
}

if [[ ! "$TERM" =~ 'dumb' ]]; then
  add-zsh-hook preexec -update-window-title-preexec
  add-zsh-hook precmd -update-window-title-precmd
fi

# }}}

# vim: foldmethod=marker ts=2 sw=2 et
