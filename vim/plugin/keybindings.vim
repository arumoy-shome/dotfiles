nmap <leader>so :source $MYVIMRC<CR>
nmap <leader>vr :vsp $MYVIMRC<CR>
nmap j gj
nmap k gk

noremap <silent> <Bar>   <Bar><Esc>:call aru#autoloads#tabulerAlign()<CR>a
nnoremap <Tab> za
nnoremap <leader>= :wincmd _<CR>:wincmd \|<CR>
nnoremap <leader><leader> <c-^>
nnoremap <leader>- :wincmd =<CR>

nnoremap <M-h> <c-w>h
nnoremap <M-j> <c-w>j
nnoremap <M-k> <c-w>k
nnoremap <M-l> <c-w>l
if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <M-h> <c-\><c-n><c-w>h
  tnoremap <M-j> <c-\><c-n><c-w>j
  tnoremap <M-k> <c-\><c-n><c-w>k
  tnoremap <M-l> <c-\><c-n><c-w>l
endif
