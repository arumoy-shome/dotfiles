" lighline function
function! aru#lightline#statusline()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  elseif &modified
    return "•"
  elseif &modifiable
    return " "
  else
    return ""
  endif
endfunction

function! aru#lightline#fugitive()
  if exists("*fugitive#head")
    let branch = fugitive#head()
    return branch !=# '' ? ''.branch : ''
  endif
  return ''
endfunction
