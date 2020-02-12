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

function! aru#statusline_update_highlight() abort
  execute 'highlight User1 ' . pinnacle#highlight({'bg': pinnacle#extract_bg('StatusLine'), 'fg': pinnacle#extract_fg('Special'), 'term': 'bold'})
  execute 'highlight User2 ' . pinnacle#italicize('StatusLine')
endfunction

function! aru#spell() abort
  setlocal spell
  setlocal spellfile=~/.vim/spell/en.utf-8.add
  setlocal spelllang=en
endfunction
