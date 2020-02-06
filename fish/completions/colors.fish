set -l BASE "$FDOTDIR/base16-shell/scripts"
set -l SCHEMES (find "$BASE" -name 'base16-*.sh' | sed -E 's|.+/base16-||' | sed -E 's/\.sh//')
complete -f -c colors -a "$SCHEMES help ls"
