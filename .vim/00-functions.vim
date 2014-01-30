fun! RangerChooser()
    exec "silent !urxvtc -e ranger --choosefile=/tmp/chosenfile " . expand("%:p:h")
    if filereadable('/tmp/chosenfile')
        exec 'edit ' . system('cat /tmp/chosenfile')
        call system('rm /tmp/chosenfile')
    endif
    redraw!
endfun

function! GetVisualSelection()
    let [s:lnum1, s:col1] = getpos("'<")[1:2]
    let [s:lnum2, s:col2] = getpos("'>")[1:2]
    let s:lines = getline(s:lnum1, s:lnum2)
    let s:lines[-1] = s:lines[-1][: s:col2 - (&selection == 'inclusive' ? 1 : 2)]
    let s:lines[0] = s:lines[0][s:col1 - 1:]
    return join(s:lines, ' ')
endfunction

function! s:SetCompleteFunc()
    if !g:neocomplete#force_overwrite_completefunc
        let &completefunc = 'youcompleteme#Complete'
        let &l:completefunc = 'youcompleteme#Complete'
    endif

    if pyeval( 'ycm_state.NativeFiletypeCompletionUsable()' )
        let &omnifunc = 'youcompleteme#OmniComplete'
        let &l:omnifunc = 'youcompleteme#OmniComplete'

  " If we don't have native filetype support but the omnifunc is set to YCM's
  " omnifunc because the previous file the user was editing DID have native
  " support, we remove our omnifunc.
    elseif &omnifunc == 'youcompleteme#OmniComplete'
        let &omnifunc = ''
        let &l:omnifunc = ''
    endif
endfunction

function! s:mkdir(file, ...)
    let f = a:0 ? fnamemodify(a:file, a:1) : a:file
    if !isdirectory(f)
      call mkdir(f, 'p')
    endif
endfunction

function! s:sysid_match(sys_ids)
    let l:sysid = synIDattr(synID(line('.'), col('.'), 0), 'name')
    if index(a:sys_ids, l:sysid) >= 0
      return 1
    else
      return 0
    endif
endfunction

function! s:sum(array)
    let sum = 0
    for i in a:array
      let sum += i
    endfor
    return sum
endfunction

function! s:system(cmd) " execute external command async if possible
    if exists('g:loaded_vimproc')
      call vimproc#system(a:cmd)
    else
      call system(a:cmd)
    endif
endfunction

function! s:gtags_update()
    call s:system("gtags -i")
endfunction
command! GtagsUpdate call s:gtags_update()

function! s:toggle_quickfix_window()
  let _ = winnr('$')
  cclose
  if _ == winnr('$')
    copen
    setlocal nowrap
    setlocal whichwrap=b,s
  endif
endfunction
"}}}

