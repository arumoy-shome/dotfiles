" leftovers from init.vim that I do not (yet) know how to convert to
" init.lua

" functions {{{

function! aru#sync_background() abort
  let s:bg_file = expand('~/.vim/background')

  if filereadable(s:bg_file)
    let s:bg = readfile(s:bg_file, '', 1)
    execute 'colorscheme ' . s:bg[0]
  else
    execute 'colorscheme base16-default-dark'
  endif
endfunction
call aru#sync_background()

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
" }}}

" {{{ statusline
set statusline=\ 
set statusline+=%<
set statusline+=%{aru#statusline_fileprefix()}
set statusline+=%t
set statusline+=\ 
set statusline+=%([%{aru#statusline_ft()}%{aru#statusline_fenc()}%R%M]%)
set statusline+=%=
set statusline+=\ 
set statusline+=%l:%L:%P
set statusline+=\ 

set tabline=%!aru#tabline()

" End statusline }}}

" autocommands {{{

function! AruHighlightAutocmds() abort
  augroup AruHighlight
    autocmd!
    autocmd FocusGained * call aru#sync_background()
  augroup END
endfunction
call AruHighlightAutocmds()

function! AruWindowAutocmds() abort
  " This function resizes all vim splits everytime the dimensions of
  " the terminal window changes. This is useful since I often bounce
  " my terminal window around. I do this using the VimResized
  " autocmd which fires the `wincmd =' command.
  augroup AruWindow
    autocmd!
    autocmd VimResized * wincmd =
  augroup END
endfunction
call AruWindowAutocmds()

function! AruHelptagsAutocmds() abort
  " This function generates helptags from all *.txt files under the
  " docs/ directories found in vim's runtimepath (:h rtp for
  " details). I do this using the VimEnter autocmd (:h VimEnter for
  " details) which fires the `helptags ALL' command.
  augroup AruHelptags
    autocmd!
    autocmd VimEnter * helptags ALL
  augroup END
endfunction
call AruHelptagsAutocmds()
" End autocommands }}}

" vim: foldmethod=marker
