" the following settings are taken from fzf.vim homepage
" https://github.com/junegunn/fzf.vim#advanced-customization
" * fzf#vim#with_preview([[options], preview window, [toggle keys...]])
" * For syntax-highlighting, Ruby and any of the following tools are required:
"     - Highlight: http://www.andre-simon.de/doku/highlight/en/highlight.php
"     - CodeRay: http://coderay.rubychan.de/
"     - Rouge: https://github.com/jneen/rouge

" Augmenting Ag command using fzf#vim#with_preview function
"   :Ag  - Start fzf with hidden preview window that can be enabled with "?" key
"   :Ag! - Start fzf in fullscreen and display the preview window above
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)
