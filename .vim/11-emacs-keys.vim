"----[ Emacs-like bindings for vim ]----
"--{ Control }--
imap <A-d> <C-[>dwi

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
"imap <C-a> <Home>
vmap <C-a> <Home>
omap <C-a> <Home>

" Heresy/emacs-like stuff
inoremap <silent> <c-a> <esc>I
imap <C-e> <End>
vmap <C-e> <End>
omap <C-e> <End>

inoremap <M-a> <C-o>(
vnoremap <M-a> (
onoremap <M-a> (

inoremap <M-e> <C-o>)
vnoremap <M-e> )
onoremap <M-e> )

inoremap <M-<> <C-o>1G<C-o>0
vnoremap <M-<> 1G0
onoremap <M-<> 1G0

inoremap <M->> <C-o>G<C-o>$
vnoremap <M->> G$
onoremap <M->> G$

inoremap <M-Left> <S-Left>
vnoremap <M-Left> <S-Left>
onoremap <M-Left> <S-Left>

inoremap <M-Right> <S-Right>
vnoremap <M-Right> <S-Right>
onoremap <M-Right> <S-Right>
"----[ Command-mode ]----
cnoremap  <c-a>   <home>
cnoremap  <c-e>   <end>
cnoremap  <c-b>   <left>
cnoremap  <c-d>   <del>
cnoremap  <c-f>   <right>
cnoremap  <C-_>   <c-f>
cnoremap  <c-n>   <down>
cnoremap  <c-p>   <up>
cnoremap  <C-*>   <c-a>

" command-T window
let g:CommandTCursorLeftMap = ['<Left>', '<C-b>']
let g:CommandTCursorRightMap = ['<Right>', '<C-f>']
let g:CommandTBackspaceMap = ['<BS>', '<C-h>']
let g:CommandTDeleteMap = ['<Del>', '<C-d>']

imap <M-d> <C-o>de
cmap <M-b> <S-Left>
cmap <M-f> <S-Right>
cnoremap <M-d> <S-Right><C-w>
