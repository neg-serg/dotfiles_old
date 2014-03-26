"----[ Emacs-like bindings for vim ]----
"--{ Control }--
inoremap <silent> <M-d> <C-r>=<SID>KillWord()<CR>
"--[ Buffers ]-----------------------------------
inoremap <C-x>b <C-o>:Unite -silent buffer<CR>

imap <C-b> <Left>
vmap <C-b> <Left>
omap <C-b> <Left>
"------
imap <C-f> <Right>
vmap <C-f> <Right>
omap <C-f> <Right>
"------
imap <C-p> <Up>
vmap <C-p> <Up>
omap <C-p> <Up>
"------
imap <C-n> <Down>
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
inoremap <C-_> <C-o>u
inoremap <silent> <c-a> <esc>I
imap <C-e> <End>
vmap <C-e> <End>
omap <C-e> <End>

" inoremap <M-a> <C-o>(
" vnoremap <M-a> (
" onoremap <M-a> (
"
" inoremap <M-e> <C-o>)
" vnoremap <M-e> )
" onoremap <M-e> )
"
" inoremap <M-<> <C-o>1G<C-o>0
" vnoremap <M-<> 1G0
" onoremap <M-<> 1G0
"
" inoremap <M->> <C-o>G<C-o>$
" vnoremap <M->> G$
" onoremap <M->> G$

inoremap <M-Left> <S-Left>
vnoremap <M-Left> <S-Left>
onoremap <M-Left> <S-Left>

inoremap <M-Right> <S-Right>
vnoremap <M-Right> <S-Right>
onoremap <M-Right> <S-Right>
"----[ Command-mode ]----
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <c-b> <left>
cnoremap <c-d> <del>
cnoremap <c-f> <right>
cnoremap <C-_> <c-f>
cnoremap <c-n> <down>
cnoremap <c-p> <up>
cnoremap <C-*> <c-a>
cnoremap <M-d> <S-Right><C-w>
cnoremap <C-y> <C-r><C-o>"
cnoremap <M-f> <S-Right>
cnoremap <M-b> <S-Left>
cnoremap <C-k> <C-f>d$<C-c><End>

cmap <C-b> <Left>
cmap <C-f> <Right>
cmap <C-a> <Home>
cmap <C-e> <End>

" command-T window
" let g:CommandTCursorLeftMap = ['<Left>', '<C-b>']
" let g:CommandTCursorRightMap = ['<Right>', '<C-f>']
" let g:CommandTBackspaceMap = ['<BS>', '<C-h>']
" let g:CommandTDeleteMap = ['<Del>', '<C-d>']

"--[  Block operations  ]-------------------------------------
vnoremap <C-w> "1d
vnoremap <S-Del> "_d

cmap <M-b> <S-Left>
inoremap <M-a> <C-o>(
inoremap <M-e> <C-o>)

inoremap <M-m> <C-o>^

inoremap <silent> <M-g> <C-o>:call <SID>GotoLine()<CR>
vnoremap <silent> <M-g> :<C-u>call <SID>GotoLine()<CR>
onoremap <silent> <M-g> :call <SID>GotoLine()<CR>

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
" Visual mode
inoremap <silent> <C-Space> <C-r>=<SID>StartVisualMode()<CR>

" Marking blocks
inoremap <M-Space> <C-o>:call <SID>StartMarkSel()<CR><C-o>viw
inoremap <M-h> <C-o>:call <SID>StartMarkSel()<CR><C-o>vap
inoremap <C-<> <C-o>:call <SID>StartMarkSel()<CR><C-o>v1G0o
inoremap <C->> <C-o>:call <SID>StartMarkSel()<CR><C-o>vG$o
inoremap <C-x>h <C-o>:call <SID>StartMarkSel()<CR><Esc>1G0vGo

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

function! <SID>StartMarkSel()
  if &selectmode =~ 'key'
    set keymodel-=stopsel
  endif
endfunction

function! <SID>StartVisualMode()
  call <SID>StartMarkSel()
  if col('.') > strlen(getline('.'))
    " At EOL
    return "\<Right>\<C-o>v\<Left>"
  else
    return "\<C-o>v"
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
"--------------------------------------------------------------------------------------------------------------
"--[ Transposing ]------------------
"" for testing -- foo bar baz quux
inoremap <C-t> <Left><C-o>x<C-o>p

" $Id$
" author: Luc Hermitte
let s:k_version = 200
if &cp || (exists('g:loaded_swap_words')
    \ && (g:loaded_swap_words >= s:k_version)
    \ && !exists('g:force_reload_vim_tip_swap_word'))
    finish
