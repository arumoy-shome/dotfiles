function z -d "wrapper around EDITOR"
  test -z "$EDITOR"
    and echo "ERROR: EDITOR not set."
    and return 1

  test -d ~/.vim/bundle/vimwiki/
    and echo "ERROR: vimwiki not installed."
    and return 1

  $EDITOR -c VimwikiMakeDiaryNote $argv
end
