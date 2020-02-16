"""""""""
"  fzf  "
"""""""""
nnoremap <C-p> :Files<CR>
nnoremap <leader>h :Helptags<CR>
nnoremap <leader>b :Buffers<CR>

"""""""""""""
"  ycm  "
"""""""""""""
let g:ycm_python_interpreter_path = expand('~/.vim/venv/bin/python')
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
    \ 'g:ycm_python_interpreter_path',
    \ 'g:ycm_python_sys_path'
    \ ]
let g:ycm_global_ycm_extra_conf = expand('~/.vim/global_extra_conf.py')
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_key_list_select_completion = ['C-n']
let g:ycm_key_list_previous_completion = ['C-p']
let g:ycm_filetype_blacklist = {
    \ 'nerdtree': 1,
    \ 'notes':    1,
    \ 'tagbar':   1,
    \ 'netrw':    1,
    \ 'unite':    1,
    \ 'infolog':  1,
    \ 'leaderf':  1,
    \ 'git':      1,
    \ 'fugitive': 1,
    \ 'vimwiki': 1,
    \ 'markdown': 1,
    \ }

augroup AruYcm
  autocmd!
  autocmd CursorHold,CursorHoldI * call plug#load('YouCompleteMe')
    \ | autocmd! AruYcm
augroup END

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
    \ 'nerdtree'
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
let g:vimwiki_table_mappings = 0
let g:vimwiki_folding='expr'

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
