scriptencoding utf-8

" helper function to define alias for ex commands
" this function ensures that the expansion occurs
" only if the work appears at the beginning of the prompt
function! aru#autoloads#setupCommandAlias(input, output)
  exec 'cabbrev <expr> '.a:input
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:input.'")'
        \ .'? ("'.a:output.'") : ("'.a:input.'"))'
endfunction

let s:middot='·'
let s:raquo='»'
let s:small_l='ℓ'

function! aru#autoloads#foldtext() abort
  let l:lines='[' . (v:foldend - v:foldstart + 1) . s:small_l . ']'
  let l:first=substitute(getline(v:foldstart), '\v *', '', '')
  let l:dashes=substitute(v:folddashes, '-', s:middot, 'g')
  return s:raquo . s:middot . s:middot . l:lines . l:dashes . ': ' . l:first
endfunction

function! aru#autoloads#updateTheme() abort
  source ~/.vim/.background
  source ~/.vim/after/plugin/highlights.vim
endfunction
