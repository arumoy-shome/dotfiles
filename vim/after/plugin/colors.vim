" NOTE: colors and :highlight settings are put in after/ to minimize the
" changes of packages overriding these settings.

" colors
colorscheme default

function! AruHighlights() abort
  highlight clear VertSplit " make the split visible
  highlight clear CursorLineNr " cleaner CursorLineNr
  highlight link CursorLineNr LineNr

  execute 'highlight Folded ' . pinnacle#italicize('Folded')

  highlight clear SignColumn " for better lsp signs
  execute 'highlight DiagnosticError ' . pinnacle#decorate('italic,bold', 'DiagnosticError')
  execute 'highlight DiagnosticWarn ' . pinnacle#decorate('italic,bold', 'DiagnosticWarn')
  execute 'highlight DiagnosticInfo ' . pinnacle#decorate('italic,bold', 'DiagnosticInfo')
  execute 'highlight DiagnosticHint ' . pinnacle#decorate('italic,bold', 'DiagnosticHint')

  highlight clear SpellBad
  execute 'highlight SpellBad ' . pinnacle#underline('DiagnosticError')
  highlight clear SpellCap
  execute 'highlight SpellCap ' . pinnacle#underline('DiagnosticInfo')
  execute 'highlight Comment ' . pinnacle#italicize('Comment')
endfunction
call AruHighlights()
