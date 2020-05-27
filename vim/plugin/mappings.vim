""""""""""""
"  normal  "
""""""""""""

nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
nmap <Tab> za

" use the linenumber variant of corresponding commands
" by default <C-w>gt and <C-w>gT map to gt and gT respectively so they can be
" put to better use.
nmap gf gF
nmap <C-w>f <C-w>F
nmap <C-w><C-f> <C-w>F
nmap <C-w>gf <C-w>gF

""""""""""""
"  leader  "
""""""""""""

" Zap trailing whitespace in the current buffer. As this one is
" somewhat destructive and relatively close to the oft-used <leader>a mapping,
" make this one a double key-stroke.
nmap <silent> <expr> <Leader>zz aru#mappings#leader#zap()

""""""""""""
"  insert  "
""""""""""""

imap <C-n> <C-n><C-p>
imap <C-p> <C-p><C-p>
imap <C-x><C-f> <C-x><C-f><C-p>
imap <C-x><C-v> <C-x><C-v><C-p>
imap <C-x><C-k> <C-x><C-k><C-p>
imap <C-x><C-o> <C-x><C-o><C-p>
imap <C-x><C-]> <C-x><C-]><C-p>

