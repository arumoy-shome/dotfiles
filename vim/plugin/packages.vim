" vim: foldmethod=marker

" loupe {{{1
let g:LoupeCenterResults = 0     " do not center current match
" following settings are set to reasonable defaults by loupe
" 'history'
" 'hlsearch'
" 'incsearch'
" 'ignorecase'
" 'shortmess'
" 'smartcase'
" }}}

" Ultisnips {{{1
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
let g:UltiSnipsEditSplit = "horizontal"
" my default, ultisnips checks for snippets recursively in rtp, being explicit
" here prevents it from doing so giving a little performace boost albeit now
" snippets need to be managed manually.
let g:UltiSnipsSnippetDirectories = [$HOME . '/.vim/snips']
" }}}

" vim-projectionist {{{1
let g:projectionist_heuristics = {
  \ "after/|autoload/|plugin/|ftplugin/|ftdetect/": {
  \   "plugin/*.vim": {
  \     "type": "plug",
  \     "alternate": ["autoload/{}.vim", "after/plugin/{}.vim"]
  \   },
  \   "autoload/*.vim": {
  \     "type": "autoload",
  \     "alternate": ["plugin/{}.vim", "after/plugin/{}.vim"]
  \   },
  \   "after/plugin/*.vim": {
  \     "type": "after",
  \     "alternate": ["plugin/{}.vim", "autoload/{}.vim"]
  \   },
  \   "ftplugin/*.vim": {
  \     "type": "ftplug"
  \   }
  \ }
  \}
" }}}

" vim-test {{{1
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
let test#strategy = "dispatch"
" }}}

"  vimtex {{{1
let g:tex_flavor = 'latex'
let g:vimtex_quickfix_mode = 0
let g:vimtex_fold_enabled = 1
" }}}

" vim-easy-align {{{1
vmap <Enter> <Plug>(EasyAlign)
" NOTE: this shadows builtin ga, use :ascii instead
nmap ga <Plug>(EasyAlign)
" }}}

" vim-pandoc {{{1
""""""""""""""""
let g:pandoc#formatting#mode = 'hA' " use hard wraps
let g:pandoc#folding#fdc = 0 " do not enable foldcolumn
let g:pandoc#formatting#textwidth = 70
let g:pandoc#spell#enabled = 0
let g:pandoc#modules#disabled = ['command', 'templates', 'menu', 'bibliographies', 'complete', 'spell']
" }}}

" vim-pandoc-syntax {{{1
let g:pandoc#syntax#conceal#use = 0 " do not use conceal
" }}}
" goyo.vim {{{
" turn off my custom autocmds when entering goyo and subsequently turn
" then back of when leaving goyo
function! s:goyo_enter() abort
  autocmd! AruStatusline
  autocmd! AruWindow
endfunction

function! s:goyo_leave() abort
  call AruStatuslineAutocmds()
  call AruWindowAutocmds()
  call aru#focus_statusline()
  call aru#statusline_update()
endfunction

augroup AruGoyo
  autocmd!
  autocmd User GoyoEnter nested call <SID>goyo_enter()
  autocmd User GoyoLeave nested call <SID>goyo_leave()
augroup END
" }}}
