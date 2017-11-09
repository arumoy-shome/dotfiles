let g:airline_powerline_fonts = 1
let g:airline_theme='base16_spacemacs'
let g:airline_exclude_preview = 0
let g:airline_section_y = ''
let g:airline#extensions#tabline#enabled = 1

" customize symbols
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = 'Ꞩ'

call airline#parts#define_accent('file', 'italic')
