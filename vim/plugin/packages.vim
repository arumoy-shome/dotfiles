"
" python-syntax
"

let g:python_highlight_all = 1

"
" ale
"

let g:ale_sign_error = '●'
let g:ale_sign_warning = '●'

"
" airline
"

let g:airline_theme = 'base16_spacemacs'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" separators
" let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.crypt = '🔒'

" do not display file encoding if it is utf-8
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

" set the extensions
let g:airline_extensions = ['quickfix', 'branch', 'grepper']

let g:airline_mode_map = {
      \ '__' : '',
      \ 'c'  : '',
      \ 'i'  : '',
      \ 'ic' : '',
      \ 'ix' : '',
      \ 'n'  : '',
      \ 'ni' : '',
      \ 'no' : '',
      \ 'R'  : '',
      \ 'Rv' : '',
      \ 's'  : '',
      \ 'S'  : '',
      \ '' : '',
      \ 't'  : '',
      \ 'v'  : '',
      \ 'V'  : '',
      \ '' : '',
      \ }

"
" base16
"

if filereadable(expand("~/.vim/.background"))
  source ~/.vim/.background
endif


"
" elm
"

let g:elm_format_autosave = 1

"
" fzf
"

" Customize fzf colors to match color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

nmap <C-p> :Files<CR>
" nmap <leader>/ :Lines<CR>
" nmap <leader>b :Buffers<CR>
nmap <leader>h :Helptags<CR>
nmap <leader>gg :Gtabedit :<CR>
nmap <leader>gc :Commits<CR>
" nmap <leader>gp :Gpush<CR>
" nmap <leader>gF :Gpull<CR>

" imap <c-x><c-k> <plug>(fzf-complete-word)
" imap <c-x><c-f> <plug>(fzf-complete-path)
" imap <c-x><c-j> <plug>(fzf-complete-file-ag)
" imap <c-x><c-l> <plug>(fzf-complete-line)

"
" gitgutter
"

let g:gitgutter_sign_added = '┃'
let g:gitgutter_sign_modified = '┃'
let g:gitgutter_sign_removed = '┃'

"
" grepper
"

let g:grepper = {}
let g:grepper.tools = ['rg', 'git', 'grep']

" search for the current word
nnoremap <Leader>. :Grepper -cword -noprompt<CR>

" search for the current selection
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" define alias
call aru#autoloads#setupCommandAlias("grep", "GrepperGrep")
call aru#autoloads#setupCommandAlias("rg", "GrepperRg")

"
" indentline
"

let g:indentLine_setColors = 0
let g:indentLine_char_list = '|'

"
" limelight
"

let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_paragraph_span = 1

"
" pandoc
"

let g:pandoc#modules#disabled = ["folding"]

"
" test
"

nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

let test#strategy = "vtr"

"
" tmux-runner
"

let g:VtrUseVtrMaps = 1

"
" ultisnips
"

let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsSnippetsDir="~/.vim/snips"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "snips"]

"
" javascript
"

let g:jsx_ext_required = 0

"
" vimtex
"

let g:tex_flavor = 'latex'

"
" ycm
"

let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_python_interpreter_path = ''
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = '~/.vim/global_extra_conf.py'
