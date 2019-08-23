function! s:SetUpLoupeHighlight()
  if !aru#pinnacle#active()
    return
  endif

  execute 'highlight! QuickFixLine ' . pinnacle#extract_highlight('PmenuSel')

  highlight! clear Search
  execute 'highlight! Search ' . pinnacle#embolden('Underlined')
endfunction

if has('autocmd')
  augroup aruLoupe
    autocmd!
    autocmd ColorScheme * call s:SetUpLoupeHighlight()
  augroup END
endif
