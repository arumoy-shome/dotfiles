if filereadable(expand("~/.vimrc_background"))
    if !has('termguicolors')
        let g:base16colorspace=256
    endif
    source ~/.vim/.background
endif
