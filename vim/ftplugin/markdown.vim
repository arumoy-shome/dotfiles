call aru#functions#plaintext()

call aru#autocomplete#deoplete_init()

setlocal synmaxcol=0

if bufname(bufnr('%')) == '__LanguageClient__'
  setlocal nonumber
  setlocal norelativenumber
endif

" NOTE: this shadows vim-slime but that's okay because I don't need it for md files
nmap <buffer> <C-c><C-c> :call aru#functions#toggle_task()<CR>

nnoremap <buffer> o o<Esc>:call aru#functions#auto_list(0)<CR>A
nnoremap <buffer> O O<Esc>:call aru#functions#auto_list(1)<CR>A
inoremap <buffer> <CR> <CR><Esc>:call aru#functions#auto_list(0)<CR>A
