if exists("g:loaded_vim_like_emacs") || v:version < 700 || &cp
  finish
endif
let g:loaded_vim_like_emacs = 1

inoremap        <C-A> <C-O>^
inoremap   <C-X><C-A> <C-A>
cnoremap        <C-A> <Home>
cnoremap   <C-X><C-A> <C-A>

inoremap <expr> <C-B> getline('.')=~'^\s*$'&&col('.')>strlen(getline('.'))?"0\<Lt>C-D>\<Lt>Esc>kJs":"\<Lt>Left>"
cnoremap        <C-B> <Left>

inoremap <expr> <C-D> col('.')>strlen(getline('.'))?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-D> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"

inoremap <expr> <C-E> col('.')>strlen(getline('.'))?"\<Lt>C-E>":"\<Lt>End>"

inoremap <expr> <C-F> col('.')>strlen(getline('.'))?"\<Lt>C-F>":"\<Lt>Right>"
cnoremap <expr> <C-F> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"

if !empty(mapcheck('<C-G>', 'c'))
  cmap <script> <C-G> <C-C>
endif

noremap! <expr> <SID>transposition getcmdpos()>strlen(getcmdline())?"\<Left>":getcmdpos()>1?'':"\<Right>"
noremap! <expr> <SID>transpose "\<BS>\<Right>".matchstr(getcmdline()[0 : getcmdpos()-2], '.$')
cmap   <script> <C-T> <SID>transposition<SID>transpose

noremap! <M-b> <S-Left>
noremap! <M-d> <C-O>dw
cnoremap <M-d> <S-Right><C-W>
noremap! <M-f> <S-Right>
noremap! <M-n> <Down>
noremap! <M-p> <Up>

if !has("gui_running")
  silent! exe "set <S-Left>=\<Esc>b"
  silent! exe "set <S-Right>=\<Esc>f"
  silent! exe "set <F31>=\<Esc>d"
  silent! exe "set <F32>=\<Esc>n"
  silent! exe "set <F33>=\<Esc>p"
  silent! exe "set <F34>=\<Esc>\<C-?>"
  silent! exe "set <F35>=\<Esc>\<C-H>"
  map! <F31> <M-d>
  map! <F32> <M-n>
  map! <F33> <M-p>
  map <F31> <M-d>
  map <F32> <M-n>
  map <F33> <M-p>
endif

inoremap <C-x>b <C-o>:Unite -silent buffer<CR>
vmap <C-b> <Left>
omap <C-b> <Left>
vmap <C-f> <Right>
vmap <C-p> <Up>
cnoremap <c-n> <down>
vmap <C-n> <Down>
vnoremap <C-d> <Del>
inoremap <M-f> <C-o>e<Right>
vnoremap <M-f> e<Right>
onoremap <M-f> e<Right>

vmap <C-a> <Home>
vmap <C-a> <Home>
omap <C-a> <Home>

vmap <C-e> <End>
omap <C-e> <End>

" Heresy/emacs-like stuff
" inoremap <C--> <C-o>u
inoremap   <C-o>u
inoremap <silent> <c-a> <esc>I
vmap <C-e> <End>
omap <C-e> <End>
"----[ Command-mode ]----
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <c-b> <left>
cnoremap <expr> <C-d> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-f> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
cnoremap <C-_> <c-f>
cnoremap <c-p> <up>
cnoremap <C-*> <c-a>
cnoremap <M-d> <S-Right><C-w>
cnoremap <C-y> <C-r><C-o>"
cnoremap <M-f> <S-Right>
cnoremap <C-k> <C-f>d$<C-c><End>
"--[  Block operations  ]-------------------------------------
vnoremap <C-w> "1d

inoremap <silent> <M-k> <C-r>=<SID>KillLine()<CR>
" Thanks to Benji Fisher for helping me with getting <C-k> to work!
" inoremap <M-0><C-k> <C-o>d0
inoremap <M-z> <C-o>dt

function! <SID>KillLine()
  if col('.') > strlen(getline('.'))
    " At EOL; join with next line
    return "\<Del>"
  else
    " Not at EOL; kill until end of line
    return "\<C-o>d$"
  endif
endfunction

"--------------------------------------------------------------------------------------------------------------
"--[ Visual stuff ]--------------------------------------------------------------------------------------------
" Pasting
inoremap <silent> <C-y> <C-o>:call <SID>ResetKillRing()<CR><C-r><C-o>"
inoremap <M-y> <C-o>:call <SID>YankPop()<CR>

