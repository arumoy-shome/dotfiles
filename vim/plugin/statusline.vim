" \ : literal <space>
" %<: truncate point
" %2*: switch to User2 highlight
" %f: file name relative to CWD
" %*: reset highlight group
" %1*: switch to User1 highlight
" %{aru#statusline_modified()}: custom modified flag
" %=: right align items hence forth
" %{aru#statusline_ft()}: custom filetype
" %{aru#statusline_readonly()}: custom readonly flag
" %l: line number
" %L: total lines in buffer
set statusline=\ %<\ %2*%f%*%1*%{aru#statusline_modified()}%*%=%{aru#statusline_ft()}%1*%{aru#statusline_readonly()}%*\ %l:%L\ 

augroup AruStatusline
  autocmd!
  autocmd ColorScheme * call aru#statusline_update_highlight()
augroup END

set tabline=%!aru#tabline()
