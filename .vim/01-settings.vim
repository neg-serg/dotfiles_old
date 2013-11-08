" ------[ GUI settings ]-----------------------------------------------------
" colorscheme solarized
if has("gui_running")
    set gfn=PragmataPro\ for\ Powerline\ 14
    " set lsp=-1
    set lsp=1
    set go=c
    set background=dark
    set noantialias
    set clipboard=unnamed
    set colorcolumn=0
    highlight SpellBad term=underline gui=undercurl guisp=Orange 
    set mousehide                 " hide the mouse pointer while typing
    set mousemodel=popup	        " right mouse button pops up a menu in the GUI
    set mouse=a         " enable full mouse support
    set ttymouse=xterm2 " more accurate mouse tracking
    set ttyfast         " more redrawing characters sent to terminal

    set guicursor=n-v-c:block-Cursor
    set guicursor+=i:ver40-iCursor     "it set cursor width in insert mode
    set guicursor+=n-v-c:blinkon0      " Disable all blinking:
    set guicursor+=a:blinkon0          " Disable all blinking:

    " Paste from PRIMARY and CLIPBOARD
    inoremap <silent> <M-v> <Esc>"+p`]a
    inoremap <silent> <S-Insert> <Esc>"*p`]a
    let g:mirodark_enable_higher_contrast_mode=0
    colorscheme mirodark
    " let g:solarized_termcolors=256
    " let g:solarized_termtrans=1
    " let g:solarized_contrast="normal"
    " let g:solarized_visibility="normal"
    " colorscheme solarized
endif
"----------------------------------------------------------------------------
let $PATH = $PATH . ':' . expand("~/.cabal/bin")

set encoding=utf-8
set termencoding=utf8
set fileencodings=utf-8,cp1251,koi8-r,cp866

set timeout timeoutlen=250 ttimeoutlen=250
set t_Co=256

" Clipboard
if has('unnamedplus-that-really-truly-works')
    set clipboard=unnamedplus   " use X11 SYSTEM clipboard
else
    set clipboard=unnamed       " use X11 PRIMARY clipboard (selection)
endif

syntax sync minlines=256
set completeopt=menu
" Powerline
"set rtp+=/home/neg/.vim/bundle/powerline/powerline/bindings/vim
"syn sync minlines=1000
"probably it will increase lusty+gundo speed
let g:gundo_playback_delay = 240
set noshowmode
set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set nu                          " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
" set winminwidth=0             " Windows can be 0 line width
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
" set foldenable                  " Auto fold code
"map ; :
set autowrite           " write before a make
set clipboard-=autoselect clipboard+=autoselectml
" Windowing settings set splitright splitbelow
set equalalways                     " keep windows equal when splitting (default)
set eadirection=hor                 " ver/hor/both - where does equalalways apply
set winheight=6                     " height of current window
"set swapsync=""                    " don't call fsync() or sync(); let linux handle it
"set autowrite                      " Automatically write a file when leaving a modified buffer
set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore             " Allow for cursor beyond last character
set history=1000                    " Store a ton of history (default is 20)
" set spell                         " Spell checking on
set shiftwidth=4                    " Use indents of 4 spaces
set expandtab                       " Tabs are spaces, not tabs
set tabstop=4                       " An indentation every four columns
set softtabstop=4                   " Let backspace delete indent
set nojoinspaces                    " Prevents inserting two spaces after punctuation on a join (J)
set splitright                      " Puts new vsplit windows to the right of the current
set splitbelow                      " Puts new split windows to the bottom of the current
set matchpairs+=<:>                 " Match, to be used with %
"set matchpairs+==:;                " Match, to be used with %
"set matchpairs+=<:>                " Match, to be used with %
set pastetoggle=<F1>                " pastetoggle (sane indentation on pastes)
set autoindent                      " Indent at the same level of the previous line
set smartindent                     " does the right thing (mostly) in programs
set cindent                         " stricter rules for C programs
set laststatus=2                    " requied by PowerLine

set undofile                        " So is persistent undo ...
set undolevels=1000                 " Maximum number of changes that can be undone
set undoreload=10000                " Maximum number lines to save for undo on a buffer reload

" set list
" set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
" set listchars=tab:»·,trail:·    " how to display some special chars

" -----------------------------------------------------------------
" --[ change undo file location ]----------------------------------
" -----------------------------------------------------------------
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
" ---------------- Folds ----------------------------
set cpoptions=aAceFsBd
set foldmethod=indent               "fold based on indent
set foldnestmax=3                   "deepest fold is 3 levels
set nofoldenable                    "dont fold by default
" This makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" http://items.sjbach.com/319/configuring-vim-right
set hidden

set formatoptions+=t    " auto-wrap using textwidth (not comments)
set formatoptions+=c    " auto-wrap comments too
set formatoptions+=r    " continue the comment header automatically on <CR>
set formatoptions-=o    " don't insert comment leader with 'o' or 'O'
set formatoptions+=q    " allow formatting of comments with gq
"set formatoptions-=w   " double-carriage-return indicates paragraph
"set formatoptions-=a   " don't reformat automatically
set formatoptions+=n    " recognize numbered lists when autoindenting
set formatoptions+=2    " use second line of paragraph when autoindenting
set formatoptions-=v    " don't worry about vi compatiblity
set formatoptions-=b    " don't worry about vi compatiblity
set formatoptions+=l    " don't break long lines in insert mode
set formatoptions+=1    " don't break lines after one-letter words, if possible

"set-option -g default-terminal "screen-256color"
" set smartcase     " ignore case if search pattern is all lowercase,
                    " case-sensitive otherwise
"set cursorcolumn 
set cursorline 
set fillchars=vert:│
set maxfuncdepth=1000
set maxmemtot=200000
set bs=2 ai ruler lazyredraw ai cin autoread nocompatible
set ts=2 sts=2 sw=2 autochdir
"set ww=b,s,h,l,<,>,[,]  
" INDENTATION 
set shiftround
set diffopt=filler,iwhite     " ignore all whitespace and sync
"  -- [Backup options] --
set backup
set backupdir=~/trash
set directory=~/trash
set viminfo=%100,'100,/100,h,\"500,:100,n~/.viminfo
" make vim message not to annoy
set shortmess=aoOIT
"set shortmess=at      " shorten error messages
set modeline          " enable modelines
set grepprg=grep\ -nH\ $*
set background=dark
set sidescroll=5
set sidescrolloff=5
"@indents
set showcmd 
set noswapfile
set enc=utf-8

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

" No sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

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
" Fuck you, help key.
" indent_guides {
    if !exists('g:spf13_no_indent_guides_autocolor')
        let g:indent_guides_auto_colors = 1
    else
        " For some colorschemes, autocolor will not work (eg: 'desert', 'ir_black')
        autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#212121 ctermbg=3
        autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#404040 ctermbg=4
    endif
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

let g:airline_powerline_fonts = 0 " Use airline fonts
let g:airline#extensions#hunks#enabled = 1 let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#whitespace#checks = []

let g:airline_exclude_preview=1
let g:airline_symbols = {}
let g:airline_left_sep = ' '
let g:airline_left_alt_sep = ' '
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra.conf.py'
let g:ycm_extra_conf_globlist = ['~/dev/*','!~/*']
let g:ycm_confirm_extra_conf = 0

let g:ycm_filetype_blacklist = {
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'text' : 1,
      \ 'unite' : 1,
      \}
