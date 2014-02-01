let s:enabled = 0

set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
function MyKeyMapHighlight()
        if &iminsert == 0
                if s:enabled
                    let s:enabled = 0
                    inoremap jk <esc>
                endif
        else
            if !s:enabled
                " hi StatusLine ctermfg=white guifg=white
                let s:enabled = 1
                iunmap jk
            endif
        endif
endfunction
call MyKeyMapHighlight()
au WinEnter * :call MyKeyMapHighlight()
cmap <silent> <C-S> <C-^>
imap <silent> <C-S> <C-^>X<Esc>:call MyKeyMapHighlight()<CR>a<C-H>
nmap <silent> <C-S> a<C-^><Esc>:call MyKeyMapHighlight()<CR>
vmap <silent> <C-S> <Esc>a<C-^><Esc>:call MyKeyMapHighlight()<CR>gv
