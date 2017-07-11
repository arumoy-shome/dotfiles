nmap <leader>so :source $MYVIMRC<CR>
nmap <leader>vr :vsp $MYVIMRC<CR>
nmap <silent> <Leader>h <Plug>(CommandTHelp)
nmap j gj
nmap k gk

inoremap <S-Tab> <c-n>
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
nnoremap 0 ^
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <Down> :echoe "Use j"<CR>
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <leader>- :wincmd _<CR>:wincmd \|<CR>
nnoremap <leader><leader> <c-^>
nnoremap <leader>= :wincmd =<CR>
nnoremap <silent> <Leader>a :TestSuite<CR>
nnoremap <silent> <Leader>l :TestLast<CR>
nnoremap <silent> <Leader>n :TestNearest<CR>
nnoremap <silent> <Leader>f :TestFile<CR>
nnoremap <silent> <leader>gt :TestVisit<CR>

" auto align for tabular
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
