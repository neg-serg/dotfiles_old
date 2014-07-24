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

noremap!        <M-b> <S-Left>
noremap!        <M-d> <C-O>dw
cnoremap        <M-d> <S-Right><C-W>
noremap!        <M-f> <S-Right>
noremap!        <M-n> <Down>
noremap!        <M-p> <Up>

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

imap ñ <nop>
imap ÷ <nop>
imap ò <nop>
imap ô <nop>
imap é <nop>
imap ï <nop>
imap ð <nop>
imap è <nop>
imap ê <nop>
imap ã <nop>
imap ö <nop>
imap í <nop>
imap õ <nop>
imap Ñ <nop>
imap × <nop>
imap Å <nop>
imap Ò <nop>
imap Ô <nop>
imap Ù <nop>
imap É <nop>
imap Ð <nop>
imap Á <nop>
imap Ó <nop>
imap Ä <nop>
imap Æ <nop>
imap Ç <nop>
imap È <nop>
imap Ê <nop>
imap Ç <nop>
imap Ë <nop>
imap Ú <nop>
imap Ø <nop>
imap Ã <nop>
imap Ö <nop>
imap Â <nop>
imap Î <nop>
imap Í <nop>
