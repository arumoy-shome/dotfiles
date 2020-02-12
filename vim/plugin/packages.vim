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
let g:ycm_filetype_whitelist = {
    \ 'vim':       1,
    \ 'python':    1,
    \ 'vimwiki':   1,
    \ 'gitcommit': 1,
    \ 'markdown':  1
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
let g:indentLine_bufNameExclude=['NERD_tree.*']
let g:indentLine_fileTypeExclude=[
    \ 'help',
    \ 'markdown',
    \ 'tex',
    \ 'man',
    \ 'vimwiki',
    \ 'gitcommit'
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
