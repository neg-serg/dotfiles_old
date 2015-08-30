hi CursorLineNr        gui=none
hi iCursor guifg=white guibg=white
hi iCursorLine         guibg=#121212 gui=none
hi Error               cterm=NONE guibg=NONE
hi Pmenu               term=reverse ctermfg=0 ctermbg=7 gui=reverse guifg=#000000 guibg=#F8F8F8  
hi PmenuSbar           term=reverse ctermfg=3 ctermbg=7 guifg=#8A95A7 guibg=#F8F8F8  
hi PmenuThumb          term=reverse ctermfg=7 ctermbg=3 guifg=#F8F8F8 guibg=#8A95A7   
hi PmenuSel            term=reverse ctermfg=8 ctermbg=0 gui=reverse guifg=#586e75 guibg=#eee8d5
" Automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif

" hi Special guifg=#2aa198
" hi PreProc guifg=#268bd2
" hi Title gui=bold guifg=#268bd2

" hi! PreProc gui=bold
" hi! VertSplit guifg=#003745 cterm=NONE term=NONE ctermfg=NONE ctermbg=NONE
" hi! LineNR guifg=#004C60 gui=bold guibg=#002B36 ctermfg=146
" hi! link NonText VertSplit
" hi! Normal guifg=#77A5B1
" hi! Constant guifg=#00BCE0
" hi! Comment guifg=#52737B
" hi! link htmlLink Include
" hi! CursorLine cterm=NONE gui=NONE
" hi! Visual ctermbg=233
" hi! Type gui=bold
" hi! EasyMotionTarget guifg=#4CE660 gui=bold
