"    File: $HOME/etc/functions.vim
"  Author: Magnus Woldrich <m@japh.se>
" Updated: 2012-01-23 09:11:36

". do stuff with lines matching pattern
" :g/\v^#\w+/let @" .= getline('.')."\n"|d _



" Vidir - sanitize filenames                                                 {{{
fu! Vidir_Sanitize(content)
  mark z

  silent! %s/\(\_^[ ]*\)\@<![ ]\+/_/g
  "%s/\(\_^\s*\|\_^\s\+\d\+\)\@<!\s/_/g

  silent! %s/\v[åä]/a/g
  silent! %s/\v[ö]/o/g
  silent! %s/\v[ÅÄ]/A/g
  silent! %s/\v[Ö]/O/g
  silent! %s/\v^\s*[0-9]+\s+\zs\s+/_/g
  silent! %s/,/./g
  silent! %s/\v[;<>*|'&!#)([\]{}]//g
  silent! %s/\v./\L&/g
  silent! %s/\v_+\ze[.]|\zs[.]\ze_+//g
  silent! %s/[$]/S/g
  silent! %s/\v-{2,}/-/g
  silent! %s/\v_-_/-/g
  silent! %s/\v[_]{2,}/_/g
  silent! %s/\v[/_-]@<\=[a-z]/\U&/g
  silent! %s/\v_(Feat|The|It|Of|At)_/\L&/ig
  silent! %s/\v_(Och|N[åa]n)_/\L&/g

  if (a:content == 'music') || (a:content == 'mvid')
    :silent! %s/\v[&]/feat/g
    :silent! %s/\v(_[el]p[_]?)/\U\1/ig
    :silent! %s/\v([_-]?cd[sm][_-]?|flac|[_-]demo|vinyl|[_-](web|pcb|osv))/\U\1/ig
  else
    :silent! %s/\v[&]/and/g
  endif

  'z
  delmark z
endfu
"}}}
" Vidir - sort-of-TitleCase helper                                           {{{
fu! Vidir_SmartUC()
  :s/\<\@<![A-Z]/_&/g
  ":s/\w\@<=\ze\u/_/g
endfu
"}}}
" highlights - hl every even/odd line                                        {{{
fu! OddEvenHL()
  syn match oddEven /^.*$\n/ nextgroup=oddOdd
  syn match oddOdd  /^.*$\n/ nextgroup=oddEven

  hi oddEven ctermbg=233
  hi oddOdd  ctermbg=234
endfu
"}}}
" cabs - less stupidity                                                      {{{
fu! Single_quote(str)
  return "'" . substitute(copy(a:str), "'", "''", 'g') . "'"
endfu
fu! Cabbrev(key, value)
  exe printf('cabbrev <expr> %s (getcmdtype() == ":" && getcmdpos() <= %d) ? %s : %s',
    \ a:key, 1+len(a:key), Single_quote(a:value), Single_quote(a:key))
endfu
"}}}
" sub - TitleCase word                                                       {{{
fu! TitleCaseCenter()
  let word = expand('<cword>')
  s/\w\+/\u&/g
  center
  echo "Word under cursor was " . word
endfu
"}}}
" sub - trailing trash                                                       {{{
fu! RemoveTrailingCrap()
  if search('\s\+$', 'n')
    :%s/\s\+$//
  endif
  if search( nr2char(182) . '$' )
    :execute ":%s/" . nr2char(182) . "//"
  endif
endfu
"}}}
" toggle number/relativenumber                                               {{{
fu! ToggleRelativeAbsoluteNumber()
  exe 'set ' . (&number ? 'relativenumber' : 'number')
endfu
"}}}
" toggle spell                                                               {{{
fu! ToggleSpell()
  exe 'set ' . (&spell ? 'nospell' : 'spell')
endfu
"}}}
" toggle paste                                                               {{{
fun! TogglePaste()
  exe 'set ' . (&paste ? 'nopaste' : 'paste')
endfun
"}}}
" preview markdown                                                           {{{
fu! Markdown_Preview()
  :silent exe '!markdown_preview ' . expand('%:p')
endfu
"}}}
" ls(1) colors                                                               {{{
fu! LS()
  :source /home/scp1/dev/vim-lscolors/plugin/lscolors.vim
endfu
"}}}
" shorten cwd                                                                {{{
fu! CurDir()
  let curdir = substitute(getcwd(), '/home/scp1/', '~/', '')
  return curdir
endfu
"}}}
" syn group for item under cursor                                            {{{
nmap <C-e> :call SynStack()<CR>
fu! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfu
"}}}
" folding - add markers                                                      {{{
fu! AddFoldMarkers()
  setl virtualedit=all

  let comment_char = '#'
  if(&ft == 'vim')
    let comment_char = '"'
  elseif(&ft == 'xdefaults')
    let comment_char = '!'
  elseif(&ft == 'lisp')
    let comment_char = ';;'
  endif

  let fold_marker_start = '{{{'
  let fold_marker_end   = '}}}'

  setl formatoptions=
  normal ^77li{{{
  " to close the unexpected fold :) }}}
  normal o
  normal o
  normal o

  put = comment_char . fold_marker_end
  normal kkk
endfu
"}}}
" sort - by line length                                                      {{{
fu! SortLen()
  mark z
  %s/\v^/\=len(getline('.')) . '↑'/
  sort n
  %s/\v^\d+↑//
  normal G
  'z
  delmark z
endfu
"}}}
" viminfo - save cursor position                                             {{{
autocmd BufReadPost * call SetCursorPosition()
fu! SetCursorPosition()
  if &filetype !~ 'svn\|commit\c'
    if line("'\"") > 0 && line("'\"") <= line("$")
      exe "normal! g`\""
      normal! zz
    endif
  end
endfu
"}}}
" % filesize                                                                 {{{
fu! FileSize()
  let bytes = getfsize(expand("%:p"))
  if bytes <= 0
    return "0"
  endif
  if bytes < 1024
    return bytes
  else
    return (bytes / 1024) . "K"
  endif
endfu
"}}}
"---------[ Functions ] ---------------
fun! <SID>xkb_mappings_load()
    for hcmd in ['gh', 'gH', 'g^H']
        exe "nnoremap <buffer> <silent> ".hcmd.
                    \ " :call <SID>xkb_switch(1)<CR>".hcmd
    endfor
    xnoremap <buffer> <silent> <C-g> :<C-u>call <SID>xkb_switch(1)<CR>gv<C-g>
    snoremap <buffer> <silent> <C-g> <C-g>:<C-u>call <SID>xkb_switch(0)<CR>gv
    let b:xkb_mappings_loaded = 1
endfun

fun! <SID>xkb_switch(mode)
    let cur_layout = substitute(system('xkb-switch'), '\n', '', 'g')
    if a:mode == 0
        if cur_layout != 'us'
            if !exists('b:xkb_mappings_loaded')
                call <SID>xkb_mappings_load()
            endif
            call system('xkb-switch -s us')
        endif
        let b:xkb_layout = cur_layout
    elseif a:mode == 1
        if exists('b:xkb_layout') && b:xkb_layout != cur_layout
            call system('xkb-switch -s '.b:xkb_layout)
        endif
    endif
endfun

fun! <SID>WindowWidth()
    if winwidth(0) > 90
        setlocal foldcolumn=0
        setlocal nonumber
    else
        setlocal nonumber
        setlocal foldcolumn=0
    endif
endfun

" Simulates copying to system clipboard
function! Mirror(dict)
    for [key, value] in items(a:dict)
        let a:dict[value] = key
    endfor
    return a:dict
endfunction

function! SwapWords(dict, ...)
    let words = keys(a:dict) + values(a:dict)
    let words = map(words, 'escape(v:val, "|")')
    if(a:0 == 1)
        let delimiter = a:1
    else
        let delimiter = '/'
    endif
    let pattern = '\v(' . join(words, '|') . ')'
    exe '%s' . delimiter . pattern . delimiter
        \ . '\=' . string(Mirror(a:dict)) . '[S(0)]'
        \ . delimiter . 'g'
endfunction

func! DeleteTillSlash()
  let g:cmd = getcmdline()
  if MySys() == "linux" || MySys() == "mac"
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
  else
    let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
  endif
  if g:cmd == g:cmd_edited
    if MySys() == "linux" || MySys() == "mac"
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
    else
      let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
    endif
  endif   
  return g:cmd_edited
endfunc
func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc


function! ProjectAdd()
    let s:pproj_name=inputdialog('Enter the name of new project: ')
    if strlen(s:pproj_name) == 0
        return
    endif
    let s:pproject_str_wcwd=s:pproj_name . "=" . getcwd() . " CD=. filter=\"*\" {"
    "for calc this variable now
    silent echo s:pproject_str_wcwd
    Project
    let s:pendln=line("$")
    call setline(s:pendln+1, s:pproject_str_wcwd)
    call setline(s:pendln+2, "}")
    unlet s:pendln
    unlet s:pproject_str_wcwd
    unlet s:pproj_name
endfunction
" ---------------------------------------------------------------------------
" Automagic Clojure folding on defn's and defmacro's
function GetClojureFold()
      if getline(v:lnum) =~ '^\s*(defn.*\s'
            return ">1"
      elseif getline(v:lnum) =~ '^\s*(defmacro.*\s'
            return ">1"
      elseif getline(v:lnum) =~ '^\s*(defmethod.*\s'
            return ">1"
      elseif getline(v:lnum) =~ '^\s*$'
            let my_cljnum = v:lnum
            let my_cljmax = line("$")

            while (1)
                  let my_cljnum = my_cljnum + 1
                  if my_cljnum > my_cljmax
                        return "<1"
                  endif

                  let my_cljdata = getline(my_cljnum)

" If we match an empty line, stop folding
                  if my_cljdata =~ '^$'
                        return "<1"
                  else
                        return "="
                  endif
            endwhile
      else
            return "="
      endif
endfunction
function TurnOnClojureFolding()
      setlocal foldexpr=GetClojureFold()
      setlocal foldmethod=expr
      setlocal foldcolumn=2
endfunction

" Different cursors for different modes.
function! Compile()
  " don't compile if it's an Rspec file (extra warnings)
  let name = expand('<afile>')
  if name !~ 'spec'
    CC
  endif
endfunction

function! UpdateCscopeDb()
let extensions = [""*.cpp"", ""*.h"", ""*.hpp"", ""*.inl"", ""*.c"", ""*.java""]
let update_file_list = "find . -name " . join(extensions, " -o -name ") . " > ./cscope.files"
echo update_file_list
echo system(update_file_list)
echo system("cscope -b")
cscope kill 0
cscope add .
endfunction


function! CleanMuttHeader()
    " remove signature
    exec '%s/^>\+ *-- \n\_.*//e'
    " remove unwanted headers
    exec '%s/^\(Reply-To\|Bcc\): \n//e'
    normal! 3j
endfunction

function! Define(word, lang)
    if (a:lang == "en")
        let response = system("wn " . a:word)
    elseif (lang == "fr")
        let response = system("defr " . a:word)
    endif
    echo response
endfunction

function! TransparentlyExecute(command)
    let w = winsaveview()
    execute a:command
    call winrestview(w)
endfunction

function! EditSyntax()
    let filename = substitute(system("findvimsyntax " . &filetype), "\n$", "", "")
    exec 'e ' . fnameescape(filename)
endfunction

function! EditColorScheme()
    exec 'e ' . fnameescape($HOME . "/.vim/colors/" . g:colors_name . ".vim")
endfunction

function! ToggleSyntax()
    if exists("g:syntax_on")
        syntax off
    else
        syntax enable
    endif
endfunction

function! ToggleConceal()
   if &conceallevel
       set conceallevel=0
       echomsg "conceallevel disabled"
   else
       set conceallevel=2
       echomsg "conceallevel enabled"
   endif
endfunction

function! ToggleWrap()
   if (&wrap == 1)
       if (&linebreak == 0)
           set linebreak
       else
           set nowrap
       endif
   else
       set wrap
       set nolinebreak
   endif
endfunction

function! ToggleBar()
   if (&laststatus == 0)
       set laststatus=2
   else
       set laststatus=0
   endif
endfunction

function! GetCharName()
   let clip = @"
   normal! yl
   let response = system("uniname", @")
   echomsg response
   let @" = clip
endfunction

function! TerminalAt(path)
    let response = system("urxvtc -cd " . a:path)
    echo response
endfunction

function! Yank(...)
    if a:0
        let response = system("xsel -pi", a:1)
    else
        let response = system("xsel -pi", @")
    endif
endfunction

function! YankClip(...)
    if a:0
        let response = system("xsel -bi", a:1)
    else
        let response = system("xsel -bi", @")
    endif
endfunction

function! Paste(which_buffer, paste_where)
    let at_q = @q
    if a:which_buffer == 'primary' 
        let @q = system("xsel -po")
    elseif a:which_buffer == 'clipboard'
        let @q = system("xsel -bo")
    endif
    if a:paste_where == 'after'
        normal! "qp
    elseif a:paste_where == 'before'
        normal! "qP
    endif
    let @q = at_q
endfunction

function! CompleteMuttAliases(findstart, base)
    if a:findstart
        " locate the start of the word
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] =~ '\a'
            let start -= 1
        endwhile
        return start
    else
        " call mutt with the appropriate parameters
        let result = []
        if strlen(a:base)
            let query_response = system("mutt_alias_query " . a:base)
            let result = split(query_response, '\n')
        endif
        return result
    endif
endfunction

" function! ToggleColorColumn()
"     if &colorcolumn
"         set colorcolumn=0
"     else
"         set colorcolumn=80
"     endif
" endfunction

fun! BufInfo()
  echo "[bufnr ] ".bufnr("%")
  echo "[bufname ] ". expand("%:p")
  echo "[cwd ] " . getcwd()
  if filereadable(expand("%"))
    echo "[mtime ] " . strftime("%Y-%m-%d %H:%M %a",getftime(expand("%")))
  endif
  echo "[size ] " . Bufsize() . " bytes"
  echo "[comment ] " . (exists('b:commentSymbol') ? b:commentSymbol : "undefined")
  echo "[filetype ] " . &ft
  echo "[tab ] " . &ts . " (" . (&et ? "" : "no") . "expandtab)"
  echo "[keywordprg] " . &keywordprg
  echo "[makeprg ] " . &makeprg
  echo "[Buffer local mappings]"
  nmap <buffer>
endf

" IncBufSwitch {{{
"-----------------------------------------------------------------------------
" IncBufSwitch
" - Emacs
" - C-c 
"-----------------------------------------------------------------------------
if 1
  command! IncBufSwitch :call IncBufferSwitch()
  hi link IncBufSwitchCurrent Search
  hi IncBufSwitchOnlyOne cterm=reverse ctermfg=1 ctermbg=6 cterm=bold

  fun! PartialBufSwitch(partialName, first)
    let lastBuffer = bufnr("$")
    let g:ibs_buflist = ''
    let flag = 0
    let i = 1
    while i <= lastBuffer
      if (bufexists(i) != 0 && buflisted(i))
        let filename = expand("#" . i . ":t")
        if (match(filename, a:partialName) > -1)
          if flag == g:ibs_tabStop
            if a:first == 0
              let g:ibs_current_buffer = i
            endif
          endif
          let g:ibs_buflist = g:ibs_buflist .','. expand("#" . i . ":t")
          let flag = flag + 1
        endif
      endif
      let i = i + 1
    endwhile
    let g:ibs_buflist = substitute(g:ibs_buflist, '^,', '', '')

    if flag == g:ibs_tabStop + 1
      let g:ibs_tabStop = - 1
    endif
    return flag
  endf

  fun! IncBufferSwitch()
    let origBufNr = bufnr("%")
    let g:ibs_current_buffer = bufnr("%")
    let partialBufName = ""
    let g:ibs_tabStop = 0

    let cnt = PartialBufSwitch('', 1)
    echon "ibs: "
    if cnt == 1
      echon ' {'
      echohl IncBufSwitchCurrent | echon g:ibs_buflist | echohl None
      echon '}'
    else
      echon ' {'. g:ibs_buflist .'}'
    endif

    while 1
      let flag = 0
      let rawChar = getchar()
      if rawChar == 13 " <CR>
        exe "silent buffer " . g:ibs_current_buffer
        break
      endif
      if rawChar == 27 || rawChar == 3 " <ESC> or <C-c>
        "echon "\r "
        let g:ibs_current_buffer = origBufNr
        break
      endif
      if rawChar == "\<BS>"
        let g:ibs_tabStop = 0
        if strlen(partialBufName) > 0
          let partialBufName = strpart(partialBufName, 0, strlen(partialBufName) - 1)
          if strlen(partialBufName) == 0
            let flag = 1
            if bufnr("%") != origBufNr
              let g:ibs_current_buffer = origBufNr
            endif
          endif
        else
          if bufnr("%") != origBufNr
            let g:ibs_current_buffer = origBufNr
          endif
          break
        endif
      elseif rawChar == 9 " TAB -- find next matching buffer
        let g:ibs_tabStop = (g:ibs_tabStop == -1) ? 0 : g:ibs_tabStop + 1
      else
        let nextChar = nr2char(rawChar)
        let partialBufName = partialBufName . nextChar
      endif

      let matchcnt = PartialBufSwitch(partialBufName, flag)
      if matchcnt == 0
        let partialBufName = strpart(partialBufName, 0, strlen(partialBufName) - 1)
        let matchcnt = PartialBufSwitch(partialBufName, flag)
      endif
      redraw
      echon "\ribs: " . partialBufName
      call ShowBuflist(partialBufName, matchcnt)
    endwhile
  endf

  fun! ShowBuflist(partialName, matchcnt)
    let lastBuffer = bufnr("$")
    let i = 1
    let first = 1
    echon " {"
    while i <= lastBuffer
      if (bufexists(i) != 0 && buflisted(i))
        let filename = expand("#" . i . ":t")
        if (a:partialName != "" && match(filename, a:partialName) > -1)
          if first
            let first = 0
          else
            echon ","
          endif
          if (g:ibs_current_buffer == i)
            if a:matchcnt == 1
              echohl IncBufSwitchOnlyOne
            else
              echohl IncBufSwitchCurrent
            endif
          endif
          echon filename
          echohl None
        endif
      endif
      let i = i + 1
    endwhile
    echon "}"
  endf
endif
" }}}

fun! TabToggle()
  if &expandtab
    set shiftwidth=8
    set softtabstop=0
    retab!
  else
    set shiftwidth=4
    set softtabstop=4
    retab!
  endif
endf

"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" Removes those bloody ^M's
" :call RmCR()
fun RmCR()
    let oldLine=line('.')
    exe ":%s/\r//gic"
    exe ':' . oldLine
endfun

"--------------------[ EndFunctions ]----------

" vim: set sw=2 et fdm=marker:
