function! aru#mappings#normal#yank_filename() abort
  let @* = expand("%")
endfunction

function! aru#mappings#normal#yank_filename_and_linenum() abort
  let @* = expand("%") . ":" . line(".")
endfunction
