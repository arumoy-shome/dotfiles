function! aru#zap() abort
  echohl WarningMsg | echo "aru#zap() not implemented yet! | echohl None
endfunction

function! aru#statusline_ft() abort
  let l:ft = strlen(&ft) ? &ft : ''
  return l:ft
endfunction

function! aru#statusline_modified() abort
  let l:flag = &modified ? '*' : ''
  return l:flag
endfunction

function! aru#statusline_readonly() abort
  let l:flag = &readonly ? '*' : ''
  return l:flag
endfunction
