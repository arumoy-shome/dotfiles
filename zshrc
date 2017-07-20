# source zplug
source ~/.zplug/init.zsh
zplug "mafredri/zsh-async"
zplug "sindresorhus/pure", use:pure.zsh, as:theme
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "ggustafsson/Tim", as:command, use:tim
zplug load

# source /configs
for zsh_source in $HOME/.zsh/configs/*.zsh; do
  source $zsh_source
done
