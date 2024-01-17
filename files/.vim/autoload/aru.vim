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

function! aru#highlight_overrides() abort
  execute 'highlight Comment ' .. pinnacle#italicize('Comment')
  " TODO make folds italic & bold
  " execute 'highlight Folded' pinnacle#decorate('Folded', ['bold', 'italic'])
endfunction

function! aru#set_background() abort
  let config_file = expand('~/.local/share/yob/background')
  if filereadable(config_file)
    let bg = readfile(config_file, '', 1)[0]
  endif

  execute 'set background=' .. bg
  " TODO comments are not italic everytime this function is called
  " temporarily calling aru#highlight_overrides each time this
  " function is called
  " ideally, the highlight overrides should be set once
  call aru#highlight_overrides()
endfunction
