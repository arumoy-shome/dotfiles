" NOTE: colors and :highlight settings are put in after/ to minimize the
" changes of packages overriding these settings.

augroup AruColorscheme
  autocmd!
  autocmd ColorScheme * call aru#colorscheme_update_highlight()
augroup END

" colors
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif
