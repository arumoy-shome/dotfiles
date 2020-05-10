" NOTE: colors and :highlight settings are put in after/ to minimize the
" changes of packages overriding these settings.

augroup AruColorscheme
  autocmd!
  autocmd ColorScheme * call aru#colorscheme_update_highlight()
augroup END

" colors
colorscheme solarized

