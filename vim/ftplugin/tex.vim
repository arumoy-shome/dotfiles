setlocal spell
setlocal textwidth=72

" This slows down initialization but it's too damn useful not to have it right
" from the start.
call aru#autocomplete#deoplete_init()

" This is new style
call deoplete#custom#var('omni', 'input_patterns', {
        \ 'tex': g:vimtex#re#deoplete
        \})
