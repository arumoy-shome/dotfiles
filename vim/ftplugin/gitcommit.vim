if has('folding')
  setlocal nofoldenable
endif

call aru#functions#spell()

" This slows down initialization but it's too damn useful not to have it right
" from the start.
call aru#autocomplete#deoplete_init()

" abort commit
nmap <buffer> <silent> q :bdel!<CR>
