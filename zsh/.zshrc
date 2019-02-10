# source zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "mafredri/zsh-async"
zplug "sindresorhus/pure", use:pure.zsh, as:theme
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "chriskempson/base16-shell", as:command
zplug load

# source /configs
for config in $HOME/.config/zsh/configs/*.zsh; do
  source $config
done

# source /functions
for function in $HOME/.config/zsh/functions/*.zsh; do
  source $function
done

# source /completions
for completion in $HOME/.config/zsh/completions/*.zsh; do
  source $completion
done
