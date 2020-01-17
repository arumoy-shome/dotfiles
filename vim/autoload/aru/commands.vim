function! s:Open(app, file)
  if !executable('open')
    echoerr 'No "open" executable'
    return
  endif

  silent execute '!open -a ' . shellescape(a:app) . ' ' . shellescape(a:file)
endfunction

function! s:preview(file) abort
  " TODO: remove this hack once new version of Marked 2 is out:
  " http://support.markedapp.com/discussions/questions/8670
  silent! execute '!xattr -d com.apple.quarantine ' . shellescape(a:file)
  call s:Open('Marked 2.app', a:file)
endfunction

function! aru#commands#preview(...) abort
  if a:0 == 0
    call s:preview(expand('%'))
  else
    for l:file in a:000
      call s:preview(l:file)
    endfor
  endif
endfunction

let s:w = winwidth(0) * 1.0
let s:h = winheight(0) * 1.0
let s:threshold = s:h / s:w

function aru#commands#SPlit(f) abort
  let w = winwidth(0) * 1.0
  let h = winheight(0) * 1.0
  let ratio = h / w

  if ratio <= s:threshold
    execute "vertical " . a:f
  else
    execute a:f
  endif
endfunction
