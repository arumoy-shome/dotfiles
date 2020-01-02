" zoom/unzoom splits
nnoremap <leader>= :wincmd _<CR>:wincmd \|<CR>
nnoremap <leader>- :wincmd =<CR>

" quickly switch between the latest 2 files
nnoremap <leader><leader> <c-^>

" <Leader>zz -- Zap trailing whitespace in the current buffer.
"
"        As this one is somewhat destructive and relatively close to the
"        oft-used <leader>a mapping, make this one a double key-stroke.
nnoremap <silent> <Leader>zz :call aru#mappings#leader#zap()<CR>

" <LocalLeader>c -- Fix (most) syntax highlighting problems in current buffer
" (mnemonic: coloring).
nnoremap <silent> <LocalLeader>c :syntax sync fromstart<CR>

" <LocalLeader>d... -- Diff mode bindings:
" - <LocalLeader>dd: show diff view (mnemonic: [d]iff)
" - <LocalLeader>dh: choose hunk from left (mnemonic: [h] = left)
" - <LocalLeader>dl: show diff view (mnemonic: [l] = right)
nnoremap <silent> <LocalLeader>dd :Gvdiff<CR>
nnoremap <silent> <LocalLeader>dh :diffget //2<CR>
nnoremap <silent> <LocalLeader>dl :diffget //3<CR>
