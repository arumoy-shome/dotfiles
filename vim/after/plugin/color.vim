if filereadable(expand("~/.vim/.background"))
    if !has('termguicolors')
        let g:base16colorspace=256
    endif
    source ~/.vim/.background
endif
