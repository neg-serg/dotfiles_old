nmap <LocalLeader> <C-e>

" Traverse buffers, quickly

nnoremap <PageUp> :bp<CR>
nnoremap <PageDown> :bn<CR>
" nnoremap <Return> <C-]>

nmap ;w :w!<cr>
nmap ;q :q<cr>
nmap ;d :bd<cr>

" like firefox tabs
nmap <A-w> :bd<cr> 

map <leader>r mz<bar>:retab!<bar>:normal gg=G<cr>`z

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

" Toggle search highlighting
nmap <silent> <leader>/ :set invhlsearch<CR>
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
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

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

map p [p

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
nmap <LocalLeader>wm  :w<cr>:make<cr>
" Bindings for ctk
nnoremap <LocalLeader>C :CC<cr>

nmap <F9> :SCCompile<cr>
nmap <F10> :SCCompileRun<cr> 

imap <S-Insert> <C-o>p
" Easy buffer navigation
noremap <C-h>  <C-w>h
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l

map <C-c>np :emenu NewProj.<TAB>

imap <Esc>OH <Plug>delimitMateHome
imap <Esc>OF <Plug>delimitMateEnd

cno $q <C-\>eDeleteTillSlash()<cr>
cno $c e <C-\>eCurrentFileDir("e")<cr>

"inoremap jj <ESC> "Better insert-mode interrupting
inoremap jk <ESC>

cmap     qq     qa!<CR>  " quit really, really fast
cmap     wqq    qw<CR>   " quit really, really fast(with saving)

nmap <F12> :call UpdateCscopeDb()<cr>
vmap <F12> <esc>:call UpdateCscopeDb()<cr>
imap <F12> <esc>:call UpdateCscopeDb()<cr>

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

"------------ YouCompleteMe ----------------------------------
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']
let g:ycm_key_invoke_completion = '<A-x>'
" let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
"------------ UltiSnips ----------------------------------
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:Ultisnips_ListSnippets=""

"easier tabs
" map <S-H> gT
" map <S-L> gt

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
" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

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
" Session List {
    set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
    nmap <leader>sl :SessionList<CR>
    nmap <leader>ss :SessionSave<CR>
" }
" TagBar {
    nnoremap <silent> <leader>tt :TagbarToggle<CR>

nmap <silent> <F11>                       <Plug>FontsizeBegin
nmap <silent> <SID>DisableFontsizeInc     <Plug>FontsizeInc
nmap <silent> <SID>DisableFontsizeDec     <Plug>FontsizeDec
nmap <silent> <SID>DisableFontsizeDefault <Plug>FontsizeDefault

xnoremap <space>c :!octave --silent \| cut -c8-<cr>

nnoremap ;p :call FancyPaste('"')<CR>
nnoremap ;P :call FancyPaste('+')<CR>

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
nnoremap <Leader>gg :exe 'silent Ggrep -i '.input("Pattern: ")<Bar>Unite
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
" map f as unite prefix key
nmap f [unite]
xmap f [unite]
nnoremap [unite] <Nop>
xnoremap [unite] <Nop>
nnoremap <C-e> <Nop>
" menu prefix key (for all Unite menus) {{{
nnoremap <silent>[unite]u :Unite -silent -start-insert -winheight=20 menu<CR>
nnoremap <silent>[unite]k :Unite -silent -start-insert menu:markdown<CR>
nnoremap <silent>[unite]m :Unite -silent -start-insert menu:bookmarks<CR>
nnoremap <silent>[unite]v :Unite menu:vim -silent -start-insert<CR>

nnoremap <silent>[unite]o :Unite -silent -start-insert -winheight=17 -start-insert
nnoremap <silent>[unite]s :Unite -silent -start-insert menu:spelling<CR>
nnoremap <silent>[unite]e :Unite -silent -start-insert -winheight=20 menu:text <CR>
nnoremap <silent>[unite]g :Unite -silent -start-insert -winheight=29 -start-insert menu:git<CR>
nnoremap <silent>[unite]p :Unite -silent -start-insert -winheight=42 menu:code<CR>
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
nnoremap <silent> [unite]j :Unite buffer_tab -no-start-insert<CR>
nnoremap <silent> [unite]* :UniteWithCursorWord line<CR>
nnoremap <silent> [unite]o :Unite -buffer-name=outline outline<CR>
nnoremap <silent> [unite]q :Unite quickfix -no-start-insert<CR>
nnoremap [unite]<SPACE> :Unite local<CR>
nnoremap <silent><Leader>p :Unite -silent -start-insert file_mru<CR>
nnoremap <expr> [unite]G ':Unite grep:'. expand("%:h") . ':-r'
nnoremap <silent> [unite]b :Unite -silent buffer<CR>
nnoremap <silent><Leader>d :Unite -silent junkfile/new junkfile<CR>
"-------[ Unite-svn ]-----------------------------------------------
nnoremap <silent> [unite]sd :Unite svn/diff<CR>
nnoremap <silent> [unite]sb :Unite svn/blame<CR>
nnoremap <silent> [unite]ss :Unite svn/status<CR>
nnoremap [unite]s<SPACE> :Unite svn/
"-------[ Unite-gtags ]---------------------------------------------
nnoremap [unite]gg :execute 'Unite gtags/def:'.expand('<cword>')<CR>
nnoremap [unite]gc :execute 'Unite gtags/context'<CR>
nnoremap [unite]gr :execute 'Unite gtags/ref'<CR>
nnoremap [unite]ge :execute 'Unite gtags/grep'<CR>
nnoremap <C-j> :Unite gtags/context<CR>
vnoremap <leader>gg <ESC>:execute 'Unite gtags/def:'.GetVisualSelection()<CR>
