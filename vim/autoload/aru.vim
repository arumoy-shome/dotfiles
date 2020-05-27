function! aru#zap() abort
  echohl WarningMsg | echo "aru#zap() not implemented yet! | echohl None
endfunction

function! aru#statusline_update_highlight() abort
  execute 'highlight User2 ' . pinnacle#italicize('StatusLine')
endfunction

function! aru#colorscheme_update_highlight() abort
  highlight clear VertSplit " make the split visible
  highlight Folded gui=italic " make folds italic
  highlight clear CursorLineNr " cleaner CursorLineNr
  highlight link CursorLineNr LineNr
  highlight clear SpellBad
  highlight clear SpellRare
  execute 'highlight SpellBad ' . pinnacle#underline('Normal')
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
