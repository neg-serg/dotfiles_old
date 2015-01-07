nnoremap Y y$

nnoremap <expr> n <SID>search_forward_p() ? 'nzv' : 'Nzv'
nnoremap <expr> N <SID>search_forward_p() ? 'Nzv' : 'nzv'
vnoremap <expr> n <SID>search_forward_p() ? 'nzv' : 'Nzv'
vnoremap <expr> N <SID>search_forward_p() ? 'Nzv' : 'nzv'

function! s:search_forward_p()
  return exists('v:searchforward') ? v:searchforward : 1
endfunction
" " Keep search matches in the middle of the window.
" nnoremap * *zzzv
" nnoremap # #zzzv
" nnoremap n nzzzv
" nnoremap N Nzzzv

let mapleader      = ','
let maplocalleader = ' '
let g:mapleader    = ","

"Annoying %)
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>
map <Right> <Nop>
map <Left> <Nop>
nmap <space> <Nop>
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
" Get Rid of stupid Goddamned help keys
inoremap <F1> <Nop>
nnoremap <F1> <Nop>
vnoremap <F1> <Nop>

nnoremap <silent> <c-w>t :tabnew<CR>
nnoremap <silent> <c-w>x :tabclose<CR>
nnoremap <silent> <leader>4 :set cursorline!<CR>

nnoremap <silent> <space>cd :lcd %:p:h<CR>:pwd<CR>

nnoremap <silent> <F2> :set invpaste paste?<CR>
nnoremap <A-z> :set invpaste paste?<CR>
set pastetoggle=<A-z>

nnoremap <silent><space>W :set wrap!<CR>

" Traverse buffers, quickly
nnoremap <PageUp> :bp<CR>
nnoremap <PageDown> :bn<CR>

" These create newlines like o and O but stay in normal mode
nnoremap <silent> zj o<Esc>k
nnoremap <silent> zk O<Esc>j

" Now we don't have to move our fingers so far when we want to scroll through
" the command history; also, don't forget the q: command (see :h q: for more
" info)
cnoremap <c-j> <down>
cnoremap <c-k> <up>

" semicolon magic
nnoremap <space>w :w!<cr>
nnoremap q4 :q<cr>

map <silent><space>l :set rnu!<cr>

" like firefox tabs
nnoremap <silent> <A-w> :Bclose<CR>

" Toggle hlsearch for current results
nnoremap <leader><leader> :nohlsearch<CR>
map Q gq

" make those behave like ci' , ci"
nnoremap ci( f(ci(
nnoremap ci{ f{ci{
nnoremap ci[ f[ci[
vnoremap ci( f(ci(
vnoremap ci{ f{ci{
vnoremap ci[ f[ci[

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

map <C-g> g<C-g>

inoremap jk <Esc>

" Toggle last active buffer
nnoremap <leader><Tab> :b#<CR>

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L g_

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" Easier horizontal scrolling
map zl zL
map zh zH

xnoremap <space>c :!octave --silent \| cut -c8-<cr>
"-------[ Quickfix ]------------------------------------------------
nnoremap Q q
nnoremap [Quickfix] <Nop>
nmap q [Quickfix]
nnoremap <silent> [Quickfix]n :<C-u>cnext<CR>
nnoremap <silent> [Quickfix]p :<C-u>cprevious<CR>
nnoremap <silent> [Quickfix]r :<C-u>crewind<CR>
nnoremap <silent> [Quickfix]N :<C-u>cfirst<CR>
nnoremap <silent> [Quickfix]P :<C-u>clast<CR>
nnoremap <silent> [Quickfix]fn :<C-u>cnfile<CR>
nnoremap <silent> [Quickfix]fp :<C-u>cpfile<CR>
nnoremap <silent> [Quickfix]l :<C-u>clist<CR>
nnoremap <silent> [Quickfix]en :<C-u>cnewer<CR>
nnoremap <silent> [Quickfix]ep :<C-u>colder<CR>
" For location list (mnemonic: Quickfix list for the current Window)
nnoremap <silent> [Quickfix]wn :<C-u>lnext<CR>
nnoremap <silent> [Quickfix]wp :<C-u>lprevious<CR>
nnoremap <silent> [Quickfix]wr :<C-u>lrewind<CR>
nnoremap <silent> [Quickfix]wP :<C-u>lfirst<CR>
nnoremap <silent> [Quickfix]wN :<C-u>llast<CR>
nnoremap <silent> [Quickfix]wfn :<C-u>lnfile<CR>
nnoremap <silent> [Quickfix]wfp :<C-u>lpfile<CR>
nnoremap <silent> [Quickfix]wl :<C-u>llist<CR>
nnoremap <silent> [Quickfix]wq :<C-u>ll<CR>
nnoremap <silent> [Quickfix]wo :<C-u>lopen<CR>
nnoremap <silent> [Quickfix]wc :<C-u>lclose<CR>
nnoremap <silent> [Quickfix]wep :<C-u>lolder<CR>
nnoremap <silent> [Quickfix]wen :<C-u>lnewer<CR>

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" g<c-]> is jump to tag if there's only one matching tag, but show list of
" options when there is more than one definition
nnoremap <space>g g<c-]>
