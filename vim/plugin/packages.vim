"""""""""""
"  loupe  "
"""""""""""
let g:LoupeCenterResults = 0     " do not center current match
" following settings are set to reasonable defaults by loupe
" 'history'
" 'hlsearch'
" 'incsearch'
" 'ignorecase'
" 'shortmess'
" 'smartcase'

"""""""""""""""
"  Ultisnips  "
"""""""""""""""
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
let g:UltiSnipsEditSplit = "horizontal"
" my default, ultisnips checks for snippets recursively in rtp, being explicit
" here prevents it from doing so giving a little performace boost albeit now
" snippets need to be managed manually.
let g:UltiSnipsSnippetDirectories = [$HOME . '/.vim/snips']

"""""""""""""""""""""""
"  vim-projectionist  "
"""""""""""""""""""""""
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

""""""""""""""
"  vim-test  "
""""""""""""""
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
let test#strategy = "dispatch"

""""""""""""
"  vimtex  "
""""""""""""
let g:tex_flavor = 'latex'
let g:vimtex_quickfix_mode = 0

""""""""""""""""""""
"  vim-easy-align  "
""""""""""""""""""""
vmap <Enter> <Plug>(EasyAlign)
" NOTE: this shadows builtin ga, use :ascii instead
nmap ga <Plug>(EasyAlign)

"""""""""""""""
"  vim-slime  "
"""""""""""""""
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}

"""""""""""
"  ctrlp  "
"""""""""""
let g:ctrlp_show_hidden=1
nmap <leader>b :CtrlPBuffer<CR>
