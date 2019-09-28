let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
let g:UltiSnipsEditSplit = "horizontal"

" Prevent UltiSnips from removing our carefully-crafted mappings.
let g:UltiSnipsMappingsToIgnore = ['autocomplete']

if has('autocmd')
  augroup AruAutocomplete
    autocmd!
    autocmd! User UltiSnipsEnterFirstSnippet
    autocmd User UltiSnipsEnterFirstSnippet call aru#autocomplete#setup_mappings()
    autocmd! User UltiSnipsExitLastSnippet
    autocmd User UltiSnipsExitLastSnippet call aru#autocomplete#teardown_mappings()
  augroup END
endif

" this defines where my private snippets are defined
let g:UltiSnipsSnippetsDir = $HOME . '/.vim/snips'

" my default, ultisnips checks for snippets recursively in rtp, being explicit
" here prevents it from doing so giving a little performace boost
let g:UltiSnipsSnippetDirectories = [
      \ $HOME . '/.vim/snips',
      \ $HOME . './vim/pack/bundle/opt/vim-snippets/UltiSnips',
      \ $HOME . './vim/pack/bundle/opt/vim-fish/UltiSnips'
      \ ]

if has('nvim')
  " Don't forget to run :UpdateRemotePlugins to populate
  " `~/.local/share/nvim/rplugin.vim`.
  packadd deoplete
  call aru#defer#defer('call aru#autocomplete#deoplete_init()')

  inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
  inoremap <expr><Down> pumvisible() ? "\<C-n>" : "\<Down>"
  inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-j>"
  inoremap <expr><Up> pumvisible() ? "\<C-p>" : "\<Up>"
endif
