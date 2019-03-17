augroup AruAutoCmds
  autocmd!

  autocmd Filetype help nmap <buffer> q :q<CR>
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!
  autocmd FocusGained * source ~/.vim/.background
augroup END
