fun! RangerChooser()
    exec "silent !urxvt -e ranger --choosefile=/tmp/chosenfile " . expand("%:p:h")
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

" function SetTimeOfDayColors()
"     " currentHour will be 0, 1, 2, or 3
"     let g:CurrentHour = (strftime("%H") + 0) / 6
"     if g:colors_name !~ g:Favcolorschemes[g:CurrentHour]
"         execute "colorscheme " . g:Favcolorschemes[g:CurrentHour]
"         echo "execute " "colorscheme " . g:Favcolorschemes[g:CurrentHour]
"         redraw
"     endif
" endfunction

" ファイルを俯瞰する :Overview {{{
let s:overview_mode = 0
function! s:overview_toggle()
    if s:overview_mode
        let &l:readonly = s:overview_original_readonly
        execute 'set guifont='.s:overview_guifont_prefix.s:overview_font_size
        silent! execute 'sign unplace 1 buffer=' . winbufnr(0)
        sign undefine OverviewSignSymbol
        highlight clear OverviewSignColor
        let s:overview_mode = 0
    else
        let pos = getpos('.')
        let [start, last] = [line('w0'), line('w$')]
        try
            normal! gg
            let screen_height = line('w$')
            if screen_height == line('$')
                return
            endif
            let s:overview_guifont_prefix = escape(substitute(&guifont, '\d\+$', '', ''), ' \')
            let s:overview_font_size = str2nr(matchstr(&guifont, '\d\+$'))
            if s:overview_guifont_prefix == '' || s:overview_font_size == 0
                echoerr 'Error occured'
                return
            endif
            sign define OverviewSignSymbol linehl=OverviewSignColor texthl=OverviewSignColor
            for l in range(start, last)
                execute 'sign place 1 line='.l.' name=OverviewSignSymbol buffer='.winbufnr(0)
            endfor
            if &bg == "dark"
                highlight OverviewSignColor ctermfg=white ctermbg=blue guifg=white guibg=RoyalBlue3
            else
                highlight OverviewSignColor ctermbg=white ctermfg=blue guibg=grey guifg=RoyalBlue3
            endif
            let s:overview_original_readonly = &l:readonly
            let font_size = s:overview_font_size * screen_height / line('$')
            let font_size = font_size < 1 ? 1 : font_size
            echom font_size
            execute 'set guifont='.s:overview_guifont_prefix.font_size
            setlocal readonly
            let s:overview_mode = 1
        finally
            call setpos('.', pos)
        endtry
    endif
endfunction
command! -nargs=0 Overview call <SID>overview_toggle()
nnoremap <C-w>O :<C-u>Overview<CR>
" }}}
"
" 
" function! s:open_online_cpp_doc()
"     let l = getline('.')
"
"     if l =~# '^\s*#\s*include\s\+<.\+>'
"         let header = matchstr(l, '^\s*#\s*include\s\+<\zs.\+\ze>')
"         if header =~# '^boost'
"             execute 'OpenBrowser' 'http://www.google.com/cse?cx=011577717147771266991:jigzgqluebe&q='.matchstr(header, 'boost/\zs[^/>]\+\ze')
"         else
"             execute 'OpenBrowser' 'http://en.cppreference.com/mwiki/index.php?title=Special:Search&search='.matchstr(header, '\zs[^/>]\+\ze')
"         endif
"     else
"         let cword = expand('<cword>')
"         if cword ==# ''
"             return
"         endif
"         let line_head = getline('.')[:col('.')-1]
"         if line_head =~# 'boost::[[:alnum:]:]*$'
"             execute 'OpenBrowser' 'http://www.google.com/cse?cx=011577717147771266991:jigzgqluebe&q='.cword
"         elseif line_head =~# 'std::[[:alnum:]:]*$'
"             execute 'OpenBrowser' 'http://en.cppreference.com/mwiki/index.php?title=Special:Search&search='.cword
"         else
"             normal! K
"         endif
"     endif
" endfunction
"
" 
" " ----------------------------------------------------------------------------
" " <Leader>? | Google it
" " ----------------------------------------------------------------------------
" function! s:goog(q)
"   let url = 'https://www.google.co.kr/search?q='
"   " Excerpt from vim-unimpared
"   let q = substitute(
"         \ '"'.a:q.'"',
"         \ '[^A-Za-z0-9_.~-]',
"         \ '\="%".printf("%02X", char2nr(submatch(0)))',
"         \ 'g')
"   call system('open ' . url . q)
" endfunction
"
" vnoremap <leader>? "gy:call <SID>goog(@g)<cr>
"
" " ----------------------------------------------------------------------------
" " Syntax highlighting in code snippets                                    ----
" " ----------------------------------------------------------------------------
" function! s:syntax_include(lang, b, e, inclusive)
"   let syns = split(globpath(&rtp, "syntax/".a:lang.".vim"), "\n")
"   if empty(syns)
"     return
"   endif
"
"   if exists('b:current_syntax')
"     let csyn = b:current_syntax
"     unlet b:current_syntax
"   endif
"
"   let z = "'" " Default
"   for nr in range(char2nr('a'), char2nr('z'))
"     let char = nr2char(nr)
"     if a:b !~ char && a:e !~ char
"       let z = char
"       break
"     endif
"   endfor
"
"   silent! exec printf("syntax include @%s %s", a:lang, syns[0])
"   if a:inclusive
"     exec printf('syntax region %sSnip start=%s\(\)\(%s\)\@=%s ' .
"                 \ 'end=%s\(%s\)\@<=\(\)%s contains=@%s containedin=ALL',
"                 \ a:lang, z, a:b, z, z, a:e, z, a:lang)
"   else
"     exec printf('syntax region %sSnip matchgroup=Snip start=%s%s%s ' .
"                 \ 'end=%s%s%s contains=@%s containedin=ALL',
"                 \ a:lang, z, a:b, z, z, a:e, z, a:lang)
"   endif
"
"   if exists('csyn')
"     let b:current_syntax = csyn
"   endif
" endfunction
"

" function! GoyoBefore()
"   if has('gui_running')
"     set fullscreen
"     set background=light
"     set linespace=7
"   elseif exists('$TMUX')
"     silent !tmux set status off
"   endif
" endfunction
"
" function! GoyoAfter()
"   if has('gui_running')
"     set nofullscreen
"     set background=dark
"     set linespace=0
"   elseif exists('$TMUX')
"     silent !tmux set status on
"   endif
" endfunction
"
" let g:goyo_callbacks = [function('GoyoBefore'), function('GoyoAfter')]
"
" nnoremap <Leader>G :Goyo<CR>
"
" function! s:tmux_words(query)
"   let g:_tmux_q = a:query
"   let matches = fzf#run({
"   \ 'source':      'tmuxwords.rb --all-but-current --scroll 500 --min 5',
"   \ 'sink':        function('Tmux_feedkeys'),
"   \ 'options':     '--no-multi --query='.a:query,
"   \ 'tmux_height': '40%'
"   \ })
" endfunction
"
" function! Tmux_feedkeys(data)
"   echom empty(g:_tmux_q)
"   execute "normal! ".(empty(g:_tmux_q) ? 'a' : 'ciW')."\<C-R>=a:data\<CR>"
"   startinsert!
" endfunction
"
" inoremap <silent> <C-X><C-T> <C-o>:call <SID>tmux_words(expand('<cWORD>'))<CR>
"
" 
" " ----------------------------------------------------------------------------
" " Cscope mappings
" " ----------------------------------------------------------------------------
" function! s:add_cscope_db()
"   " add any database in current directory
"   let db = findfile('cscope.out', '.;')
"   if !empty(db)
"     silent cs reset
"     silent! execute "cs add ".db
"   " else add database pointed to by environment
"   elseif !empty($CSCOPE_DB)
"     silent cs reset
"     silent! execute "cs add ".$CSCOPE_DB
"   endif
" endfunction
"
" " ----------------------------------------------------------------------------
" " :CSBuild
" " ----------------------------------------------------------------------------
" function! s:build_cscope_db(...)
"   let git_dir = system('git rev-parse --git-dir')
"   let chdired = 0
"   if !v:shell_error
"     let chdired = 1
"     execute 'cd '. substitute(fnamemodify(git_dir, ':p:h'), ' ', '\\ ', 'g')
"   endif
"
"   let exts = empty(a:000) ?
"     \ ['java', 'c', 'h', 'cc', 'hh', 'cpp', 'hpp'] : a:000
"
"   let cmd = "find . " . join(map(exts, "\"-name '*.\" . v:val . \"'\""), ' -o ')
"   let tmp = tempname()
"   try
"     echon 'Building cscope.files'
"     call system(cmd.' > '.tmp)
"     echon ' - cscoped db'
"     call system('cscope -b -q -i'.tmp)
"     echon ' - complete!'
"     call s:add_cscope_db()
"   finally
"     silent! call delete(tmp)
"     if chdired
"       cd -
"     endif
"   endtry
" endfunction
" command! CSBuild call s:build_cscope_db(<f-args>)
