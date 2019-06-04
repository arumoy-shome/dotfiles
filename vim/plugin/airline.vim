let g:airline_theme = 'base16_spacemacs'

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" separators
" let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.crypt = '🔒'

" do not display file encoding if it is utf-8
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'

" set the extensions
let g:airline_extensions = ['quickfix', 'branch', 'grepper']

let g:airline_mode_map = {
      \ '__' : '',
      \ 'c'  : '',
      \ 'i'  : '',
      \ 'ic' : '',
      \ 'ix' : '',
      \ 'n'  : '',
      \ 'ni' : '',
      \ 'no' : '',
      \ 'R'  : '',
      \ 'Rv' : '',
      \ 's'  : '',
      \ 'S'  : '',
      \ '' : '',
      \ 't'  : '',
      \ 'v'  : '',
      \ 'V'  : '',
      \ '' : '',
      \ }
