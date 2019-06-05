" if filereadable(expand("~/.vim/.background"))
"   source ~/.vim/.background
" endif

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
