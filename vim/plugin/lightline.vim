let g:lightline = {
      \ 'colorscheme': 'darcula',
      \ 'active': {
      \   'left': [['status'], ['filename']],
      \   'right': [['fugitive'], ['line', 'percent', 'filetype']]
      \ },
      \ 'inactive': {
      \   'left': [['inactive_status']],
      \   'right': [['filename']]
      \ },
      \ 'component_function': {
      \   'status': 'aru#lightline#status',
      \   'fugitive': 'aru#lightline#fugitive',
      \   'inactive_status': 'aru#lightline#inactive_status'
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

