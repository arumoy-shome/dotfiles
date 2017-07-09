" ###########
" bundles
" ###########

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

if filereadable(expand("~/.vimrc.bundles.settings"))
  source ~/.vimrc.bundles.settings
endif
