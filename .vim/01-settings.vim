" ------[ GUI settings ]-----------------------------------------------------
" colorscheme solarized
if has("gui_running")
    set gfn=PragmataPro\ for\ Powerline\ 14
    " set gfn=PragmataPro\ for\ Powerline\ 15
    " set lsp=-1
    set lsp=1                          " Space between lines
    set go=c                           " For text messages instead of gui
    set background=dark                " Usable for colorschemes
    set noantialias                    " Disable antialiasing
    set clipboard=unnamed              " Default copy to unnamed
    set colorcolumn=0                  " Color eol limiter off
    set mousehide                      " hide the mouse pointer while typing
    set mousemodel=popup               " right mouse button pops up a menu in the GUI
    set mouse=a                        " enable full mouse support
    set ttymouse=xterm2                " more accurate mouse tracking
    set ttyfast                        " more redrawing characters sent to terminal

    set guicursor=n-v-c:block-Cursor   " Full cursor for visual,command,normal
    set guicursor+=i:ver40-iCursor     " It set cursor width in insert mode
    set guicursor+=n-v-c:blinkon0      " Disable all blinking:
    set guicursor+=a:blinkon0          " Disable all blinking:

    " Paste from PRIMARY and CLIPBOARD
    inoremap <silent> <M-v> <Esc>"+p`]a
    inoremap <silent> <S-Insert> <Esc>"*p`]a
    let g:mirodark_enable_higher_contrast_mode=0
    colorscheme mirodark
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    let g:solarized_contrast="normal"
    let g:solarized_visibility="normal"
    " colorscheme solarized
    set ttyscroll=0
endif
"----------------------------------------------------------------------------
let $PATH = $PATH . ':' . expand("~/.cabal/bin")

set encoding=utf-8                          " Set default enc to utf-8
" set autowrite                             " Autowrite by default
set noautowrite                             " NoAutowrite by default

" Automatically re-read files that have changed as long as there
" are no outstanding edits in the buffer.
set autoread

" 'fileencodings' contains a list of possible encodings to try when reading
" a file.  When 'encoding' is a unicode value (such as utf-8), the
" value of fileencodings defaults to ucs-bom,utf-8,default,latin1.
"   ucs-bom  Treat as unicode-encoded file if and only if BOM is present
"   utf-8    Use utf-8 encoding
"   default  Value from environment LANG
"   latin1   8-bit encoding typical of DOS
" Setting this value explicitly, though to the default value.
set fileencodings=ucs-bom,utf-8,default,latin1,cp1251,koi8-r,cp866

set termencoding=utf8                       " Set termencoding to utf-8
set fileencodings=utf-8,cp1251              " Set fileenc list

set timeout timeoutlen=250
set ttimeout ttimeoutlen=40  " Usable for fast keybindings
"--------------------------------------------------------------------------
" Where file browser's directory should begin:
"   last    - same directory as last file browser
"   buffer  - directory of the related buffer
"   current - current directory (pwd)
"   {path}  - specified directory
set browsedir=buffer

" What to do when opening a new buffer. May be empty or may contain
" comma-separated list of the following words:
"   useopen   - use existing windows if possible.
"   usetab    - like useopen but also checks other tabs
"   split     - split current window before loading a buffer
" 'useopen' may be useful for re-using QuickFix window.
set switchbuf=

set t_Co=256                                " I use 256-color terminals
  
" Clipboard
if has('unnamedplus-that-really-truly-works')
    set clipboard=unnamedplus   " use X11 SYSTEM clipboard
else
    set clipboard=unnamed       " use X11 PRIMARY clipboard (selection)
endif

syntax sync minlines=256
set completeopt=menu
"syn sync minlines=1000
"probably it will increase lusty+gundo speed
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set winminwidth=0               " Windows can be 0 line width
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.

" set nowrap                      " Do not wrap lines
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too

