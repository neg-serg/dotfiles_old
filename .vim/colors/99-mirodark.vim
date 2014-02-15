hi CursorLineNr        gui=none
hi iCursor guifg=white guibg=#005E6D
hi iCursorLine         guibg=#121212 gui=none
hi Error               cterm=NONE guibg=NONE
hi Pmenu               term=reverse ctermfg=0 ctermbg=7 gui=reverse guifg=#000000 guibg=#F8F8F8  
hi PmenuSbar           term=reverse ctermfg=3 ctermbg=7 guifg=#8A95A7 guibg=#F8F8F8  
hi PmenuThumb          term=reverse ctermfg=7 ctermbg=3 guifg=#F8F8F8 guibg=#8A95A7   
hi PmenuSel            term=reverse ctermfg=8 ctermbg=0 gui=reverse guifg=#586e75 guibg=#eee8d5
" Automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
