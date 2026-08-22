# vim: foldmethod=marker

# Shared with zsh. Must come first: it builds PATH, and everything below
# gates on `command -v`.
. "$HOME/.config/sh/rc"

#  settings {{{
HISTCONTROL=ignoreboth # no duplicates or lines starting with space in history
HISTSIZE=1000
HISTFILESIZE=2000
CDPATH="$HOME"
[[ -d "$HOME/code" ]] && CDPATH+=":$HOME/code"
[[ -d "$HOME/phd" ]] && CDPATH+=":$HOME/phd"
[[ -d "$HOME/Documents/phd" ]] && CDPATH+=":$HOME/Documents/phd"

shopt -s histappend   # append to history file, don't overwrite it.
shopt -s checkwinsize # [default] check window size after each command
shopt -s autocd       # .. for cd ..
shopt -s cdspell      # check minor file spell errors
shopt -s dirspell     # check minor dir spell errors
shopt -s direxpand
# }}}
# prompt {{{
# starship is handled by the shared rc; this is the fallback when it is
# absent.
if ! [[ -x "$(command -v starship)" ]]
then
  if [ -n "$SSH_CONNECTION" ]
  then
    export PS1="\u@\h: \w \$ "
  else
    export PS1="\w \$ "
  fi
fi
export PS2="> "
# }}}
# conda {{{
if [[ -x "$(command -v conda)" ]]
then
  eval "$(conda "shell.$(basename "${SHELL}")" hook)"
fi
# }}}

[[ -f $HOME/.bashrc.local  ]] && source $HOME/.bashrc.local
