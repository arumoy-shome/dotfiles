let g:ulti_jump_backwards_res = 0
let g:ulti_jump_forwards_res = 0
let g:ulti_expand_res = 0

let s:deoplete_init_done=0
function! aru#autocomplete#deoplete_init() abort
  if s:deoplete_init_done || !has('nvim')
    return
  endif
  let s:deoplete_init_done=1
  call deoplete#enable()
  call deoplete#custom#source('file', 'rank', 2000)
  call deoplete#custom#source('ultisnips', 'rank', 1000)
  call deoplete#custom#source('_', 'matchers', ['matcher_full_fuzzy'])
endfunction
