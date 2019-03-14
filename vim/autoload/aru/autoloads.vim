" helper function to define alias for ex commands
" this function ensures that the expansion occurs
" only if the work appears at the beginning of the prompt
function! aru#autoloads#setupCommandAlias(input, output)
  exec 'cabbrev <expr> '.a:input
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:input.'")'
        \ .'? ("'.a:output.'") : ("'.a:input.'"))'
endfunction
