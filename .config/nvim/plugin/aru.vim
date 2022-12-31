" leftovers from init.vim that I do not (yet) know how to convert to
" init.lua

" autocommands {{{

function! AruWindowAutocmds() abort
  " This function resizes all vim splits everytime the dimensions of
  " the terminal window changes. This is useful since I often bounce
  " my terminal window around. I do this using the VimResized
  " autocmd which fires the `wincmd =' command.
  augroup AruWindow
    autocmd!
    autocmd VimResized * wincmd =
  augroup END
endfunction
call AruWindowAutocmds()

function! AruHelptagsAutocmds() abort
  " This function generates helptags from all *.txt files under the
  " docs/ directories found in vim's runtimepath (:h rtp for
  " details). I do this using the VimEnter autocmd (:h VimEnter for
  " details) which fires the `helptags ALL' command.
  augroup AruHelptags
    autocmd!
    autocmd VimEnter * helptags ALL
  augroup END
endfunction
call AruHelptagsAutocmds()
" End autocommands }}}

" vim: foldmethod=marker
