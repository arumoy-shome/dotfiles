" set statusline=\                             " literal <space>
" set statusline+=%<                           " truncate point
" set statusline+=%f                           " file name relative to CWD
" set statusline+=%{aru#statusline_modified()} " modified flag
" set statusline=\                             " literal <space>
" set statusline+=%=                           " right align items hence forth
" set statusline+=%{aru#statusline_ft()}       " filetype
" set statusline+=%{aru#statusline_readonly()} " readonly flag
" set statusline+=\                            " literal <space>
" set statusline+=%P
" set statusline+=\                            " literal <space>
