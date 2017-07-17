filetype plugin indent on
color hybrid

set background=dark
set autowrite
set colorcolumn=+1
set complete+=kspell
set diffopt+=vertical
set expandtab
set list
set listchars=nbsp:⦸
set listchars+=tab:»·
set listchars+=trail:·
set nobackup
set nocompatible
set nojoinspaces
set nonumber
set norelativenumber
set noswapfile
set nowritebackup
set numberwidth=5
set path +=**
set scrolloff=5
set shiftround
set shiftwidth=2
set showcmd
set spellfile=$HOME/.vim-spell-en.utf-8.add
set splitbelow
set splitright
set tabstop=2
set textwidth=80
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
set wildmode=list:longest,list:full
set wildmode=list:longest,list:full
set noshowmode

highlight Comment cterm=italic
highlight clear Spellbad
highlight Spellbad cterm=underline

let mapleader = " "

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Use The Silver Searcher when available
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  if !exists(":Ag")
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
    nnoremap \ :Ag<SPACE>
  endif
endif

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_aggregate_errors = 1
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute \"ng-"]
let g:syntastic_eruby_ruby_quiet_messages =
    \ {"regex": "possibly useless use of a variable in void context"}

" syntastic checkers
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'

"ultisnips
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsSnippetsDir="~/.vim/snips"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "snips"]

"tmux-runner
let g:VtrUseVtrMaps = 1

" lightline
let g:lightline = {
      \ 'colorscheme': 'darcula',
      \ 'active': {
      \   'left': [['status'], ['filename']],
      \   'right': [['fugitive'], ['percent', 'filetype']]
      \ },
      \ 'inactive': {
      \   'left': [],
      \   'right': [['filename']]
      \ },
      \ 'component_function': {
      \   'status': 'LightlineStatus',
      \   'fugitive': 'LightlineFugitive',
      \ },
      \ 'tab': {
      \   'active': ['filename', 'modified']
      \ },
      \ 'tabline': {
      \   'left': [['tabs']],
      \   'right': [['']]
      \ },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

" lighline function
function! LightlineStatus()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  elseif &modified
    return "•"
  elseif &modifiable
    return " "
  else
    return ""
  endif
endfunction

function! LightlineFugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? ''.branch : ''
  endif
  return ''
endfunction

" vim-javascript
let g:jsx_ext_required = 0

" vim-hybrid
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1

" elm-vim
let g:elm_format_autosave = 1
