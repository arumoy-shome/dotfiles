function! AruWindowAutocmds() abort
  augroup AruWindow
    autocmd!
    autocmd VimResized * wincmd =
  augroup END
endfunction
call AruWindowAutocmds()

function! AruYankAutocmds() abort
  augroup AruYank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank({higroup = 'Search'})
  augroup END
endfunction
call AruYankAutocmds()

function! AruStatuslineAutocmds() abort
  augroup AruStatusline
    autocmd!
    autocmd ColorScheme,BufWinEnter,BufWritePost,FileWritePost,TextChanged,TextChangedI,WinEnter * call aru#sync_statusline()
    autocmd FocusLost,WinLeave * call aru#blur_statusline()
    autocmd BufEnter,BufWinEnter,FocusGained,VimEnter,WinEnter * call aru#focus_statusline()
  augroup END
endfunction
call AruStatuslineAutocmds()

function! AruHighlightAutocmds() abort
  augroup AruHighlight
    autocmd!
    autocmd FocusGained * call aru#sync_background()
    autocmd FocusGained * call aru#sync_highlights()
    autocmd FocusGained * call aru#sync_statusline()
  augroup END
endfunction
call AruHighlightAutocmds()

