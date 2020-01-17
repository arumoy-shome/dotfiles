" don't allow me to modify head and remote buffers
" this way I can only modify the center buffer during a 3 way merge
augroup AruFugitive
  autocmd!
  autocmd BufReadPost fugitive:///*//2/*,fugitive:///*//3/* setlocal nomodifiable readonly
augroup AruFugitive

set tags^=./.git/tags; " from fugitive error message
