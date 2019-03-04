highlight clear Error
highlight clear SpellBad
highlight clear SpellCap
highlight clear Search
highlight clear IncSearch
highlight clear Substitute
highlight clear LineNr
highlight clear WildMenu
highlight Error gui=underline guifg=red
highlight SpellBad gui=underline guifg=red
highlight SpellCap gui=underline
highlight VertSplit guibg=bg
highlight Search gui=underline guifg=orange
highlight Substitute gui=underline guifg=orange
highlight IncSearch  guifg=orange
highlight LineNr guibg=bg
highlight Comment gui=italic
highlight WildMenu gui=underline guifg=orange
if has('nvim')
  highlight! link TermCursor Cursor
  highlight! TermCursorNC guibg=red guifg=white
endif
