" ============НАСТРОЙКА КЛАВИАТУРЫ И МЫШИ============
" Настраиваем переключение раскладок клавиатуры по <C-^>
set keymap=russian-jcukenwin
" Раскладка по умолчанию - английская
set iminsert=0
" аналогично для строки поиска и ввода команд
set imsearch=0
"==============Переключение раскладок и индикация выбранной=============
"" Переключение раскладок будет производиться по <C-S>
""
"" При английской раскладке статусная строка текущего окна будет синего
"" цвета, а при русской - белого.
function MyKeyMapHighlight()
        if &iminsert == 0
                hi StatusLine ctermfg=DarkBlue guifg=DarkBlue
        else
                hi StatusLine ctermfg=white guifg=white
        endif
endfunction
" Вызываем функцию, чтобы она установила цвета при запуске Vim'a
call MyKeyMapHighlight()
" При изменении активного окна будет выполняться обновление
" индикации текущей раскладки
au WinEnter * :call MyKeyMapHighlight()
cmap <silent> <C-S> <C-^>
imap <silent> <C-S> <C-^>X<Esc>:call MyKeyMapHighlight()<CR>a<C-H>
nmap <silent> <C-S> a<C-^><Esc>:call MyKeyMapHighlight()<CR>
vmap <silent> <C-S> <Esc>a<C-^><Esc>:call MyKeyMapHighlight()<CR>gv
