function! aru#statusline_fileprefix() abort
  let l:basename=expand('%:h')
  if l:basename ==# '' || l:basename ==# '.'
    return ''
  elseif has('modify_fname')
    " Make sure we show $HOME as ~.
    return substitute(fnamemodify(l:basename, ':~:.'), '/$', '', '') . '/'
  else
    " Make sure we show $HOME as ~.
    return substitute(l:basename . '/', '\C^' . $HOME, '~', '')
  endif
endfunction

function! aru#statusline_ft() abort
  let l:ft = strlen(&ft) ? ',' . &ft : ''
  return l:ft
endfunction

function! aru#statusline_fenc() abort
  if strlen(&fenc) && &fenc !=# 'utf-8'
    return ',' . &fenc
  else
    return ''
  endif
endfunction
