set statusline=\ 
set statusline+=%<
set statusline+=%{aru#statusline_fileprefix()}
set statusline+=%2*
set statusline+=%t
set statusline+=\ 
set statusline+=%([%{aru#statusline_ft()}%{aru#statusline_fenc()}%R%M]%)
set statusline+=%*
set statusline+=%=
set statusline+=\ 
set statusline+=%l:%L:%P
set statusline+=\ 

set tabline=%!aru#tabline()