endif
let g:swap_word_loaded = 1

" Tip #329 -> gw
" -> http://vim.wikia.com/wiki/Swapping_characters%2C_words_and_lines

" Swap the current word with the next, without changing cursor position
" nnoremap <silent> gw "_yiw:silent s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<cr>:PopSearch<cr><c-o>
" "left" would respect the old behaviour, but let's use "follow" instead!
nnoremap <silent> gw :call <sid>SwapWithNext('follow', 'w')<cr>

" nnoremap <silent> gW "_yiw:silent s/\(\w\+\)\(\W\+\)\(\%#\w\+\)/\3\2\1/<cr>:PopSearch<cr><c-o>
nnoremap <silent> gW :call <sid>SwapWithPrev('follow', 'w')<cr>

" Swap the current word with the previous, keeping cursor on current word:
" (This feels like "pushing" the word to the left.)
" nnoremap <silent> gl "_yiw?\w\+\_W\+\%#<CR>:PopSearch<cr>:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>:PopSearch<cr><c-o><c-l>
nnoremap <silent> gl :call <sid>SwapWithPrev('left', 'w')<cr>

" Swap the current word with the next, keeping cursor on current word: (This
" feels like "pushing" the word to the right.) (See note.)
" nnoremap <silent> gr "_yiw:s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>:PopSearch<cr><c-o>/\w\+\_W\+<CR>:PopSearch<cr>
nnoremap <silent> gr :call <sid>SwapWithNext('right', 'w')<cr>

" the same, but with keywords
" nnoremap <silent> gs "_yiw:silent s/\(\%#\k\+\)\(.\{-}\)\(\k\+\)/\3\2\1/<cr>:PopSearch<cr><c-o>
" nmap <silent> gS "_yiw?\k?<cr>gs
nnoremap <silent> gs :call <sid>SwapWithNext('follow', 'k')<cr>
nnoremap <silent> gS :call <sid>SwapWithPrev('follow', 'k')<cr>

" Then when you put the cursor on or in a word, press "gw", and
" the word will be swapped with the next word. The words may
" even be separated by punctuation (such as "abc = def").
" gW will swap with previous word.

" While we're talking swapping, here's a map for swapping characters:

nnoremap <silent> gc xph

" This hint was formed in a collaboration between
" Chip Campbell - Arun Easi - Benji Fisher
"
" ======================================================================
" Tip #470 : Piet Delport & Anthony (ad_scriven)
vnoremap <silent> g" <esc>:call <sid>SwapVisualWithCut()<cr>
vnoremap <silent> g' <esc>:call <sid>SwapVisualWithCut2()<cr>

function! s:SwapVisualWithCut()
    normal! `.``
    if line(".")==line("'.") && col(".") < col("'.")
        let c = col('.')
        normal! gvp```]
        let c = col('.') - c
        normal! ``
        :silent call cursor(line("."),col(".")+c)
        normal! P
    else
        normal! gvp``P
    endif
endfunction

function! s:SwapVisualWithCut2()
    let v_s = col("'<")
    let v_e = col("'>")
    if line("'<")==line("'.") && v_s < col("'.")
        let l = line("'.")
        let c = col("'.") - 1
        let deleted = @"
        let line = getline(l)

        let line_2 = (v_s > 1 ? line[ : v_s-1] : '')
            \. deleted
            \. line[v_e : c-1]
            \. line[v_s : v_e-1]
            \. line[c : ]
        normal! u
        call setline(l, line_2)
        echomsg "spe"
        else
        normal! `.``
        normal! `.``gvp``P
        echomsg "default"
    endif
endfunction

function! s:SwapVisualWithCut3()
    let deleted = @"

    let v_s = getpos("'<")
    let v_e = getpos("'>")
    let d_s = getpos("'.")

    if d_s[1] == v_s[1] " same line
        let line = getline(d_s[1])
        let c = d_s[2] - 1
    endif
    if line("'<")==line("'.") && v_s < col("'.")
        let l = line("'.")
        let c = col("'.") - 1

        let line_2 = (v_s > 1 ? line[ : v_s[2]-1] : '')
        \. deleted
        \. line[v_e[2] : c-1]
        \. line[v_s[2] : v_e[2]-1]
        \. line[c : ]
        normal! u
        call setline(d_s[1], line_2)
        echomsg "same line"
    else
        normal! `.``
        normal! `.``gvp``P
        echomsg "default"
    endif
endfunction

" ======================================================================
" LH, 27th Apr 2010
" Swap functions with no side effect on the search history or on the screen.
" Moreover, when undone, these version put the cursor back to its first
" position

" Function: SwapWithNext(cursor_pos)
" {cursor_pos} values:
" 'keep' : stays at the same position
" 'follow' : stays with the current word, at the same relative offset
" 'right' : put the cursor at the start of the new right word
" 'left' : put the cursor at the start of the new left word
" todo: move to an autoplugin
" todo: support \w or \k ...

let s:k_entity_pattern = {}
let s:k_entity_pattern.w = {}
let s:k_entity_pattern.w.in = '\w'
let s:k_entity_pattern.w.out = '\W'
let s:k_entity_pattern.w.prev_end = '\zs\w\W\+$'
let s:k_entity_pattern.k = {}
let s:k_entity_pattern.k.in = '\k'
let s:k_entity_pattern.k.out = '\k\@!'
let s:k_entity_pattern.k.prev_end = '\k\(\k\@!.\)\+$'


function! s:SwapWithNext(cursor_pos, type)
    let s = getline('.')
    let l = line('.')
    let c = col('.')-1
    let in = s:k_entity_pattern[a:type].in
    let out = s:k_entity_pattern[a:type].out

    let crt_word_start = match(s[:c], in.'\+$')
    let crt_word_end = match(s, in.out, crt_word_start)
    if crt_word_end == -1
        throw "No next word to swap the current word with"
    endif
    let next_word_start = match(s, in, crt_word_end+1)
    if next_word_start == -1
        throw "No next word to swap the current word with"
    endif
    let next_word_end = match(s, in.out, next_word_start)
    let crt_word = s[crt_word_start : crt_word_end]
    let next_word = s[next_word_start : next_word_end]

    " echo '['.crt_word_start.','.crt_word_end.']='.crt_word
    " \ .'### ['.next_word_start.','.next_word_end.']='.next_word
    let s2 = (crt_word_start>0 ? s[:crt_word_start-1] : '')
    \ . next_word
    \ . s[crt_word_end+1 : next_word_start-1]
    \ . crt_word
    \ . (next_word_end==-1 ? '' : s[next_word_end+1 : -1])
    " echo s2
    call setline(l, s2)
    if a:cursor_pos == 'keep' | let c2 = c+1
        elseif a:cursor_pos == 'follow' | let c2 = c + strlen(next_word) + (next_word_start-crt_word_end)
        elseif a:cursor_pos == 'left' | let c2 = crt_word_start+1
        elseif a:cursor_pos == 'right' | let c2 = strlen(next_word) + next_word_start - crt_word_end + crt_word_start
    endif
    call cursor(l,c2)
endfunction

" Function: SwapWithPrev(cursor_pos)
" {cursor_pos} values:
" 'keep' : stays at the same position
" 'follow' : stays with the current word, at the same relative offset
" 'right' : put the cursor at the start of the new right word
" 'left' : put the cursor at the start of the new left word
" todo: move to an autoplugin
function! s:SwapWithPrev(cursor_pos, type)
let s = getline('.')
let l = line('.')
let c = col('.')-1
let in = s:k_entity_pattern[a:type].in
let out = s:k_entity_pattern[a:type].out
let prev_end = s:k_entity_pattern[a:type].prev_end

let crt_word_start = match(s[:c], in.'\+$')
if crt_word_start == -1
    throw "No previous word to swap the current word with"
endif
let crt_word_end = match(s, in.out, crt_word_start)
let crt_word = s[crt_word_start : crt_word_end]

let prev_word_end = match(s[:crt_word_start-1], prev_end)
let prev_word_start = match(s[:prev_word_end], in.'\+$')
if prev_word_end == -1
throw "No previous word to swap the current word with"
endif
let prev_word = s[prev_word_start : prev_word_end]

" echo '['.crt_word_start.','.crt_word_end.']='.crt_word
" \ .'### ['.prev_word_start.','.prev_word_end.']='.prev_word
let s2 = (prev_word_start>0 ? s[:prev_word_start-1] : '')
\ . crt_word
\ . s[prev_word_end+1 : crt_word_start-1]
\ . prev_word
\ . (crt_word_end==-1 ? '' : s[crt_word_end+1 : -1])
" echo s2
call setline(l, s2)
if a:cursor_pos == 'keep' | let c2 = c+1
    elseif a:cursor_pos == 'follow' | let c2 = prev_word_start + c - crt_word_start + 1
    elseif a:cursor_pos == 'left' | let c2 = prev_word_start+1
    elseif a:cursor_pos == 'right' | let c2 = strlen(crt_word) + crt_word_start - prev_word_end + prev_word_start
endif
call cursor(l,c2)
endfunction

