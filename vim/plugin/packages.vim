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

""""""""""""""""
"  indentLine  "
""""""""""""""""
let g:indentLine_fileTypeExclude=[
    \ 'help',
    \ 'markdown',
    \ 'tex',
    \ 'man',
    \ 'vimwiki',
    \ 'gitcommit',
    \ 'nerdtree',
    \ 'fzf'
    \ ]

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

"""""""""""""
"  vimwiki  "
"""""""""""""
" turn this off until a suitable solution to resolve conflict with ultisnips
" is figured out, snippets are far more useful than tables!
let g:vimwiki_table_mappings   = 0       " disable table mappings
let g:vimwiki_folding          = 'expr'  " fold at headers
let g:vimwiki_listsyms         = ' ○◐●✓' " 0-100% task completion symbols
let g:vimwiki_listsym_rejected = '✗'     " cancelled task symbol
let g:vimwiki_use_calendar     = 0       " don't use calendar.vim

" quickly capture stuff
if filereadable(expand('~/vimwiki/inbox.wiki'))
  nmap <Leader><Leader> :12split ~/vimwiki/inbox.wiki<CR>
endif
if filereadable(expand('~/vimwiki/bujo.wiki'))
  nmap <Leader>j :split +/Today ~/vimwiki/bujo.wiki<CR>
endif

" additionally set some things up for these files
augroup AruPackages
  autocmd!
  autocmd BufRead ~/vimwiki/inbox.wiki call aru#vimwiki_setup_special_buffer('inbox')
  autocmd BufRead ~/vimwiki/bujo.wiki call aru#vimwiki_setup_special_buffer('bujo')
augroup END

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
  \ },
  \ "venv/|requirements.txt": {
  \   "*.py": {
  \     "type": "code",
  \     "alternate": ["tests/test_{basename}"]
  \   },
  \   "tests/test_*.py": {
  \     "type": "test",
  \     "alternate": ["{project|basename}/{}.py"]
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
