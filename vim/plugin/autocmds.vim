function! AruWindowAutocmds() abort
  augroup AruWindow
    autocmd!
    autocmd VimResized * wincmd =
  augroup END
endfunction
call AruWindowAutocmds()
