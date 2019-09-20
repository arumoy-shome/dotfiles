" vim-abolish
call aru#defer#defer('call aru#plugins#abolish()')

" vim-javascript
let g:jsx_ext_required = 0

" vim-test
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

let test#strategy = "vtr"

" tmux-runner
let g:VtrUseVtrMaps = 1

"vimtex
let g:tex_flavor = 'latex'
let g:vimtex_quickfix_mode = 0
let g:vimtex_view_method = 'skim'

"tex-conceal
let g:tex_conceal="abdgm"

"indentline
" indentline does not play well in latex files so here I tell it to not change
" the conceal settings automatically and set them explicitely myself then I can
" overwrite these settigns for tex files
let g:indentLine_setConceal = 0
set concealcursor=inc
set conceallevel=2
