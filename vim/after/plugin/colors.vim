" NOTE: colors and :highlight settings are put in after/ to minimize the
" changes of packages overriding these settings.

" colors
let g:falcon_background=0
let g:falcon_inactive=1
set background=dark
colorscheme falcon

highlight clear VertSplit " make the split visible (for falcon)
highlight Folded gui=italic " make folds italic
highlight clear CursorLineNr " cleaner CursorLineNr
highlight link CursorLineNr LineNr
