function z -d "wrapper around EDITOR"
  test -z "$EDITOR"
    and echo "WARNING: EDITOR not set, using vim."
    and set EDITOR vim

  test -d "~/.vim/bundle/vimwiki/"
    and echo "WARNING: vimwiki not installed."

  test -r "~/vimwiki/inbox.wiki"
    or touch ~/vimwiki/inbox.wiki

  $EDITOR ~/vimwiki/inbox.wiki
end
