" Turn on spell-checking.
function! aru#functions#spell() abort
  if has('syntax')
    setlocal spell
    setlocal spellfile=~/.vim/spell/en.utf-8.add
    setlocal spelllang=en
  endif
endfunction

" Switch to plaintext mode with: call aru#functions#plaintext()
function! aru#functions#plaintext() abort
  if has('conceal')
    let b:indentLine_ConcealOptionSet=1 " Don't let indentLine overwrite us.
    setlocal concealcursor=nc
  endif
  setlocal nolist
  setlocal textwidth=0
  setlocal wrap
  setlocal wrapmargin=0

  call aru#functions#spell()

  nnoremap <buffer> j gj
  nnoremap <buffer> k gk

  " Ideally would keep 'list' set, and restrict 'listchars' to just show
  " whitespace errors, but 'listchars' is global and I don't want to go through
  " the hassle of saving and restoring.
  if has('autocmd')
    autocmd BufWinEnter <buffer> match Error /\s\+$/
    autocmd InsertEnter <buffer> match Error /\s\+\%#\@<!$/
    autocmd InsertLeave <buffer> match Error /\s\+$/
    autocmd BufWinLeave <buffer> call clearmatches()
  endif
endfunction

function! aru#functions#substitute(pattern, replacement, flags) abort
  let l:number=1
  for l:line in getline(1, '$')
    call setline(l:number, substitute(l:line, a:pattern, a:replacement, a:flags))
    let l:number=l:number + 1
  endfor
endfunction

" TODO: return if cursor not on a task
function! aru#functions#toggle_task() abort
  " getcurpos returns [bufnum, lnum, col, off, curswant]
  let l:cursor_pos=getcurpos()
  " ^: go to beginning of line
  " f{: find [
  " di{: delete inside [  ]
  normal ^f[di[
  " grab the text between [  ]
  let l:content=@"

  if l:content == "X"
    " i : insert a space and return back to normal mode
    normal i 
  else
    " iX: insert a X and return back to normal mode
    normal iX
  endif

  " cursor accepts [{lnum}, {col}, {off}, {curswant}]
  call cursor(l:cursor_pos[1:])
endfunction

