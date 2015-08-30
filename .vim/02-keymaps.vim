nnoremap qe :FZF --color=16<CR>

noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%

nnoremap <Leader>sb :call ToggleBg()<cr>

" paste from clipboard
map <space>pp :set paste<CR>o<esc> "*]p:set nopaste<cr> 

nnoremap Y y$

" Indent paste.
nnoremap <silent> ep o<Esc>pm``[=`]``^
xnoremap <silent> ep o<Esc>pm``[=`]``^
nnoremap <silent> eP O<Esc>Pm``[=`]``^
xnoremap <silent> eP O<Esc>Pm``[=`]``^

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
nnoremap <silent> <space>e  :<C-u>JunkFile<CR>

nnoremap <silent> <F2> :set invpaste paste?<CR>
nnoremap <M-z> :set invpaste paste?<CR>
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
cnoremap <C-j> <down>
cnoremap <C-k> <up>

cnoremap $q <C-\>eDeleteTillSlash()<cr>

" semicolon magic
nnoremap <Space>w :w!<cr>
nnoremap q4 :q<cr>

map <silent><space>l :set rnu!<cr>

" like firefox tabs
nnoremap <silent> <A-w> :Bclose<CR>

" Toggle hlsearch for current results
nnoremap <leader><leader> :nohlsearch<CR>
map Q gq

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
nnoremap <silent> [Quickfix]l :<C-u>clist<CR>

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" g<c-]> is jump to tag if there's only one matching tag, but show list of
" options when there is more than one definition
nnoremap <space>g g<c-]>
