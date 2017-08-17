nmap <leader>so :source $MYVIMRC<CR>
nmap <leader>vr :vsp $MYVIMRC<CR>
nmap j gj
nmap k gk
nmap <C-p> :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>h :Helptags<CR>

noremap <silent> <Bar>   <Bar><Esc>:call aru#tabular#align()<CR>a
nnoremap \ :Ag<CR>
nnoremap <Tab> za
nnoremap 0 ^
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <Down> :echoe "Use j"<CR>
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <leader>= :wincmd _<CR>:wincmd \|<CR>
nnoremap <leader><leader> <c-^>
nnoremap <leader>- :wincmd =<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>n :TestNearest<CR>
nnoremap <silent> <Leader>f :TestFile<CR>
nnoremap <silent> <leader>gt :TestVisit<CR>
