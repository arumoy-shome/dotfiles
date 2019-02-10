nmap <leader>so :source $MYVIMRC<CR>
nmap <leader>vr :vsp $MYVIMRC<CR>
nmap j gj
nmap k gk
nmap <C-p> :Files<CR>
nmap <leader>b :Buffers<CR>
nmap <leader>h :Helptags<CR>
nmap <leader>gg :Gstatus<CR>
nmap <leader>gc :Commits<CR>
nmap <leader>gp :Gpush origin master<CR>
nmap <leader>tl :set relativenumber!<CR>

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

noremap <silent> <Bar>   <Bar><Esc>:call aru#tabular#align()<CR>a
nnoremap \ :Ag!<CR>
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
