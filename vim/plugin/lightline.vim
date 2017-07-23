let g:lightline = {
      \ 'colorscheme': 'darcula',
      \ 'active': {
      \   'left': [['status'], ['filename']],
      \   'right': [['fugitive'], ['line', 'percent', 'filetype']]
      \ },
      \ 'inactive': {
      \   'left': [],
      \   'right': [['filename']]
      \ },
      \ 'component_function': {
      \   'status': 'aru#lightline#statusline',
      \   'fugitive': 'aru#lightline#fugitive',
      \ },
      \ 'tab': {
      \   'active': ['filename', 'modified']
      \ },
      \ 'tabline': {
      \   'left': [['tabs']],
      \   'right': [['']]
      \ },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

