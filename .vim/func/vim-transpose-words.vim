"transpose words (like emacs `transpose-words')
function! TransposeWords()
    if search('\w\+\%#\w*\W\+\w\+')
    elseif search('\w\+\W\+\%#\W*\w\+')
    endif
    let l:pos = getpos('.')
    exec 'silent! :s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/'
    call setpos('.', l:pos)
    let l:_ = search('\(\%#\w\+\W\+\)\@<=\w\+')
    normal el
endfunction

nmap <silent> <M-right> :call TransposeWords()<CR>
imap <silent> <M-right> <C-O>:call TransposeWords()<CR>