function! <SID>YankPop()
  undo
  if !exists("s:kill_ring_position")
    call <SID>ResetKillRing()
  endif
  execute "normal! i\<C-r>\<C-o>" . s:kill_ring_position . "\<Esc>"
  call <SID>IncrKillRing()
endfunction

function! <SID>ResetKillRing()
  let s:kill_ring_position = 3
endfunction

function! <SID>IncrKillRing()
  if s:kill_ring_position >= 9
    let s:kill_ring_position = 2
  else
    let s:kill_ring_position = s:kill_ring_position + 1
  endif
endfunction

"--------------------------------------------------------------------------------------------------------------
inoremap <M-5> <C-o>:call <SID>QueryReplace()<CR>
inoremap <C-M-5> <C-o>:call <SID>QueryReplaceRegexp()<CR>

command! QueryReplace :call <SID>QueryReplace()<CR>
command! QueryReplaceRegexp :call <SID>QueryReplaceRegexp()<CR>

"--[ Emacs' `query-replace' functions ]------------------------------

function! <SID>QueryReplace()
  let magic_status = &magic
  set nomagic
  let searchtext = input("Query replace: ")
  if searchtext == ""
    echo "(no text entered): exiting to Insert mode"
    return
  endif
  let replacetext = input("Query replace " . searchtext . " with: ")
  let searchtext_esc = escape(searchtext,'/\^$')
  let replacetext_esc = escape(replacetext,'/\')
  execute ".,$s/" . searchtext_esc . "/" . replacetext_esc . "/cg"
  let &magic = magic_status
endfunction

function! <SID>QueryReplaceRegexp()
  let searchtext = input("Query replace regexp: ")
  if searchtext == ""
    echo "(no text entered): exiting to Insert mode"
    return
  endif
  let replacetext = input("Query replace regexp " . searchtext . " with: ")
  let searchtext_esc = escape(searchtext,'/')
  let replacetext_esc = escape(replacetext,'/')
  execute ".,$s/" . searchtext_esc . "/" . replacetext_esc . "/cg"
endfunction

imap ñ <nop> | imap ÷ <nop> | imap ò <nop> |
imap ô <nop> | imap é <nop> | imap ï <nop> |
imap ð <nop> | imap è <nop> | imap ê <nop> |
imap ã <nop> | imap ö <nop> | imap í <nop> |
imap õ <nop> | imap Ñ <nop> | imap × <nop> |
imap Å <nop> | imap Ò <nop> | imap Ô <nop> |
imap Ù <nop> | imap É <nop> | imap Ð <nop> |
imap Á <nop> | imap Ó <nop> | imap Ä <nop> |
imap Æ <nop> | imap Ç <nop> | imap È <nop> |
imap Ê <nop> | imap Ç <nop> | imap Ë <nop> |
imap Ú <nop> | imap Ø <nop> | imap Ã <nop> |
imap Ö <nop> | imap Â <nop> | imap Î <nop> |
imap Í <nop>

function! <SID>ttext(mode) range
   let last_search = histget('search', -1)
   if a:mode =~ 'v'
      let save_cursor = getpos("'>")
      " visual interactive :)
      if 'vi' == a:mode
         let operators = input('Pivot: ')
      else
         let comparison_ops = ['===', '!==',  '<>', '==#', '!=#',  '>#',
                              \'>=#',  '<#', '<=#', '=~#', '!~#', '==?',
                              \'!=?',  '>?', '>=?',  '<?', '<=?', '=~?',
                              \'!~?',  '==',  '!=',  '>=',  '<=',  '=~',
                              \ '~=',  '!~']
         let logical_ops    = [ '&&',  '||']
         let assignment_ops = [ '+=',  '-=',  '*=',  '/=',  '%=',  '&=',
                              \ '|=',  '^=', '<<=', '>>=']
         let scope_ops      = [ '::']
         let pointer_ops    = ['->*',  '->',  '.*']
         let bitwise_ops    = [ '<<',  '>>']
         let misc_ops       = [  '>',   '<',   '=',   '+',   '-',   '*',
                              \  '/',   '%',   '&',   '|',   '^',   '.',
                              \  '?',   ':',   ',',  "'=",  "'<",  "'>",
                              \ '!<',  '!>']
         let operators_list = comparison_ops
         " If a count is used, swap on comparison operators only
         if v:count < 1
            let operators_list += assignment_ops + logical_ops +
                                \ scope_ops      + pointer_ops +
                                \ bitwise_ops
            if exists('g:swap_custom_ops')
               " let g:swap_custom_ops = ['ope1', 'ope2', ...]
               let operators_list += g:swap_custom_ops
            endif
            let operators_list += misc_ops
         endif
         let operators = join(operators_list, '\|')
         let operators = escape(operators, '*/~.^$')
      endif
      " Whole lines
      if 'V' ==# visualmode() ||
         \ 'v' ==# visualmode() && line("'<") != line("'>")
         execute 'silent ' . a:firstline . ',' . a:lastline .
            \'substitute/'           .
            \  '^[[:space:]]*\zs'    .
            \'\([^[:space:]].\{-}\)' .
            \ '\([[:space:]]*\%('    . operators . '\)[[:space:]]*\)' .
            \'\([^[:space:]].\{-}\)' .
            \'\ze[[:space:]]*$/\3\2\1/e'
      else
         if col("'<") < col("'>")
            let col_start = col("'<")
            if col("'>") >= col('$')
               let col_end = col('$')
            else
               let col_end = col("'>") + 1
            endif
         else
            let col_start = col("'>")
            if col("'<") >= col('$')
               let col_end = col('$')
            else
               let col_end = col("'<") + 1
            endif
         endif
         execute 'silent ' . a:firstline . ',' . a:lastline .
            \'substitute/\%'         . col_start . 'c[[:space:]]*\zs' .
            \'\([^[:space:]].\{-}\)' .
            \ '\([[:space:]]*\%('    . operators . '\)[[:space:]]*\)' .
            \'\([^[:space:]].\{-}\)' .
            \'\ze[[:space:]]*\%'     . col_end   . 'c/\3\2\1/e'
      endif
   " Swap Words
   elseif a:mode =~ 'n'
      let save_cursor = getpos(".")
      " swap with Word on the left
      if 'nl' == a:mode
         call search('[^[:space:]]\+'  .
            \'\_[[:space:]]\+'  .
            \ '[^[:space:]]*\%#', 'bW')
      endif
      " swap with Word on the right
      execute 'silent substitute/'              .
         \ '\([^[:space:]]*\%#[^[:space:]]*\)' .
         \'\(\_[[:space:]]\+\)'                .
         \ '\([^[:space:]]\+\)/\3\2\1/e'
   endif
   " Repeat
   let virtualedit_bak = &virtualedit
   set virtualedit=
   if 'nr' == a:mode
      silent! call repeat#set("\<plug>SwapSwapWithR_WORD")
   elseif 'nl' == a:mode
      silent! call repeat#set("\<plug>SwapSwapWithL_WORD")
   endif
   " Restore saved values
   let &virtualedit = virtualedit_bak
   if histget('search', -1) != last_search
      call histdel('search', -1)
   endif
   if &virtualedit == 'all' && a:mode =~ 'v'
      " wrong cursor position is better than crash
      " https://groups.google.com/forum/#!topic/vim_dev/AK_HZ-5TeuU
      set virtualedit=
      call setpos('.', save_cursor)
      set virtualedit=all
   else
      call setpos('.', save_cursor)
   endif
endfunction

if exists('g:loaded_swap') || &compatible || v:version < 700
   if &compatible && &verbose
      echo "Swap is not designed to work in compatible mode."
   elseif v:version < 700
      echo "Swap needs Vim 7.0 or above to work correctly."
   endif
   finish
endif

let g:loaded_swap = 1

let s:savecpo = &cpoptions
set cpoptions&vim

xmap <silent> <plug>SwapSwapOperands      :     call <SID>ttext('v' )<cr>
xmap <silent> <plug>SwapSwapPivotOperands :     call <SID>ttext('vi')<cr>
nmap <silent> <plug>SwapSwapWithR_WORD    :<c-u>call <SID>ttext('nr')<cr>
nmap <silent> <plug>SwapSwapWithL_WORD    :<c-u>call <SID>ttext('nl')<cr>
imap <m-t> <c-o><m-t>

function! s:map(mode, lhs, rhs)
    if !hasmapto(a:rhs, a:mode)
        execute a:mode . 'map ' . a:lhs . ' ' . a:rhs
    endif
endfunction

call s:map('x', '<m-t>', '<plug>SwapSwapOperands')
call s:map('n', '<m-t>', '<plug>SwapSwapWithR_WORD')
"call s:map('n', '<leader>X', '<plug>SwapSwapWithL_WORD')
"call s:map('x', '<leader>cx', '<plug>SwapSwapPivotOperands')

let &cpoptions = s:savecpo
unlet s:savecpo
