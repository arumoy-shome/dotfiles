""""""""""""""
"  mappings  "
""""""""""""""
" default <S-CR> and <C-CR> is not distinguishable from <CR> by terminal vim
" <Leader>ws by default mapped to <Plug>VimwikiUISelect but I don't use it
" since I prefer to have a single directory for all my notes
nmap <silent><buffer> <Leader>ws <Plug>VimwikiSplitLink
nmap <silent><buffer> <Leader>wv <Plug>VimwikiVSplitLink
nmap <silent><buffer> <Leader>wn <Plug>VimwikiNextLink
nmap <silent><buffer> <Leader>wp <Plug>VimwikiPrevLink

call aru#spell()
