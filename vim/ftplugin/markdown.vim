call aru#functions#plaintext()
call aru#autocomplete#deoplete_init()

setlocal synmaxcol=0
setlocal noexpandtab
setlocal shiftwidth=4
setlocal tabstop=4

if bufname(bufnr('%')) == '__LanguageClient__'
  setlocal nonumber
  setlocal norelativenumber
endif

" jump between sections
nnoremap <buffer> <silent> [[ ?\v^#+<CR>:noh<CR>
nnoremap <buffer> <silent> ]] /\v^#+<CR>:noh<CR>
