set shell=/bin/bash
if bufname('%') == ''
  set bufhidden=wipe
endif
if v:version >= 704
  " The new Vim regex engine is currently slooooow as hell which makes syntax
  " highlighting slow, which introduces typing latency.
  " Consider removing this in the future when the new regex engine becomes
  " faster.
  " set regexpengine=1
  " Now I make it autodetect
  set regexpengine=0
endif

if has("gui_running")
    if &diff
        set gfn=PragmataPro\ for\ Powerline\ 10
        set guifontwide=PragmataPro\ for\ Powerline\ 10
        " colorscheme hybrid
        colorscheme jellybeans
    else
        set gfn=PragmataPro\ for\ Powerline\ 14
        set guifontwide=PragmataPro\ for\ Powerline\ 14
        " set lsp=-1
        let g:mirodark_enable_higher_contrast_mode=0
        colorscheme mirodark
    endif

    set timeout ttimeout
    set timeoutlen=2000 ttimeoutlen=10 " Very fast and also you shouldn't make combination too fast

    set lsp=1                          " Space between lines
    set go=c                           " For text messages instead of gui
    set background=dark                " Usable for colorschemes
    set noantialias                    " Disable antialiasing
    set colorcolumn=0                  " Color eol limiter off
    set mousehide                      " hide the mouse pointer while typing
    set mousemodel=popup               " right mouse button pops up a menu in the GUI
    "set mouse=a                       " enable full mouse support
    set mouse=                         " enable full mouse support
    set ttymouse=urxvt                 " more accurate mouse tracking
    set ttyfast                        " more redrawing characters sent to terminal

    set synmaxcol=256                  " improve hi performance
    syntax sync minlines=190
    set ttyscroll=40
    set lazyredraw

    "set selection=exclusive           " exclusive selection is better [?]

    set previewheight=8                " Preview window should be minimal

    set winaltkeys=no                  "
    set wildcharm=<Tab>                " Want to be able to use <Tab> within our mappings

    set ballooneval                    " add popups for gui
    set balloondelay=400               " popups delay

    set fillchars=stl:\ ,stlnc:\ ,vert:│
    set guitablabel=%-0.12t%M

    set guicursor=n-v-c:block-Cursor   " Full cursor for visual,command,normal
    set guicursor+=i:ver40-iCursor     " It set cursor width in insert mode
    set guicursor+=n-v-c:blinkon0      " Disable all blinking:
    set guicursor+=a:blinkon0          " Disable all blinking:

    set guioptions=                    " Disable all gui-oriented options in gvim

endif

if !has("gui_running")
    set runtimepath+=~/.vim/bundle/powerline/powerline/bindings/vim
    set t_Co=256 " I use 256-color terminals
    if &term == "rxvt-unicode-256color" || &term  == "screen-256color"
        colorscheme wim
    elseif &term =~ 'linux'
        colorscheme darkblue
        set t_Co=8 " I use 7-color term in $term = linux
    else
        colorscheme jellybeans
    endif

    " enable ctrl interpreting for vim
    silent !stty -ixon > /dev/null 2>/dev/null
    silent !stty start undef > /dev/null 2>/dev/null
    silent !stty stop undef > /dev/null 2>/dev/null

    " set ttyscroll=256                " try to speedup scrolling
    set ttyscroll=4                    " try to speedup scrolling
    set ttymouse=urxvt                 " more accurate mouse tracking
    set ttyfast                        " more redrawing characters sent to terminal

    set synmaxcol=256                  " improve hi performance
    " set showmode                     " show what key had been pressed
    set lazyredraw                     " it's doesn't set by default for tmux

    if exists('$TMUX')
        let s:not_tmuxed_vim = system(expand("~/bin/scripts/not_tmuxed_wim"))
        if s:not_tmuxed_vim =~ "FALSE"
            set t_ut=
            autocmd VimEnter * silent !echo -ne "\033Ptmux;\033\033]12;rgb:b0/d0/f0\007\033\\"
            let &t_SI="\033Ptmux;\033\033]12;rgb:32/4c/80\007\033\\"
            let &t_EI="\033Ptmux;\033\033]12;rgb:b0/d0/f0\007\033\\"
            autocmd VimEnter * silent !tmux set status off
            set timeout ttimeout
            set timeoutlen=2000 ttimeoutlen=0 " Very fast and also you shouldn't make combination too fast
            autocmd VimLeave * silent !tmux set status on;
                \ echo -ne "\033Ptmux;\033\033]12;rgb:b0/d0/f0\007\033\\"
        endif
    endif
