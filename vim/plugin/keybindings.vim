nmap <leader>so :source $MYVIMRC<CR>
nmap <leader>vr :vsp $MYVIMRC<CR>

nnoremap <leader>= :wincmd _<CR>:wincmd \|<CR>
nnoremap <leader><leader> <c-^>
nnoremap <leader>- :wincmd =<CR>

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
endif
