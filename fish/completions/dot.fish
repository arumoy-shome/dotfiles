set -l DOTDIR "$HOME/dotfiles"
test -d "$DOTDIR"; and set -l topics (find $DOTDIR -name '_init' -type f | sed -E 's|/_init$||' | sed -E 's@.*/@@')
complete -f -c dot -s h -l help -d 'print a helpful message'
complete -f -c dot -s L -l ls -d 'list enabled topics'
complete -f -c dot -s l -l link -a "$topics" -d 'link topics'
complete -f -c dot -s u -l unlink -a "$topics" -d 'unlink topics'
complete -f -c dot -s r -l relink -a "$topics" -d 'relink topics'
complete -f -c dot -s d -l delete -a "$topics" -d 'delete topics'
complete -f -c dot -a "$topics" -d 'install given topic'
