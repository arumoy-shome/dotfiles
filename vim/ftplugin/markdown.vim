call aru#functions#plaintext()
call aru#autocomplete#deoplete_init()
call aru#functions#use_four_spaces()

setlocal synmaxcol=0

if bufname(bufnr('%')) == '__LanguageClient__'
  setlocal nonumber
  setlocal norelativenumber
endif

" jump between sections
nnoremap <buffer> <silent> [[ ?\v^#+<CR>:noh<CR>
nnoremap <buffer> <silent> ]] /\v^#+<CR>:noh<CR>
