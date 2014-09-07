"Annoying %)
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>
map <Right> <Nop>
map <Left> <Nop>
nmap <space> <Nop>

nnoremap <silent> <c-w>t :tabnew<CR>
nnoremap <silent> <c-w>x :tabclose<CR>

" Get Rid of stupid Goddamned help keys
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

nnoremap <silent> <space>cd :lcd %:p:h<CR>:pwd<CR>
nnoremap <silent> <leader>cd :ProjectRootCD<cr>

nnoremap <F2> :set invpaste paste?<CR>
nnoremap <A-z> :set invpaste paste?<CR>
set pastetoggle=<A-z>

" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

nnoremap <silent><space>w :set wrap!<CR>

" copy or paste from X11 clipboard
" http://vim.wikia.com/wiki/GNU/Linux_clipboard_copy/paste_with_xclip
" requires: xclip
" usage: visual mode select then hit F6 to copy
" hit F7 to paste from GUI to vim without formating issues
vmap <F6> :!xclip -f -sel clip<CR>
map <F7> mz:-1r !xclip -o -sel clip<CR>`z

" Traverse buffers, quickly
nnoremap <PageUp> :bp<CR>
nnoremap <PageDown> :bn<CR>
" nnoremap <Return> <C-]>

" These create newlines like o and O but stay in normal mode
nnoremap <silent> zj o<Esc>k
nnoremap <silent> zk O<Esc>j

" nnoremap <C-up> <c-w>+
" nnoremap <C-down> <c-w>-
" nnoremap <C-left> <c-w><
" nnoremap <C-right> <c-w>>

" Now we don't have to move our fingers so far when we want to scroll through
" the command history; also, don't forget the q: command (see :h q: for more
" info)
cnoremap <c-j> <down>
cnoremap <c-k> <up>

nnoremap ;w :w!<cr>
nnoremap ;q :q<cr>
nnoremap ;d :bd<cr>
nnoremap ;; ;
map <silent><space><space> :set rnu!<cr>

noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

" like firefox tabs
" nmap <A-w> :bd<cr>
nnoremap <silent> <A-w> :Bclose<CR>
nnoremap <silent> <C-x>x :Bclose!<CR>

"--[ Experimental indent file ]--------------------
map <leader>R mz<bar>:retab!<bar>:normal gg=G<cr>`z

" " Wrapped lines goes down/up to next row, rather than next line in file.
" noremap j gj
" noremap k gk
"
" " Same for 0, home, end, etc
" noremap $ g$
" noremap <End> g<End>
" noremap 0 g0
" noremap <Home> g<Home>
" noremap ^ g^

" Toggles '/' to mean eregex search or normal Vim search
nnoremap <leader>/ :call eregex#toggle()<CR>
" " Toggle search highlighting
" nmap <silent> <leader>/ :set invhlsearch<CR>
" Toggle hlsearch for current results
nnoremap <leader><leader> :nohlsearch<CR>

"-------------
"Highlight search
"--
nnoremap * *N
vnoremap * y :execute ":let @/=@\""<CR> :execute "set hlsearch"<CR>
nnoremap <C-F8> :nohlsearch<CR>

nmap <silent> <leader>l :LustyFilesystemExplorerFromHere<CR>

map Q gq

