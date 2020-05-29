set statusline+=%1*
set statusline+=
set statusline+=%*
set statusline+=\ 
set statusline+=%<
set statusline+=%{aru#statusline_fileprefix()}
set statusline+=%2*
set statusline+=%t
set statusline+=%*
set statusline+=%=
set statusline+=%3*
set statusline+=%([%{aru#statusline_ft()}%{aru#statusline_fenc()}]%)
set statusline+=%*
set statusline+=\ 
set statusline+=%l:%L:%P
set statusline+=\ 
set statusline+=%4*
set statusline+=
set statusline+=%*

augroup AruStatusline
  autocmd!
  autocmd ColorScheme,BufWinEnter,BufWritePost,FileWritePost,TextChanged,TextChangedI,WinEnter * call aru#statusline_update_highlight()
  autocmd FocusLost,WinLeave * call aru#blur_statusline()
  autocmd BufEnter,FocusGained,VimEnter,WinEnter * call aru#focus_statusline()
augroup END

set tabline=%!aru#tabline()
