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
    " NOTE: the whitespace in the end is intensional
    normal i 
  else
    " iX: insert a X and return back to normal mode
    normal iX
  endif

  " cursor accepts [{lnum}, {col}, {off}, {curswant}]
  call cursor(l:cursor_pos[1:])
endfunction

" Auto lists: Automatically continue/end lists by adding markers if the
" previous line is a list item, or removing them when they are empty
" from: https://gist.github.com/sedm0784/dffda43bcfb4728f8e90
function! aru#functions#auto_list()
  let l:preceding_line = getline(line(".") - 1)
  if l:preceding_line =~ '\v^\d+\.\s.'
    " The previous line matches any number of digits followed by a full-stop
    " followed by one character of whitespace followed by one more character
    " i.e. it is an ordered list item

    " Continue the list
    let l:list_index = matchstr(l:preceding_line, '\v^\d*')
    call setline(".", l:list_index + 1. ". ")
  elseif l:preceding_line =~ '\v^\d+\.\s$'
    " The previous line matches any number of digits followed by a full-stop
    " followed by one character of whitespace followed by nothing
   " i.e. it is an empty ordered list item

    " End the list and clear the empty item
    call setline(line(".") - 1, "")
  elseif l:preceding_line[0] == "-" && l:preceding_line[1] == " "
    " The previous line is an unordered list item
    if strlen(l:preceding_line) == 2
      " ...which is empty: end the list and clear the empty item
      call setline(line(".") - 1, "")
    else
      " ...which is not empty: continue the list
      call setline(".", "- ")
    endif
  endif
endfunction
