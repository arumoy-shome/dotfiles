function s:RemoveBg(group)
  if !aru#pinnacle#active()
    return
  endif

  let l:highlight=filter(pinnacle#dump(a:group), 'v:key != "bg"')
  execute 'highlight! clear ' . a:group
  execute 'highlight! ' . a:group . ' ' . pinnacle#highlight(l:highlight)
endfunction

function s:CheckColorScheme()
  if filereadable(expand("~/.vim/.background"))
    if !has('termguicolors')
      let g:base16colorspace=256
    endif
    source ~/.vim/.background
  endif

  if aru#pinnacle#active()
    execute 'highlight Comment ' . pinnacle#italicize('Comment')
  endif

  " Hide (or at least make less obvious) the EndOfBuffer region
  highlight clear EndOfBuffer
  highlight link EndOfBuffer ColorColumn

  " Sync with corresponding non-nvim 'highlight' settings in
  " ~/.vim/plugin/settings.vim:
  highlight clear NonText
  highlight link NonText Conceal

  if aru#pinnacle#active()
    highlight clear CursorLineNr
    execute 'highlight CursorLineNr ' . pinnacle#extract_highlight('DiffText')
  endif

  highlight clear DiffDelete
  highlight link DiffDelete Conceal
  highlight clear VertSplit
  highlight link VertSplit LineNr

  " Resolve clashes with ColorColumn.
  " Instead of linking to Normal (which has a higher priority, link to nothing).
  highlight link vimUserFunc NONE
  highlight link NERDTreeFile NONE

  " For Git commits, suppress the background of these groups:
  for l:group in ['DiffAdded', 'DiffFile', 'DiffNewFile', 'DiffLine', 'DiffRemoved']
    call s:RemoveBg(l:group)
  endfor

  " More subtle highlighting during merge conflict resolution.
  " highlight clear DiffAdd
  " highlight clear DiffChange
  " highlight clear DiffText

  if aru#pinnacle#active()
    let l:highlight=pinnacle#italicize('ModeMsg')
    execute 'highlight User8 ' . l:highlight
  endif

  " Allow for overrides:
  " - `statusline.vim` will re-set User1, User2 etc.
  doautocmd ColorScheme
endfunction

if v:progname !=# 'vi'
  if has('autocmd')
    augroup AruAutocolor
      autocmd!
      autocmd FocusGained * call s:CheckColorScheme()
    augroup END
  endif

  call s:CheckColorScheme()
endif
