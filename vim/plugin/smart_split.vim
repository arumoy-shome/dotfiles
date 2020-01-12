let s:w = winwidth(0) * 1.0
let s:h = winheight(0) * 1.0
let s:threshold = s:h / s:w

function s:split(f) abort
  let w = winwidth(0) * 1.0
  let h = winheight(0) * 1.0
  let ratio = h / w

  if ratio <= s:threshold
    execute "vsplit " . a:f
  else
    execute "split " . a:f
  endif
endfunction

command -nargs=? Split :call s:split(<q-args>)
