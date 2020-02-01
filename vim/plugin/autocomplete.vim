let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
let g:UltiSnipsEditSplit = "horizontal"

" Prevent UltiSnips from removing our carefully-crafted mappings.
let g:UltiSnipsMappingsToIgnore = ['autocomplete']

" my default, ultisnips checks for snippets recursively in rtp, being explicit
" here prevents it from doing so giving a little performace boost albeit now
" snippets need to be managed manually.
let g:UltiSnipsSnippetDirectories = [$HOME . '/.vim/snips']

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
