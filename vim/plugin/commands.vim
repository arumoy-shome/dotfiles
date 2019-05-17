augroup AruAutoCmds
  autocmd!

  autocmd Filetype help nmap <buffer> q :q<CR>
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
  autocmd VimResized * execute "normal! \<c-w>="
  autocmd BufEnter,FocusGained,VimEnter,WinEnter * let &l:colorcolumn='+' . join(range(0, 254), ',+')
  autocmd FocusLost,WinLeave * let &l:colorcolumn=join(range(1, 255), ',')
augroup END
