let g:lightline = {
      \ 'active': {
      \   'left': [['status', 'paste'], ['filename']],
      \   'right': [['fugitive'], ['line', 'percent', 'filetype']]
      \ },
      \ 'inactive': {
      \   'left': [['inactive_status']],
      \   'right': [['filename']]
      \ },
      \ 'component': {
      \ 'paste': '%{&paste?"§":""}'
      \ },
      \ 'component_function': {
      \   'status': 'aru#lightline#status',
      \   'fugitive': 'aru#lightline#fugitive',
      \   'inactive_status': 'aru#lightline#inactive_status'
      \ },
      \ 'tab': {
      \   'active': ['tabnum'],
      \   'inactive': ['tab_modified', 'filename']
      \ },
      \ 'tab_component_function': {
      \ 'tab_modified': 'aru#lightline#tab_modified'
      \ },
      \ 'tabline': {
      \   'left': [['tabs']],
      \   'right': [['']]
      \ },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

