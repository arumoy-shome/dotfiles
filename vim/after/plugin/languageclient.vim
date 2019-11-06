let g:LanguageClient_diagnosticsList='Location'
let g:LanguageClient_useVirtualText=0
let g:LanguageClient_useFloatingHover=1
let g:LanguageClient_hoverPreview='Always'
let g:LanguageClient_diagnosticsDisplay = {
      \   1: {'signTexthl': 'LineNr', 'virtualTexthl': 'User8'},
      \   2: {'signTexthl': 'LineNr', 'virtualTexthl': 'User8'},
      \   3: {'signTexthl': 'LineNr', 'virtualTexthl': 'User8'},
      \   4: {'signTexthl': 'LineNr', 'virtualTexthl': 'User8'},
      \ }

let g:LanguageClient_rootMarkers = {
      \   'javascript': ['tsconfig.json', '.flowconfig', 'package.json']
      \ }

let g:LanguageClient_serverCommands = {}

if exists('$DEBUG_LC_LOGFILE')
  let g:LanguageClient_loggingFile=$DEBUG_LC_LOGFILE
  let g:LanguageClient_loggingLevel='DEBUG'
endif

if executable('typescript-language-server')
  " ie. via `npm install -g typescript-language-server`
  if exists('$DEBUG_LSP_LOGFILE')
    let s:debug_args=[
          \   '--log-level=4',
          \   '--tsserver-log-file',
          \   $DEBUG_LSP_LOGFILE,
          \   '--tsserver-log-verbosity=verbose'
          \ ]
  else
    let s:debug_args=[]
  endif


  let s:ts_lsp=extend([exepath('typescript-language-server'), '--stdio'], s:debug_args)
elseif executable('javascript-typescript-stdio')
  " ie. via `npm install -g javascript-typescript-langserver`
  if exists('$DEBUG_LSP_LOGFILE')
    let s:debug_args=['--trace', '--logfile', $DEBUG_LSP_LOGFILE]
  else
    let s:debug_args=[]
  endif

  let s:ts_lsp=extend([exepath('javascript-typescript-stdio')], s:debug_args)
else
  let s:ts_lsp=[]
endif

" From `npm install -g flow-bin`:
let s:flow_lsp=executable('flow') ?
      \ [exepath('flow'), 'lsp'] :
      \ []

let s:py_lsp=executable('pyls') ?
      \ [exepath('pyls')] :
      \ []

let s:ts_filetypes=[
      \   'typescript',
      \   'typescript.tsx',
      \   'typescript.jest',
      \   'typescript.jest.tsx'
      \ ]

let s:js_filetypes=[
      \   'javascript',
      \   'javascript.jsx',
      \   'javascript.jest',
      \   'javascript.jest.jsx'
      \ ]

let s:py_filetypes=[
      \   'python'
      \ ]

if s:ts_lsp != []
  for s:ts_filetype in s:ts_filetypes
    let g:LanguageClient_serverCommands[s:ts_filetype]=s:ts_lsp
  endfor
endif

if s:ts_lsp != [] && filereadable('tsconfig.json')
  let s:js_lsp=s:ts_lsp
elseif s:flow_lsp != [] && filereadable('.flowconfig')
  let s:js_lsp=s:flow_lsp
elseif s:ts_lsp != []
  let s:js_lsp=s:ts_lsp
endif

if exists('s:js_lsp')
  for s:js_filetype in s:js_filetypes
    let g:LanguageClient_serverCommands[s:js_filetype]=s:js_lsp
  endfor
endif

if s:py_lsp != []
  for s:py_filetype in s:py_filetypes
    let g:LanguageClient_serverCommands[s:py_filetype]=s:py_lsp
  endfor
endif

function! s:Config()
  if has_key(g:LanguageClient_serverCommands, &filetype)
    if &filetype == 'reason'
      " Format selection with gq.
      setlocal formatexpr=LanguageClient#textDocument_rangeFormatting_sync()

      " <Leader>f -- Format buffer.
      nnoremap <buffer> <silent> <Leader>f :call LanguageClient_textDocument_formatting()<CR>
    endif

    " gd -- go to definition
    nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>

    " K -- lookup keyword
    nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<CR>

    if exists('+signcolumn')
      setlocal signcolumn=yes
    endif
  endif
endfunction

function! s:Bind()
  nnoremap <buffer> <silent> K :call LanguageClient#closeFloatingHover()<CR>
  nnoremap <buffer> <silent> <Esc> :call LanguageClient#closeFloatingHover()<CR>
endfunction

augroup AruLanguageClientAutocmds
  autocmd!
  autocmd FileType * call s:Config()

  if has('nvim') && exists('*nvim_open_win')
    " Can use floating window.
    autocmd BufEnter __LanguageClient__ call s:Bind()
  endif
augroup END
