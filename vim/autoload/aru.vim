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
  highlight StatusLine guifg=white guibg=black
  execute 'highlight User1 ' . pinnacle#highlight({'bg': pinnacle#extract_bg('StatusLine'), 'fg': pinnacle#extract_fg('Special'), 'term': 'bold'})
  execute 'highlight User2 ' . pinnacle#italicize('StatusLine')
endfunction

function! aru#spell() abort
  setlocal spell
  setlocal spellfile=~/.vim/spell/en.utf-8.add
  setlocal spelllang=en
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

function! aru#vimwiki_setup_special_buffer(filename) abort
  setlocal nonumber
  setlocal norelativenumber
  setlocal nobuflisted
  nmap <buffer> q :wq<CR>

  if a:filename == 'inbox'
    setlocal statusline=%2*\ [Inbox]%*
  else
    setlocal statusline=%2*\ [Journal]%*
  endif
endfunction

