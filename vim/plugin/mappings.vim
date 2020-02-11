nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

" <Leader>zz -- Zap trailing whitespace in the current buffer. As this one is
" somewhat destructive and relatively close to the oft-used <leader>a mapping,
" make this one a double key-stroke.
nnoremap <silent> <expr> <Leader>zz aru#mappings#leader#zap()