endif

if has ('x') && has ('gui') " On Linux use + register for copy-paste
    set clipboard=unnamedplus
elseif has ('gui')          " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
endif

" convert "\\" to "/" on win32 like environment
if exists('+shellslash')
    set shellslash
endif

command! -range=% Share silent <line1>,<line2>write !curl -s -F "sprunge=<-" http://sprunge.us | head -n 1 | tr -d '\r\n ' | DISPLAY=:0.0 xclip
command! -nargs=1 Indentation silent set ts=<args> shiftwidth=<args>
command! -nargs=1 IndentationLocal silent setlocal ts=<args> shiftwidth=<args>
command! -bang -nargs=* -complete=file E e<bang> <args>
command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
"----------------------------------------------------------------------------
set keywordprg=:help
let $PATH = $PATH . ':' . expand("~/bin/go/bin")

set encoding=utf-8                          " Set default enc to utf-8
scriptencoding utf-8                        " Encoding used in the script
" set autowrite                             " Autowrite by default
set noautowrite                             " Don't autowrite by default
set noautochdir                             " Dont't change pwd automaticly
" set autochdir                             " Change pwd automaticly
set noshowmode                              " no show the mode ("-- INSERT --") at the bottom

" Automatically re-read files that have changed as long as there
" are no outstanding edits in the buffer.
set autoread

set formatprg=par                           " use par as formatter

" 'fileencodings' contains a list of possible encodings to try when reading
" a file.  When 'encoding' is a unicode value (such as utf-8), the
" value of fileencodings defaults to ucs-bom,utf-8,default,latin1.
"   ucs-bom  Treat as unicode-encoded file if and only if BOM is present
"   utf-8    Use utf-8 encoding
"   default  Value from environment LANG
"   latin1   8-bit encoding typical of DOS
" Setting this value explicitly, though to the default value.
set fileencodings=utf-8,default,latin1,cp1251,koi8-r,cp866

set termencoding=utf8                       " Set termencoding to utf-8
"--------------------------------------------------------------------------
" Where file browser's directory should begin:
"   last    - same directory as last file browser
"   buffer  - directory of the related buffer
"   current - current directory (pwd)
"   {path}  - specified directory
set browsedir=buffer

" What to do when opening a new buffer. May be empty or may contain
" comma-separated list of the following words:
" useopen   - use existing windows if possible.
" usetab    - like useopen but also checks other tabs
" split     - split current window before loading a buffer
" 'useopen' may be useful for re-using QuickFix window.
set switchbuf=useopen,usetab

if has('unnamedplus')
  " By default, Vim will not use the system clipboard when yanking/pasting to
  " the default register. This option makes Vim use the system default
  " clipboard.
  " Note that on X11, there are _two_ system clipboards: the "standard" one, and
  " the selection/mouse-middle-click one. Vim sees the standard one as register
  " '+' (and this option makes Vim use it by default) and the selection one as '*'.
  " See :h 'clipboard' for details.
  set clipboard=unnamedplus,unnamed
else
  " Vim now also uses the selection system clipboard for default yank/paste.
  set clipboard+=unnamed
endif

" set completeopt=menu
set completeopt=menu,menuone,longest
"probably it will increase lusty+gundo speed
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set noshowmatch                 " Show matching brackets/parenthesis
let loaded_matchparen = 1       " Don't show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set winminwidth=0               " Windows can be 0 line width
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set matchtime=2                 " Default time to hi brackets too long for me

