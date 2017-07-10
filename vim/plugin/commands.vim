augroup AruAutoCmds
  autocmd!

  autocmd Filetype help nmap <buffer> q :q<CR>
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
  autocmd FocusGained * source ~/.vimrc_background
augroup END
