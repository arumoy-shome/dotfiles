call aru#autocomplete#deoplete_init()
"
" This is new style
call deoplete#custom#var('omni', 'input_patterns', {
        \ 'pandoc': '@'
        \})