" allow backspace and cursor keys to cross line boundaries
set gdefault                    " this makes search/replace global by default
set showcmd                     " Show partial commands in status line and Selected characters/lines in visual mode

" set nowrap                    " Do not wrap lines
set wrap                        " Wrap lines
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)

set scrolljump=1                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
" Windowing settings set splitright splitbelow
"set swapsync=""                " don't call fsync() or sync(); let linux handle it
" set autowrite                 " Automatically write a file when leaving a modified buffer
set virtualedit=onemore         " Allow for cursor beyond last character
set noswapfile                  " Disable swap to prevent ugly messages
set shortmess=a                 " Abbrev. of messages (avoids 'hit enter')
" set shortmess+=filmnrxoOtT    " Abbrev. of messages (avoids 'hit enter')
set more                        " probably it should get out 'Press enter' msg
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set nofoldenable                " Disable folds as
set history=1000                " Store a ton of history (default is 20)
" set spell                     " Spell checking on
set shiftwidth=4                " spaces for autoindents
set shiftround                  " makes indenting a multiple of shiftwidth
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set smarttab
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set matchpairs+=<:>             " Match, to be used with %
"set matchpairs+==:;            " Match, to be used with %
"set matchpairs+=<:>            " Match, to be used with %
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
set equalalways                 " keep windows equal when splitting (default)
set eadirection=hor             " ver/hor/both - where does equalalways apply

set pastetoggle=<F2>            " Pastetoggle (sane indentation on pastes)
set nopaste                     " Disable paste by default
set hidden                      " It hides buffers instead of closing them
"--[ change undo file location ]----------------------------------
if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  silent !mkdir -p ~/trash > /dev/null 2>&1
  set undodir=~/trash/
  set undofile
endif

set formatoptions=tcroqnj

" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
" set formatoptions+=t    " auto-wrap using textwidth (not comments)
" set formatoptions+=c    " auto-wrap comments too
" set formatoptions+=r    " continue the comment header automatically on <CR>
" set formatoptions-=o    " don't insert comment leader with 'o' or 'O'
" set formatoptions+=q    " allow formatting of comments with gq
" set formatoptions+=n    " recognize numbered lists when autoindenting
" set formatoptions-=2    " don't use second line of paragraph when autoindenting
" set formatoptions-=v    " don't worry about vi compatiblity
" set formatoptions-=b    " don't worry about vi compatiblity
" set formatoptions+=l    " don't break long lines in insert mode
" set formatoptions+=1    " don't break lines after one-letter words, if possible

