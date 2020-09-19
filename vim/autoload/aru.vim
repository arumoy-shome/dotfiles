function! aru#zap() abort
  echohl WarningMsg | echo "aru#zap() not implemented yet! | echohl None
endfunction

function! aru#statusline_update_highlight() abort
  execute 'highlight User2 ' . pinnacle#decorate('italic,bold', 'ColorColumn')
  execute 'highlight User3 ' . pinnacle#italicize('ColorColumn')

  let l:bg=pinnacle#extract_bg('ColorColumn')
  let l:fg=pinnacle#extract_fg('ModeMsg')
  let l:flag_fg=pinnacle#extract_fg('Identifier')

  if &modified
    execute 'highlight User1 ' . pinnacle#highlight({'fg': l:flag_fg, 'bg': l:bg})
  else
    execute 'highlight User1 ' . pinnacle#highlight({'fg': l:fg, 'bg': l:bg})
  endif

  if &readonly
    execute 'highlight User4 ' . pinnacle#highlight({'fg': l:flag_fg, 'bg': l:bg})
  else
    execute 'highlight User4 ' . pinnacle#highlight({'fg': l:fg, 'bg': l:bg})
  endif

  highlight clear StatusLine
  highlight link Statusline ColorColumn
  highlight clear StatusLineNC
  highlight link StatusLineNC User3
endfunction

function! aru#statusline_wrap() abort
  let l:tw = &tw
  if l:tw == 0
    return '⤷ '
  else
    return '¬'
  endif
endfunction

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

function! aru#blur_statusline() abort
  setlocal statusline=\ %<%f%=
endfunction

function! aru#blur_window() abort
  setlocal nocursorline
endfunction

function! aru#focus_window() abort
  setlocal cursorline
endfunction

function! aru#focus_statusline() abort
  " revert to global statusline
  setlocal statusline=
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

function! aru#colorscheme_update_highlight() abort
  highlight clear VertSplit " make the split visible
  highlight Folded gui=italic " make folds italic
  highlight clear CursorLineNr " cleaner CursorLineNr
  highlight link CursorLineNr LineNr
  highlight clear SpellBad
  execute 'highlight SpellBad ' . pinnacle#underline('Constant')
  highlight clear SpellCap
  execute 'highlight SpellCap ' . pinnacle#underline('Special')
  highlight clear SpellRare
  execute 'highlight Comment ' . pinnacle#italicize('Comment')
endfunction

function aru#colorscheme() abort
  let s:config_file = expand('~/.vim/.background')

  if filereadable(s:config_file)
    let s:config = readfile(s:config_file, '', 2)
    execute 'set background=' . s:config[1]
    execute 'colorscheme ' . s:config[0]
  else " default
    set background=dark
    colorscheme base16-default-dark
  endif
endfunction

function! aru#spell() abort
  setlocal spell
  setlocal spellfile=~/.vim/spell/en.utf-8.add
  setlocal spelllang=en
endfunction

function! aru#pros() abort
  setlocal textwidth=0      " do not hardwrap

  " navigate by display lines since we softwrap
  nmap <buffer> j gj
  nmap <buffer> k gk

  call aru#spell()
endfunction

function! aru#tabline() abort
  let s = ''
  for i in range(tabpagenr('$'))
    " set up some oft-used variables
    let tab = i + 1                   " range() starts at 0
    let winnr = tabpagewinnr(tab)     " gets current window of current tab
    let buflist = tabpagebuflist(tab) " list of buffers associated with the windows in the current tab
    let bufnr = buflist[winnr - 1]    " current buffer number
    let bufname = bufname(bufnr)      " gets the name of the current buffer in the current window of the current tab

    let s .= '%' . tab . 'T' " start a tab
    let s .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#') " if this tab is the current tab...set the right highlighting
    let s .= ' ' . tab " current tab number
    let n = tabpagewinnr(tab,'$') " get the number of windows in the current tab
    if n > 1
      let s .= ':' . n " if there's more than one, add a colon and display the count
    endif
    let bufmodified = getbufvar(bufnr, "&mod")
    if bufmodified
      let s .= ' +'
    endif
    if bufname != ''
      let s .= ' ' . pathshorten(bufname) . ' ' " outputs the one-letter-path shorthand & filename
    else
      let s .= ' [No Name] '
    endif
  endfor
  let s .= '%#TabLineFill#' " blank highlighting between the tabs and the righthand close 'X'
  let s .= '%T' " resets tab page number?
  return s
endfunction
