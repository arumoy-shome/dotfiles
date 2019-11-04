call aru#functions#plaintext()

call aru#autocomplete#deoplete_init()

setlocal synmaxcol=0

if bufname(bufnr('%')) == '__LanguageClient__'
  setlocal nonumber
  setlocal norelativenumber
endif

" NOTE: this shadows vim-slime but that's okay because I don't need it for md files
nmap <buffer> <C-c><C-c> :call aru#functions#toggle_task()<CR>

imap <buffer> <CR> <CR><Esc>:call aru#functions#auto_list()<CR>A
