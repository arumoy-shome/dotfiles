highlight clear Error
highlight clear SpellBad
highlight clear SpellCap
highlight clear Search
highlight clear Substitute
highlight clear LineNr
highlight clear WildMenu
highlight clear EndOfBuffer
highlight Error gui=underline guisp=green
highlight SpellBad gui=underline guisp=red
highlight SpellCap gui=underline guisp=blue
highlight VertSplit guibg=bg
highlight Search gui=underline,bold guifg=orange
highlight Substitute gui=underline guifg=orange
highlight IncSearch  gui=bold
highlight LineNr guibg=bg
highlight Comment gui=italic
highlight WildMenu gui=underline guifg=orange
highlight link EndOfBuffer ColorColumn
if has('nvim')
  highlight! link TermCursor Cursor
  highlight! TermCursorNC guibg=red guifg=white
endif
