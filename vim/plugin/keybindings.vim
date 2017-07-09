nmap <leader>so :source $MYVIMRC<CR>
nmap <leader>vr :vsp $MYVIMRC<CR>
nmap j gj
nmap k gk

inoremap <S-Tab> <c-n>
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
nnoremap 0 ^
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <Down> :echoe "Use j"<CR>
nnoremap <Leader>r :RunInInteractiveShell<space>
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <leader>- :wincmd _<CR>:wincmd \|<CR>
nnoremap <leader><leader> <c-^>
nnoremap <leader>= :wincmd =<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>s :TestNearest<CR>
nnoremap <silent> <Leader>t :TestFile<CR>
nnoremap <silent> <leader>gt :TestVisit<CR>