" this can cause problems with other filetypes
" see comment on this SO question http://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim/234578#234578
set autoindent          " on new lines, match indent of previous line
" set smartindent         " smart auto indenting
set copyindent          " copy the previous indentation on autoindenting
set cindent             " smart indenting for c-like code
set cino=b1,g0,N-s,t0,(0,W4  " see :h cinoptions-values
set laststatus=2        " requied by PowerLine/Airline

set nocursorline        " highlight current line is too slow
set backup              " backuping is good

set backupdir=~/trash
set directory=~/trash
set undofile            " So is persistent undo ...
set undolevels=1000     " Maximum number of changes that can be undone
set undoreload=10000    " Maximum number lines to save for undo on a buffer reload
set cpoptions=aAceFsBd
" ---------------- Folds --------------------------------------
set maxfuncdepth=1000
set maxmemtot=200000

set viminfo=%100,'100,/100,h,\"500,:100,n~/.viminfo
" set nomodeline                        " enable modelines
set modeline                        " enable modelines
set grepprg=ag\ --nogroup\ --nocolor  "use ag over grep

set iminsert=0                        " write latin1 characters first
set imsearch=0                        " search with latin1 characters first
set cmdheight=1                       " standard cmdline height

"--[ Ctags ]----------------------
set tags=./tags
" Make tags placed in .git/tags file available in all levels of a repository
let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
if gitroot != ''
    let &tags = &tags . ',' . gitroot . '/.git/tags'
endif

if has("cscope")
    if executable("gtags")
        set csprg=/usr/bin/gtags-cscope
    else
        set csprg=/usr/bin/cscope
    endif
    set csto=0
    set cscopetag
    " set cscopequickfix=s-,c-,d-,i-,t-,e-

    let GtagsCscope_Auto_Map        = 1
    let GtagsCscope_Use_Old_Key_Map = 0
    let GtagsCscope_Ignore_Case     = 1
    let GtagsCscope_Absolute_Path   = 1
    let GtagsCscope_Keep_Alive      = 1
    let GtagsCscope_Auto_Load       = 0

    "Alternative workground to work with cscope
    NeoBundle 'https://bitbucket.org/madevgeny/yate.git'
endif

set printoptions=paper:A4,syntax:n,wrap:y,header:0,number:n,duplex:off
set printoptions+=left:2,right:2,top:2,bottom:2
set printfont=-windows-montecarlo-medium-r-normal--11-110-72-72-c-60-microsoft-cp1252
set printmbfont=r:-windows-montecarlo-medium-r-normal--11-110-72-72-c-60-microsoft-cp1252
set printmbfont+=b:-windows-montecarlo-bold-r-normal--11-110-72-72-c-60-microsoft-cp1252
set printmbfont+=i:-windows-montecarlo-medium-r-normal--11-110-72-72-c-60-microsoft-cp1252
set pumheight=10

iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>

" Options initiating with ?m?
" [global] |'magic'| Set 'magic' patterns ;)
" Examples:
"  \v       \m       \M       \V         matches ~
"  $        $        $        \$         matches end-of-line
"  .        .        \.       \.         matches any character
"  *        *        \*       \*         any number of the previous atom
"  ()       \(\)     \(\)     \(\)       grouping into an atom
"  |        \|       \|       \|         separating alternatives
"  \a       \a       \a       \a         alphabetic character
"  \\       \\       \\       \\         literal backslash
"  \.       \.       .        .          literal dot
"  \{       {        {        {          literal '{'
"  a        a        a        a          literal 'a'
set magic

set path+=/usr/include,/usr/lib/gcc/x86_64-unknown-linux-gnu/4.9.0/include,**
set path+=./include,../include,/opt/cuda/include
execute 'set path+=/usr/lib/modules/'.system('uname -r')[:-2].'/build/include'
execute 'set path+=/usr/lib/modules/'.system('uname -r')[:-2].'/build/arch/x86/include'

" this makes sure that shell scripts are highlighted
" as bash scripts and not sh scripts
let g:is_posix        = 1
" When using the taglist plugin, don't attempt to resize the terminal
let g:is_bash          = 1

let g:session_autoload = "no"
let g:session_autosave = "yes"

command! -bar -bang -nargs=+ SplitNicely
            \ call s:cmd_split_nicely(<q-args>, <bang>0)
function! s:cmd_split_nicely(q_args, bang)
    let winnum = winnr('$')
    let vertical = 0
    let save_winwidth = winwidth(0)
    let save_winheight = winheight(0)
    execute 'belowright' (vertical ? 'vertical' : '') a:q_args
    if winnr('$') is winnum
        " if no new window is opened
        return
    endif
    " Adjust split window.
    if a:bang
        if !&l:winfixwidth
            execute save_winwidth / 3 'wincmd |'
        endif
        if !&l:winfixheight
            execute save_winheight / 2 'wincmd _'
        endif
        setlocal winfixwidth winfixheight
    endif
endfunction

" expirimental autopaste for vim
function! WrapForTmux(s)
    if !exists('$TMUX')
        return a:s
    endif
    let tmux_start = "\<Esc>Ptmux;"
    let tmux_end = "\<Esc>\\"
    return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
    set pastetoggle=<Esc>[201~
    set paste
    return ""
endfunction
