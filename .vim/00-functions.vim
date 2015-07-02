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

" Delete buffer while keeping window layout (don't close buffer's windows).
" Version 2008-11-18 from http://vim.wikia.com/wiki/VimTip165
if v:version < 700 || exists('loaded_bclose') || &cp
  finish
endif
let loaded_bclose = 1
if !exists('bclose_multiple')
  let bclose_multiple = 1
endif

" Display an error message.
function! s:Warn(msg)
  echohl ErrorMsg
  echomsg a:msg
  echohl NONE
endfunction

" Command ':Bclose' executes ':bd' to delete buffer in current window.
" The window will show the alternate buffer (Ctrl-^) if it exists,
" or the previous buffer (:bp), or a blank buffer if no previous.
" Command ':Bclose!' is the same, but executes ':bd!' (discard changes).
" An optional argument can specify which buffer to close (name or number).
function! s:Bclose(bang, buffer)
  if empty(a:buffer)
    let btarget = bufnr('%')
  elseif a:buffer =~ '^\d\+$'
    let btarget = bufnr(str2nr(a:buffer))
  else
    let btarget = bufnr(a:buffer)
  endif
  if btarget < 0
    call s:Warn('No matching buffer for '.a:buffer)
    return
  endif
  if empty(a:bang) && getbufvar(btarget, '&modified')
    call s:Warn('No write since last change for buffer '.btarget.' (use :Bclose!)')
    return
  endif
  " Numbers of windows that view target buffer which we will delete.
  let wnums = filter(range(1, winnr('$')), 'winbufnr(v:val) == btarget')
  if !g:bclose_multiple && len(wnums) > 1
    call s:Warn('Buffer is in multiple windows (use ":let bclose_multiple=1")')
    return
  endif
  let wcurrent = winnr()
  for w in wnums
    execute w.'wincmd w'
    let prevbuf = bufnr('#')
    if prevbuf > 0 && buflisted(prevbuf) && prevbuf != w
      buffer #
    else
      bprevious
    endif
    if btarget == bufnr('%')
      " Numbers of listed buffers which are not the target to be deleted.
      let blisted = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != btarget')
      " Listed, not target, and not displayed.
      let bhidden = filter(copy(blisted), 'bufwinnr(v:val) < 0')
      " Take the first buffer, if any (could be more intelligent).
      let bjump = (bhidden + blisted + [-1])[0]
      if bjump > 0
        execute 'buffer '.bjump
      else
        execute 'enew'.a:bang
      endif
    endif
  endfor
  execute 'bdelete'.a:bang.' '.btarget
  execute wcurrent.'wincmd w'
endfunction
command! -bang -complete=buffer -nargs=? Bclose call <SID>Bclose('<bang>', '<args>')


function! RedirToClipboardFunction(cmd, ...)
    let cmd = a:cmd . " " . join(a:000, " ")
    redir @*>
    exe cmd
    redir END
endfunction

command! -complete=command -nargs=+ RedirToClipboard
    \ silent! call RedirToClipbaordFunction(<f -args>)

function! RotateColorscheme()
  let l:schemes = ["wim"]
  let l:i = (index(l:schemes, g:colors_name) + 1) % len(l:schemes)
  execute "colorscheme " . l:schemes[l:i]
  redraw | echo l:schemes[l:i]
endfunction

function! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has("win16") || has("win32")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif

    if g:cmd == g:cmd_edited
        if has("win16") || has("win32")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif   

    return g:cmd_edited
endfunc

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


" let s:bundle = neobundle#get("vim-indent-guides")
" function! s:bundle.hooks.on_post_source(bundle)
"     let g:indent_guides_guide_size = 1
"     let gâ:indent_guides_auto_colors = 1
"     if !has('gui_running') && &t_Co >= 256ææ
"         let g:indent_guides_auto_colors = 0
"         autocmd VimEnter,Colorscheme * hi IndentGuidesOdd  ctermbg=233
"         autocmd VimEnter,Colorscheme * hi IndentGuidesEven ctermbg=240
"     endif
"     call indent_guides#enable()
" endfunction
" unlet s:bundle