" Fix home and end keybindings for screen, particularly on mac
" - for some reason this fixes the arrow keys too. huh.
map [F $
imap [F $
map [H g0
imap [H g0

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Indent fun
vnoremap > >gv
vnoremap < <gv

map <C-g> g<C-g>

nmap <silent> <leader>sp  :set syn=perl   <CR> :syntax sync fromstart <CR>
nmap <silent> <leader>sv  :set syn=vim    <CR> :syntax sync fromstart <CR>
nmap <silent> <leader>sz  :set syn=sh     <CR> :syntax sync fromstart <CR>
nmap <silent> <leader>sc  :set syn=config <CR> :syntax sync fromstart <CR>
nmap <silent> <leader>sf  :set syn=conf   <CR> :syntax sync fromstart <CR>

" make those behave like ci' , ci"
nnoremap ci( f(ci(
nnoremap ci{ f{ci{
nnoremap ci[ f[ci[

vnoremap ci( f(ci(
vnoremap ci{ f{ci{
vnoremap ci[ f[ci[

"nnoremap d= f=d$a=
"nnoremap d> f>d$a>

" map p [p

" save and build
" nmap <LocalLeader>wm  :w<cr>:make<cr>
" Bindings for ctk
" nnoremap <LocalLeader>C :CC<cr>

nmap <F9> :Make<cr>
nmap MK :Make<cr>
nmap MC :Make clean<cr>

inoremap <S-Ins> <C-r><C-o>*

map <C-c>np :emenu NewProj.<TAB>

cno $q <C-\>eDeleteTillSlash()<cr>
cno $c e <C-\>eCurrentFileDir("e")<cr>

"don't go to left char please
" inoremap <Esc> <Esc>`^`
" inoremap jk <Esc>`^`
inoremap jk <Esc>

" Keep search matches in the middle of the window.
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap n nzzzv
nnoremap N Nzzzv

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
"}

" Toggle last active buffer
nnoremap <leader><Tab> :b#<CR>

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L g_
"-----------[ YouCompleteMe ]---------------------------------
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']
let g:ycm_key_invoke_completion = '<A-x>'
" let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
nnoremap <leader>y :YcmForceCompileAndDiagnostics<cr>
"-----------[ UltiSnips ]-------------------------------------
" we can't use <tab> as our snippet key since we use that with YouCompleteMe
let g:UltiSnipsSnippetsDir         = $HOME . './vim/UltiSnips'
if has("gui_macvim")
  " Ctrl conflicts with Dvorak-Qwerty Command
  let g:UltiSnipsExpandTrigger       = "<m-s>"
else
  let g:UltiSnipsExpandTrigger="<m-s>"
  let g:UltiSnipsJumpForwardTrigger="<m-s>"
  let g:UltiSnipsJumpBackwardTrigger="<m-f>"
  let g:UltiSnipsListSnippets        = "<c-m-s>"
endif

command! -bang -nargs=* -complete=file E e<bang> <args>
command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
cmap Tabe tabe

nnoremap <leader>r :YRShow<CR>
" this makes Y yank from the cursor to the end of the line, which makes more
" sense than the default of yanking the whole current line (we can use yy for
" that)
function! YRRunAfterMaps()
    nnoremap Y   :<C-U>YRYankCount 'y$'<CR>
endfunction

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" Easier horizontal scrolling
map zl zL
map zh zH

nnoremap <silent> <leader>tt :TagbarToggle<CR>
nnoremap <silent> <leader>T :NERDTreeCWD<CR>

nmap <silent> <F11>                       <Plug>FontsizeBegin
nmap <silent> <SID>DisableFontsizeInc     <Plug>FontsizeInc
nmap <silent> <SID>DisableFontsizeDec     <Plug>FontsizeDec
nmap <silent> <SID>DisableFontsizeDefault <Plug>FontsizeDefault

xnoremap <space>c :!octave --silent \| cut -c8-<cr>
"----[ Git ]---------------------------------------------------
nnoremap <Leader>gn :Unite output:echo\ system("git\ init")<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>go :Gread<CR>
nnoremap <Leader>gR :Gremove<CR>
nnoremap <Leader>gm :Gmove<Space>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gB :Gbrowse<CR>
nnoremap <Leader>gp :Git! push<CR>
nnoremap <Leader>gP :Git! pull<CR>
nnoremap <Leader>gi :Git!<Space>
nnoremap <Leader>ge :Gedit<CR>
nnoremap <Leader>gE :Gedit<Space>
nnoremap <Leader>gl :exe "silent Glog <Bar> Unite -no-quit
            \ quickfix"<CR>:redraw!<CR>
nnoremap <Leader>gL :exe "silent Glog -- <Bar> Unite -no-quit
            \ quickfix"<CR>:redraw!<CR>
nnoremap <Leader>gt :!tig<CR>:redraw!<CR>
nnoremap <Leader>gS :exe "silent !shipit"<CR>:redraw!<CR>
nnoremap <Leader>gg :exe 'silent Gvimrcgrep -i '.input("Pattern: ")<Bar>Unite
            \ quickfix -no-quit<CR>
nnoremap <Leader>ggm :exe 'silent Glog --grep='.input("Pattern: ").' <Bar>
            \Unite -no-quit quickfix'<CR>
nnoremap <Leader>ggt :exe 'silent Glog -S='.input("Pattern: ").' <Bar>
            \Unite -no-quit quickfix'<CR>
nnoremap <Leader>ggc :silent! Ggrep -i<Space>

" for the diffmode
noremap <Leader>du :diffupdate<CR>
if !exists(":Gdiffoff")
    command Gdiffoff diffoff | q | Gedit
endif
noremap <Leader>dq :Gdiffoff<CR>

nnoremap <silent> <leader>gv :Gitv --all<CR>
nnoremap <silent> <leader>gV :Gitv! --all<CR>
vnoremap <silent> <leader>gV :Gitv! --all<CR>

nnoremap <Leader>gD :exe 'GHD! '.input("Username: ")<CR>
nnoremap <Leader>gA :exe 'GHA! '.input("Username or repository: ")<CR>
map <Leader>z :ZoomWinTabToggle<CR>

" nmap <F4> :Utl ol<cr>
map <Leader>j :Utl <CR><Bar>:redraw!<CR>

nnoremap <Leader>u :GundoToggle<CR>
map <Leader>x :call RangerChooser()<CR>
"----[ Unite ]-----------------------------------------
nmap e [unite]
xmap e [unite]
nnoremap [unite] <Nop>
xnoremap [unite] <Nop>
" menu prefix key (for all Unite menus) {{{
nnoremap <silent>[unite]u :Unite -silent -start-insert -winheight=20 menu<CR>
nnoremap <silent>[unite]s :Unite -silent -start-insert menu:spelling<CR>
nnoremap <silent>[unite]e :Unite -silent -start-insert -winheight=20 menu:text <CR>
nnoremap <silent>[unite]l :Unite -silent -start-insert -winheight=29 -start-insert menu:git<CR>
nnoremap <silent>[unite]n :Unite -silent -start-insert menu:neobundle<CR>
" mapping for Unite functions
nnoremap <silent> [unite]r :UniteResume<CR>
nnoremap [unite]R :Unite ref/
nnoremap <silent> [unite]t :Unite tab<CR>
nnoremap <silent> [unite]y :Unite register<CR>
nnoremap <silent> [unite]H :<C-u>Unite history/yank<CR>
nnoremap <silent> [unite]j :Unite buffer_tab <CR>
nnoremap <silent> [unite]o :Unite -buffer-name=outline outline<CR>
nnoremap <silent> [unite]q :Unite quickfix -no-start-insert<CR>
nnoremap [unite]<SPACE> :Unite local<CR>
nnoremap <expr> [unite]G ':Unite grep:'. expand("%:h") . ':-r'
nnoremap <silent> [unite]b :Unite -silent buffer<CR>
nnoremap <silent><Leader>. :Unite -silent -start-insert neomru/file<CR>
nnoremap <silent><Leader>d :Unite -silent junkfile/new junkfile<CR>
"-------[ Unite-svn ]-----------------------------------------------
nnoremap <silent> [unite]sd :Unite svn/diff<CR>
nnoremap <silent> [unite]sb :Unite svn/blame<CR>
nnoremap <silent> [unite]ss :Unite svn/status<CR>
nnoremap [unite]s<SPACE> :Unite svn/
"-------[ Unite-gtags ]---------------------------------------------
nnoremap <C-e>d :execute 'Unite gtags/def:'.expand('<cword>')<CR>
nnoremap <C-e>c :execute 'Unite gtags/context'<CR>
nnoremap <C-e>r :execute 'Unite gtags/ref'<CR>
nnoremap <C-e>g :execute 'Unite gtags/grep'<CR>
vnoremap <leader>gg <ESC>:execute 'Unite gtags/def:'.GetVisualSelection()<CR>
"-------[ Quickfix ]------------------------------------------------
nnoremap Q q
nnoremap [Quickfix] <Nop>
nmap q [Quickfix]
nmap [make] :<C-u>make<SPACE>
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
nmap [Quickfix]m [make]
nnoremap [Quickfix]M q:make<Space>
nnoremap [Quickfix]g q:grep<Space>
" Toggle quickfix window.
let g:lt_location_list_toggle_map = '[Quickfix]<Space>'
let g:lt_quickfix_list_toggle_map = '[Quickfix]q'
" nnoremap <silent> [Quickfix]<Space> :<C-u>call <SID>toggle_quickfix_window()<CR>
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
nnoremap <silent> [Quickfix]wm :<C-u>lmake<CR>
nnoremap [Quickfix]wM q:lmake<Space>
nnoremap [Quickfix]w<Space> q:lmake<Space>
nnoremap [Quickfix]wg q:lgrep<Space>

imap <Esc>OH <Plug>delimitMateHome
imap <Esc>OF <Plug>delimitMateEnd

inoremap <expr><BS> pumvisible()? "\<C-y>\<BS>" : "\<BS>"
inoremap <expr><C-h> pumvisible()? "\<C-y>\<C-h>" : "\<C-h>"

vmap c1 "1yy<ESC>i
nmap c1 "1yy
vmap c2 "2yy<ESC>i
nmap c2 "2yy
vmap c3 "3yy<ESC>i
nmap c3 "3yy
vmap c4 "4yy<ESC>i
nmap c4 "4yy
vmap c5 "5yy<ESC>i
nmap c5 "5yy
vmap c6 "6yy<ESC>i
nmap c6 "6yy
vmap c7 "7yy<ESC>i
nmap c7 "7yy
vmap c8 "8yy<ESC>i
nmap c8 "8yy
vmap c9 "9yy<ESC>i
nmap c9 "9yy
vmap c0 "0yy<ESC>i
nmap c0 "0yy

nmap J :Join<CR>
vmap J :Join<CR>

"--[ fswitch ]--------------------------------------------------
" A "companion" file is a .cpp file to an .h file and vice versa
" Opens the companion file in the current window
nnoremap <Space>sh :FSHere<cr>
" Opens the companion file in the window to the left (window needs to exist)
" This is actually a duplicate of the :FSLeft command which for some reason
" doesn't work.
nnoremap <Space>sl :call FSwitch('%', 'wincmd l')<cr>
" Same as above, only opens it in window to the right
nnoremap <Space>sr :call FSwitch('%', 'wincmd r')<cr>
" Creates a new window on the left and opens the companion file in it
nnoremap <Space>sv :FSSplitLeft<cr>

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

" g<c-]> is jump to tag if there's only one matching tag, but show list of
" options when there is more than one definition
nnoremap <space>g g<c-]>

" With this map, we can select some text in visual mode and by invoking the map,
" have the selection automatically filled in as the search text and the cursor
" placed in the position for typing the replacement text. Also, this will ask
" for confirmation before it replaces any instance of the search text in the
" file.
" NOTE: We're using %S here instead of %s; the capital S version comes from the
" eregex.vim plugin and uses Perl-style regular expressions.
vnoremap <C-r> "hy:%S/<C-r>h//c<left><left>

nmap <silent><space>d  :GasyncTagsEnable<CR>

"----[ ViMux ]
map <Space>rc :VimuxPromptCommand<CR>
map <Space>rl :VimuxRunLastCommand<CR>
map <Space>rs :VimuxInterruptRunner<CR>
map <Space>ri :VimuxInspectRunner<CR>
map <Space>rq :VimuxCloseRunner<CR>