set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set clipboard-=autoselect clipboard+=autoselectml
" Windowing settings set splitright splitbelow
"set swapsync=""                " don't call fsync() or sync(); let linux handle it
" set autowrite                   " Automatically write a file when leaving a modified buffer
" set virtualedit=onemore         " Allow for cursor beyond last character
set noswapfile                  " Disable swap to prevent ugly messages
set shortmess+=filmnrxoOtT      " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set history=1000                " Store a ton of history (default is 20)
" set spell                     " Spell checking on
set expandtab                   " Tabs are spaces, not tabs
set shiftwidth=4                " Use indents of 4 spaces
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
set hidden                      " It hides buffers instead of closing them
"" -----------------------------------------------------------------
"" --[ change undo file location ]----------------------------------
"" -----------------------------------------------------------------
if exists("+undofile")
  " undofile - This allows you to use undos after exiting and restarting
  " This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
  " :help undo-persistence
  " This is only present in 7.3+
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif
" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set formatoptions+=t    " auto-wrap using textwidth (not comments)
set formatoptions+=c    " auto-wrap comments too
set formatoptions+=r    " continue the comment header automatically on <CR>
set formatoptions-=o    " don't insert comment leader with 'o' or 'O'
set formatoptions+=q    " allow formatting of comments with gq
" set formatoptions-=w   " double-carriage-return indicates paragraph
" set formatoptions-=a   " don't reformat automatically
set formatoptions+=n    " recognize numbered lists when autoindenting
set formatoptions+=2    " use second line of paragraph when autoindenting
set formatoptions-=v    " don't worry about vi compatiblity
set formatoptions-=b    " don't worry about vi compatiblity
set formatoptions+=l    " don't break long lines in insert mode
set formatoptions+=1    " don't break lines after one-letter words, if possible
set cindent             " stricter rules for C programs

set laststatus=2        " requied by PowerLine/Airline

set cursorline          " highlight current line
set backup              " backuping is good

set backupdir=~/trash
set directory=~/trash
set undofile            " So is persistent undo ...
set undolevels=1000     " Maximum number of changes that can be undone
set undoreload=10000    " Maximum number lines to save for undo on a buffer reload
set cpoptions=aAceFsBd
" ---------------- Folds --------------------------------------
" set foldmethod=indent               "fold based on indent
" set foldenable                      "fold by default
" set foldnestmax=3                   "deepest fold is 3 levels
" set nofoldenable                    "dont fold by default

set fillchars=vert:│
set maxfuncdepth=1000
set maxmemtot=200000

set viminfo=%100,'100,/100,h,\"500,:100,n~/.viminfo
set modeline          " enable modelines
set grepprg=grep\ -nH\ $*

set iminsert=0
set cmdheight=1

if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=0
  set cst
  if filereadable("cscope.out")
    cs add cscope.out
  endif
endif
if has ('x') && has ('gui') " On Linux use + register for copy-paste
    set clipboard=unnamedplus
elseif has ('gui')          " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
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

set path=**
" indent_guides {
    let g:indent_guides_auto_colors = 1
    " For some colorschemes, autocolor will not work (eg: 'desert', 'ir_black')
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#212121 ctermbg=3
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#404040 ctermbg=4
    let g:indent_guides_start_level = 2
    let g:indent_guides_guide_size = 1
    let g:indent_guides_enable_on_vim_startup = 1
" }
" Ctags {
    set tags=./tags;/,~/.vim/tags

    " Make tags placed in .git/tags file available in all levels of a repository
    let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
    if gitroot != ''
        let &tags = &tags . ',' . gitroot . '/.git/tags'
    endif
" }
let g:gundo_playback_delay = 240

let mapleader=','
let maplocalleader=','
let g:mapleader = ","

let g:LustyJugglerDefaultMappings=0
let LustyExplorerDefaultMappings=0
" -------------------------------------------------------------------
" When using the taglist plugin, don't attempt to resize the terminal
let Tlist_Inc_Winwidth=0
" shell is bash
let g:is_bash=1
" clojure syntax config
let g:clj_highlight_builtins=1
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlPMRUFiles'
let g:haddock_browser = "dwb"

"Add existing project to project tree
"Works through ass, but WORKS!
if filereadable("Makefile")
    set makeprg=make
else
    set makeprg=gcc\ -Wall\ -o\ %<\ %
endif

let g:airline_powerline_fonts = 1 " Use airline fonts
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#whitespace#checks = []

let g:airline_exclude_preview=1
let g:airline_symbols = {}
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = ' '
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_mode_map = {
  \ '__' : '-',
  \ 'n'  : 'N',
  \ 'i'  : 'I',
  \ 'R'  : 'R',
  \ 'c'  : 'C',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ '' : 'V',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ '' : 'S',
  \ }

let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra.conf.py'
let g:ycm_extra_conf_globlist = ['~/dev/*','!~/*']
let g:ycm_confirm_extra_conf = 0

let g:ycm_filetype_blacklist = {
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'text' : 1,
      \ 'unite' : 1,
      \}

" https://github.com/airblade/vim-gitgutter/issues/106
let g:gitgutter_realtime = 0

let g:yankring_history_file = '/tmp/yankring_hist'
