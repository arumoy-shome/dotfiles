nmap <leader>so :source $MYVIMRC<CR>
nmap <leader>vr :vsp $MYVIMRC<CR>
nmap j gj
nmap k gk

noremap <silent> <Bar>   <Bar><Esc>:call aru#autoloads#tabulerAlign()<CR>a
nnoremap <leader>= :wincmd _<CR>:wincmd \|<CR>
nnoremap <leader><leader> <c-^>
nnoremap <leader>- :wincmd =<CR>

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif
