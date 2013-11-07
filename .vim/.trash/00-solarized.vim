if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
    let g:solarized_termcolors=256
    color solarized                 " Load a colorscheme
endif
    let g:solarized_termtrans=1
    let g:solarized_contrast="high"
    let g:solarized_visibility="high"
