" Zap trailing whitespace.
function! aru#mappings#leader#zap() abort
  call aru#functions#substitute('\s\+$', '', '')
endfunction
