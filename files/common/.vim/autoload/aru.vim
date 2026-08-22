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

function! aru#update_colors() abort
  let l:config_file = expand('~/.local/share/yob/background')

  if filereadable(l:config_file)
    let l:background = readfile(l:config_file, '', 1)[0]

    if l:background == 'dark'
      colorscheme darkblue
    elseif l:background == 'light'
      colorscheme peachpuff
    else
      echoerr "yob: Unknown color" .. l:background .. "in" .. l:config:file .. "using default"
    endif
  else
      execute('colorscheme default')
  endif
endfunction
