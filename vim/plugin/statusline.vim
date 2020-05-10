" \  :  literal <space>
" %m :  modified flag
" %2*:  switch to User2 highlight
" %f :  file name relative to CWD
" %* :  reset highlight group
" %< :  truncate point
" %= :  right align items hence forth
" %y :  filetype
" %r :  readonly flag
" %l :  line number
" %L :  total lines in buffer
" %P :  percentage and position in buffer
set statusline=\ %m\ %2*%f%*%<%=%y%r\ %l:%L:%P\ 

augroup AruStatusline
  autocmd!
  autocmd ColorScheme * call aru#statusline_update_highlight()
augroup END

set tabline=%!aru#tabline()
