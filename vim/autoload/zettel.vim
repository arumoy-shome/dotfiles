let s:cwd = getcwd()
let s:notes_dir = s:cwd . "/notes"

if isdirectory(s:notes_dir)
  let s:notes = split(globpath(s:notes_dir, "*.md"), "\n")
else
  let s:notes = []
endif

function! s:create_notes_dir() abort
  " TODO: returns nothing, creates a notes dir at cwd()
  let l:choice = confirm("Create notes directory " . s:notes_dir . " ?", "&Yes\n&No")

  if choice == 1
    call mkdir(s:notes_dir, "p")
    echomsg "Notes directory successfully created."
    return 1
  endif

  echoerr "Notes directory not created."
endfunction

function! s:new_note_id() abort
    " format: YYYYMMDDHHSSNN where NN is the note number
    return strftime("%Y%m%d%H%M%S") . "00"
endfunction

function! s:new_sub_note_id(note) abort
    " arbitrary number of digits before '.md' at the end of str
    let l:note_id = matchstr(a:note, "\v\zs\d+\ze(\.md)$")

    return l:note_id + 1
endfunction

function! s:get_note_id(type, cur_note) abort
  if a:type == "sub"
    return s:new_sub_note_id(cur_note)
  elseif a:type == ""
    return s:new_note_id()
  endif
endfunction

function! zettel#new_note(split, type, cur_note) abort
  if isdirectory(s:notes_dir)
    let l:note_name = s:notes_dir . "/" . s:get_note_id(a:type, a:cur_note) . ".md"

    if a:split == "h"
      execute "split " . l:note_name
    elseif a:split == "v"
      execute "vsplit" l:note_name
    else
      execute "edit" l:note_name
    endif
  else
    if s:create_notes_dir()
      call zettel#new_note(a:split, a:type, a:cur_note)
    endif
  endif
endfunction
