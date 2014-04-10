" Get Rid of stupid Goddamned help keys
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" copy or paste from X11 clipboard
" http://vim.wikia.com/wiki/GNU/Linux_clipboard_copy/paste_with_xclip
" requires: xclip
" usage: visual mode select then hit F6 to copy
"       hit F7 to paste from GUI to vim without formating issues
vmap <F6> :!xclip -f -sel clip<CR>
map <F7> mz:-1r !xclip -o -sel clip<CR>`z

" Traverse buffers, quickly
nnoremap <PageUp> :bp<CR>
nnoremap <PageDown> :bn<CR>
" nnoremap <Return> <C-]>

" These create newlines like o and O but stay in normal mode
nnoremap <silent> zj o<Esc>k
nnoremap <silent> zk O<Esc>j

" Now we don't have to move our fingers so far when we want to scroll through
" the command history; also, don't forget the q: command (see :h q: for more
" info)
cnoremap <c-j> <down>
cnoremap <c-k> <up>

" nnoremap ; :
" nnoremap : ;
" vnoremap ; :
" vnoremap : ;
" map ; :
nmap ;w :w!<cr>
nmap ;q :q<cr>
nmap ;d :bd<cr>
nnoremap ;p :call FancyPaste('"')<CR>
nnoremap ;P :call FancyPaste('+')<CR>

nnoremap <silent> gA :A<CR>

" like firefox tabs
nmap <A-w> :bd<cr> 

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

" Easier to type, and I never use the default behavior.
noremap H ^
noremap L g_

" Open a Quickfix window for the last search.

nmap <silent> <leader>l :LustyFilesystemExplorerFromHere<CR>
" nmap <silent> <leader>r :LustyBufferExplorer<CR>
nmap <silent> <leader>g :LustyBufferGrep<CR>

" inoremap <CR> <C-g>u<CR>
nnoremap ! :%!
xnoremap ! :!

map Q gq

" Fix home and end keybindings for screen, particularly on mac
" - for some reason this fixes the arrow keys too. huh.
map [F $
imap [F $
map [H g0
imap [H g0

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" S-arrows suck
vnoremap <S-Up> <Up>
inoremap <S-Up> <Up>
nnoremap <S-Up> <Up>
vnoremap <S-Down> <Down>
inoremap <S-Down> <Down>
nnoremap <S-Down> <Down>
" Indent fun
"vnoremap > >gv
vnoremap < <gv
" Annoying
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>
map <Right> <Nop>
map <Left> <Nop>

noremap! <M-Backspace> <C-W>
noremap! <M-Left> <C-Left>
noremap! <M-Right> <C-Right>

"---------------------------------------------------------------
" => Cope
"---------------------------------------------------------------
" Do :help cope if you are unsure what cope is. It's super useful!
" map <leader>cc :botright cope<cr>
" map <leader>n :cn<cr>
" map <leader>p :cp<cr>

imap <C-c>sw <Esc>:AT<CR>
nmap <C-c>sw :AT<CR>

map <C-c>gt :!ctags -a *.c *.h<CR>
map <C-c>gT :!ctags -Ra *.c *.h<CR>

" List of errors
imap <C-c>l <Esc>:copen<CR>
nmap <C-c>l :copen<CR>
map <C-g> g<C-g>
inoremap <M-H> h
inoremap <M-L> l
inoremap <M-K> <C-g>k
inoremap <M-J> <C-g>j

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

" nnoremap <C-n>     :bnext<CR>
" nnoremap <C-p>     :bprev<CR>

" map p [p

"call Cabbrev('/',   '/\v')
"call Cabbrev('?',   '?\v')
"call Cabbrev('s/',  's/\v')
"call Cabbrev('%s/', '%s/\v')
"call Cabbrev('s#',  's#\v')
"call Cabbrev('%s#', '%s#\v')
"call Cabbrev('s@',  's@\v')
"call Cabbrev('%s@', '%s@\v')
"call Cabbrev('s!',  's!\v')
"call Cabbrev('%s!', '%s!\v')
"call Cabbrev('s%',  's%\v')
"call Cabbrev('%s%', '%s%\v')
"call Cabbrev('/',   '/\v')
"call Cabbrev("'<,'>s/", "'<,'>s/\v")
"call Cabbrev("'<,'>s#", "'<,'>s#\v")
"call Cabbrev("'<,'>s@", "'<,'>s@\v")
"call Cabbrev("'<,'>s!", "'<,'>s!\v")
"vnoremap /        /\v

" save and build
" nmap <LocalLeader>wm  :w<cr>:make<cr>
" Bindings for ctk
" nnoremap <LocalLeader>C :CC<cr>

nmap <F9> :AsyncMake<cr>
nmap <F10> :AsyncMake<cr> 

inoremap <S-Ins> <C-r><C-o>*
" imap <S-Insert> <C-o>p
" Easy buffer navigation
" noremap <C-h>  <C-w>h
" noremap <C-j>  <C-w>j
" noremap <C-k>  <C-w>k
" noremap <C-l>  <C-w>l

map <C-c>np :emenu NewProj.<TAB>

cno $q <C-\>eDeleteTillSlash()<cr>
cno $c e <C-\>eCurrentFileDir("e")<cr>

"inoremap jj <ESC> "Better insert-mode interrupting
inoremap jk <ESC>

cmap     qq     qa!<CR>  " quit really, really fast
cmap     wqq    qw<CR>   " quit really, really fast(with saving)

" nmap <F12> :call UpdateCscopeDb()<cr>
" vmap <F12> <esc>:call UpdateCscopeDb()<cr>
" imap <F12> <esc>:call UpdateCscopeDb()<cr>

" " Use sane regexes.
" nnoremap / /\v
" vnoremap / /\v
" nnoremap ? ?\v
" vnoremap ? ?\v

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

"-----------[ YouCompleteMe ]---------------------------------
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']
let g:ycm_key_invoke_completion = '<A-x>'
" let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
nnoremap <leader>y :YcmForceCompileAndDiagnostics<cr>
"-----------[ UltiSnips ]-------------------------------------
" we can't use <tab> as our snippet key since we use that with YouCompleteMe
let g:UltiSnipsSnippetsDir         = $HOME . '/dotfiles/vim/UltiSnips'
if has("gui_macvim")
  " Ctrl conflicts with "Dvorak-Qwerty Command"
  let g:UltiSnipsExpandTrigger       = "<m-s>"
else
  " Alt conflicts with Xmonad
  let g:UltiSnipsExpandTrigger="<m-s>"
  let g:UltiSnipsJumpForwardTrigger="<m-s>"
  let g:UltiSnipsJumpBackwardTrigger="<m-w>"
  let g:UltiSnipsListSnippets        = "<c-m-s>"
endif

map <S-h> gT
map <S-l> gt

" Stupid shift key fixes
    if has("user_commands")
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
endif


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

" Map <Leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Easier horizontal scrolling
map zl zL
map zh zH

" Tabularize {
    nmap <Leader>a& :Tabularize /&<CR>
    vmap <Leader>a& :Tabularize /&<CR>
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:<CR>
    vmap <Leader>a: :Tabularize /:<CR>
    nmap <Leader>a:: :Tabularize /:\zs<CR>
    vmap <Leader>a:: :Tabularize /:\zs<CR>
    nmap <Leader>a, :Tabularize /,<CR>
    vmap <Leader>a, :Tabularize /,<CR>
    nmap <Leader>a,, :Tabularize /,\zs<CR>
    vmap <Leader>a,, :Tabularize /,\zs<CR>
    nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
" }
" TagBar {
    nnoremap <silent> <leader>tt :TagbarToggle<CR>

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
" }}}

nnoremap <silent> <leader>gv :Gitv --all<CR>
nnoremap <silent> <leader>gV :Gitv! --all<CR>
vnoremap <silent> <leader>gV :Gitv! --all<CR>

nnoremap <Leader>gD :exe 'GHD! '.input("Username: ")<CR>
nnoremap <Leader>gA :exe 'GHA! '.input("Username or repository: ")<CR>
map <Leader>z :ZoomWinTabToggle<CR>
"----[ ViMux ]
map <C-e>rr :call VimuxRunCommand('clear;cd '.expand("%:p:h") .' ;python2 '.bufname("%"))<CR>
map <C-e>r3 :call VimuxRunCommand('clear;cd '.expand("%:p:h") .' ;python3 '.bufname("%"))<CR>
map <C-e>rt :call VimuxRunCommand('clear;cd '.expand("%:p:h") .' ;time python2 '.bufname("%"))<CR>
map <C-e>rp :call VimuxRunCommand('clear;cd '.expand("%:p:h") .' ;time pypy '.bufname("%"))<CR>
map <C-e>rc :VimuxPromptCommand<CR>
map <C-e>rl :VimuxRunLastCommand<CR>
map <C-e>rs :VimuxInterruptRunner<CR>
map <C-e>ri :VimuxInspectRunner<CR>
map <C-e>rq :VimuxCloseRunner<CR>

map <Leader>j :Utl <CR><Bar>:redraw!<CR>

nnoremap <Leader>u :GundoToggle<CR>
map <Leader>x :call RangerChooser()<CR>
"----[ Unite ]-----------------------------------------
" map ff as default f
nnoremap ff f
map e ff
" map f as unite prefix key
nmap f [unite]
xmap f [unite]
nnoremap [unite] <Nop>
xnoremap [unite] <Nop>
" nnoremap <C-e> <Nop>
" menu prefix key (for all Unite menus) {{{
nnoremap <silent>[unite]u :Unite -silent -start-insert -winheight=20 menu<CR>
nnoremap <silent>[unite]m :Unite -silent -start-insert menu:bookmarks<CR>
nnoremap <silent>[unite]v :Unite menu:vim -silent -start-insert<CR>

nnoremap <silent>[unite]o :Unite -silent -start-insert -winheight=17 -start-insert
nnoremap <silent>[unite]s :Unite -silent -start-insert menu:spelling<CR>
nnoremap <silent>[unite]e :Unite -silent -start-insert -winheight=20 menu:text <CR>
nnoremap <silent>[unite]l :Unite -silent -start-insert -winheight=29 -start-insert menu:git<CR>
nnoremap <silent>[unite]8 :UniteWithCursorWord -silent -no-split -auto-preview
            \ line<CR>
nnoremap <silent>[unite]n :Unite -silent -start-insert menu:neobundle<CR>

" mapping for Unite functions
nnoremap <silent> [unite]r :UniteResume<CR>
nnoremap [unite]R :Unite ref/
nnoremap <silent> [unite]b :UniteWithBufferDir file file/new<CR>
nnoremap <silent> <expr> [unite]h ':UniteWithInput -buffer-name=files file file/new -input='. substitute($HOME, '\' ,'/', 'g') .'/<CR>'
nnoremap <silent> [unite]t :Unite tab<CR>
nnoremap <silent> [unite]y :Unite register<CR>
nnoremap <silent> [unite]a :UniteBookmarkAdd<CR>
nnoremap <silent> [unite]p :Unite bookmark -default-action=cd -no-start-insert<CR>
nnoremap <silent> [unite]H :<C-u>Unite history/yank<CR>
nnoremap <silent> [unite]j :Unite buffer_tab <CR>
nnoremap <silent> [unite]* :UniteWithCursorWord line<CR>
nnoremap <silent> [unite]o :Unite -buffer-name=outline outline<CR>
nnoremap <silent> [unite]q :Unite quickfix -no-start-insert<CR>
nnoremap [unite]<SPACE> :Unite local<CR>
nnoremap <expr> [unite]G ':Unite grep:'. expand("%:h") . ':-r'
nnoremap <silent> [unite]b :Unite -silent buffer<CR>
nnoremap <silent><Leader>. :Unite -silent -start-insert file_mru<CR>
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
" use Q for q
nnoremap Q q
" The prefix key.
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
nnoremap <silent> [Quickfix]q :<C-u>cc<CR>
nnoremap <silent> [Quickfix]en :<C-u>cnewer<CR>
nnoremap <silent> [Quickfix]ep :<C-u>colder<CR>
nnoremap <silent> [Quickfix]o :<C-u>copen<CR>
nnoremap <silent> [Quickfix]c :<C-u>cclose<CR>
nmap [Quickfix]m [make]
nnoremap [Quickfix]M q:make<Space>
nnoremap [Quickfix]g q:grep<Space>
" Toggle quickfix window.
nnoremap <silent> [Quickfix]<Space> :<C-u>call <SID>toggle_quickfix_window()<CR>
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

"--[ fswitch ]--------------------------------------------------
" A "companion" file is a .cpp file to an .h file and vice versa
" Opens the companion file in the current window
nnoremap <Leader>sh :FSHere<cr>
" Opens the companion file in the window to the left (window needs to exist)
" This is actually a duplicate of the :FSLeft command which for some reason
" doesn't work.
nnoremap <Leader>sl :call FSwitch('%', 'wincmd l')<cr>
" Same as above, only opens it in window to the right
nnoremap <Leader>sr :call FSwitch('%', 'wincmd r')<cr>
" Creates a new window on the left and opens the companion file in it
nnoremap <Leader>sv :FSSplitLeft<cr>

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
" nnoremap ' `
" nnoremap ` '

" g<c-]> is jump to tag if there's only one matching tag, but show list of
" options when there is more than one definition
" nnoremap <leader>g g<c-]>

