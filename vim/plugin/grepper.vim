let g:grepper = {}
let g:grepper.tools = ['rg', 'git', 'grep']

" search for the current word
nnoremap <Leader>. :Grepper -cword -noprompt<CR>

" search for the current selection
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

" define alias
call aru#autoloads#setupCommandAlias("grep", "GrepperGrep")
call aru#autoloads#setupCommandAlias("rg", "GrepperRg")
