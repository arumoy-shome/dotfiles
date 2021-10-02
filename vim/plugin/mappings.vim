" vim: foldmethod=marker

" normal {{{
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <Tab> zr
nmap <S-Tab> zm

" use the linenumber variant of corresponding commands
" by default <C-w>gt and <C-w>gT map to gt and gT respectively so they can be
" put to better use.
nmap gf gF
nmap <C-w>f <C-w>F
nmap <C-w><C-f> <C-w>F
nmap <C-w>gf <C-w>gF

" Zap trailing whitespace in the current buffer. As this one is
" somewhat destructive and relatively close to the oft-used <leader>a mapping,
" make this one a double key-stroke.
nmap <silent> <expr> <Leader>zz aru#mappings#leader#zap()
" end normal }}}

" insert {{{
inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')
" end insert }}}

