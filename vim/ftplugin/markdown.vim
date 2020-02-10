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
