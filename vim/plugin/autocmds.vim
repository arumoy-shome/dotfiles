if has ('autocmd')
    function! s:AruAutocmds()
        augroup AruAutocmds
            autocmd!

            autocmd Filetype help nmap <buffer> q :bdelete<CR>
            autocmd Filetype git nmap <buffer> q :bdelete<CR>
            autocmd BufRead,BufNewFile Appraisals set filetype=ruby
            autocmd BufRead,BufNewFile *.md set filetype=markdown
            autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
            autocmd VimResized * execute "normal! \<c-w>="

            " http://vim.wikia.com/wiki/Detect_window_creation_with_WinEnter
            autocmd VimEnter * autocmd WinEnter * let w:created=1
            autocmd VimEnter * let w:created=1

            " Disable paste mode on leaving insert mode.
            autocmd InsertLeave * set nopaste

            " Make current window more obvious by turning off/adjusting some features in non-current
            " windows.
            if exists('+winhighlight')
                autocmd BufEnter,FocusGained,VimEnter,WinEnter * set winhighlight=
                autocmd FocusLost,WinLeave * set winhighlight=CursorLineNr:LineNr,EndOfBuffer:ColorColumn,IncSearch:ColorColumn,Normal:ColorColumn,NormalNC:ColorColumn,SignColumn:ColorColumn
                if exists('+colorcolumn')
                    autocmd BufEnter,FocusGained,VimEnter,WinEnter * if aru#autocmds#should_colorcolumn() | let &l:colorcolumn='+' . join(range(0, 254), ',+') | endif
                endif
            elseif exists('+colorcolumn')
                autocmd BufEnter,FocusGained,VimEnter,WinEnter * if aru#autocmds#should_colorcolumn() | let &l:colorcolumn='+' . join(range(0, 254), ',+') | endif
                autocmd FocusLost,WinLeave * if aru#autocmds#should_colorcolumn() | let &l:colorcolumn=join(range(1, 255), ',') | endif
            endif
            autocmd InsertLeave,VimEnter,WinEnter * if aru#autocmds#should_cursorline() | setlocal cursorline | endif
            autocmd InsertEnter,WinLeave * if aru#autocmds#should_cursorline() | setlocal nocursorline | endif
            if has('statusline')
                " TODO: move this into statusline.vim? or move autocmd stuff in statusline.vim
                " here?
                autocmd BufEnter,FocusGained,VimEnter,WinEnter * call aru#autocmds#focus_statusline()
                autocmd FocusLost,WinLeave * call aru#autocmds#blur_statusline()
            endif
            autocmd BufEnter,FocusGained,VimEnter,WinEnter * call aru#autocmds#focus_window()
            autocmd FocusLost,WinLeave * call aru#autocmds#blur_window()

        augroup END
    endfunction

  call s:AruAutocmds()
endif
