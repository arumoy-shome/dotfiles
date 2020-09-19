augroup AruAutocmds
  autocmd!
  autocmd VimResized * wincmd =

  autocmd BufWinEnter,BufEnter,FocusGained,VimEnter,WinEnter * call aru#focus_window()
  autocmd FocusLost,WinLeave * call aru#blur_window()
augroup END
