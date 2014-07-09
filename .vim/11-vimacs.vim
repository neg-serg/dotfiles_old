"----[ Emacs-like bindings for vim ]----
"--{ Control }--
inoremap <silent> <M-d> <C-r>=<SID>KillWord()<CR>
"--[ Buffers ]-----------------------------------
inoremap <C-x>b <C-o>:Unite -silent buffer<CR>

" inoremap <silent><expr><C-b> pumvisible() ? "\<C-y>\<Left>" : "\<Left>"
vmap <C-b> <Left>
omap <C-b> <Left>
"------
inoremap <silent><expr><C-f> pumvisible() ? "\<C-y>\<Right>" : "\<Right>"
vmap <C-f> <Right>
omap <C-f> <Right>
"------
inoremap <silent><expr><C-p> pumvisible() ? "\<C-y>\<Up>" : "\<Up>"
vmap <C-p> <Up>
omap <C-p> <Up>
"------
inoremap <silent><expr><C-n> pumvisible() ? "\<C-y>\<Down>" : "\<Down>"
vmap <C-n> <Down>
omap <C-n> <Down>
"------
inoremap <C-d> <Del>
vnoremap <C-d> <Del>
onoremap <C-d> <Del>
"------
inoremap <C-Up> <C-o>{
vnoremap <C-Up> {
onoremap <C-Up> {
"------
inoremap <C-Down> <C-o>}
vnoremap <C-Down> }
onoremap <C-Down> }
"------------------------
"--{ Meta }--
inoremap <M-f> <C-o>e<Right>
vnoremap <M-f> e<Right>
onoremap <M-f> e<Right>
inoremap <M-b> <C-Left>
vnoremap <M-b> <C-Left>
onoremap <M-b> <C-Left>

cmap <M-f> <S-Right>
"imap <C-a> <Home>
vmap <C-a> <Home>
imap <C-a> <Home>
vmap <C-a> <Home>
omap <C-a> <Home>

imap <C-e> <End>
vmap <C-e> <End>
omap <C-e> <End>

" Heresy/emacs-like stuff
" inoremap <C--> <C-o>u
inoremap   <C-o>u
inoremap <silent> <c-a> <esc>I
imap <C-e> <End>
vmap <C-e> <End>
omap <C-e> <End>
"----[ Command-mode ]----
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <c-b> <left>
cnoremap <expr> <C-d> getcmdpos()>strlen(getcmdline())?"\<Lt>C-D>":"\<Lt>Del>"
cnoremap <expr> <C-f> getcmdpos()>strlen(getcmdline())?&cedit:"\<Lt>Right>"
cnoremap <C-_> <c-f>
cnoremap <c-n> <down>
cnoremap <c-p> <up>
cnoremap <C-*> <c-a>
cnoremap <M-d> <S-Right><C-w>
cnoremap <C-y> <C-r><C-o>"
cnoremap <M-f> <S-Right>
cnoremap <M-b> <S-Left>
cnoremap <C-k> <C-f>d$<C-c><End>
"--[  Block operations  ]-------------------------------------
vnoremap <C-w> "1d
cmap <M-b> <S-Left>

inoremap <C-t> <Left><C-o>x<C-o>p

inoremap <silent> <M-k> <C-r>=<SID>KillLine()<CR>
" Thanks to Benji Fisher for helping me with getting <C-k> to work!
" inoremap <M-0><C-k> <C-o>d0
inoremap <M-z> <C-o>dt

function! <SID>KillWord()
  if col('.') > strlen(getline('.'))
    return "\<Del>\<C-o>dw"
  else
    return "\<C-o>dw"
  endif
endfunction

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
