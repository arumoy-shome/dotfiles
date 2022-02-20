function! AruWindowAutocmds() abort
  augroup AruWindow
    autocmd!
    autocmd VimResized * wincmd =
  augroup END
endfunction
call AruWindowAutocmds()

function! AruYankAutocmds() abort
  augroup AruYank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank({higroup = 'Search'})
  augroup END
endfunction
call AruYankAutocmds()
