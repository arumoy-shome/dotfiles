set statusline=\ 
set statusline+=%<
set statusline+=%{aru#statusline_fileprefix()}
set statusline+=%2*
set statusline+=%t
set statusline+=\ 
set statusline+=%([%{aru#statusline_ft()}%{aru#statusline_fenc()}%R%M]%)
set statusline+=%*
set statusline+=%=
set statusline+=\ 
set statusline+=%l:%L:%P
set statusline+=\ 

function! AruStatuslineAutocmds() abort
  augroup AruStatusline
    autocmd!
    autocmd ColorScheme,BufWinEnter,BufWritePost,FileWritePost,TextChanged,TextChangedI,WinEnter * call aru#statusline_update()
    autocmd FocusLost,WinLeave * call aru#blur_statusline()
    autocmd BufEnter,BufWinEnter,FocusGained,VimEnter,WinEnter * call aru#focus_statusline()
  augroup END
endfunction
call AruStatuslineAutocmds()

set tabline=%!aru#tabline()
