if exists('$WINDIR') || !executable('zsh')
  set shell=bash
else
  set shell=zsh
endif
set t_Co=256                           " I use 256-color terminals
if v:version >= 704
  " The new Vim regex engine is currently slooooow as hell which makes syntax
  " highlighting slow, which introduces typing latency.
  " Consider removing this in the future when the new regex engine becomes
  " faster.
  set regexpengine=1
endif
" colorscheme solarized
" ------[ GUI settings ]-----------------------------------------------------
if has("gui_running")
    set gfn=PragmataPro\ for\ Powerline\ 14
    set guifontwide=PragmataPro\ for\ Powerline\ 14
    " set gfn=PragmataPro\ for\ Powerline\ 15
    " set lsp=-1
    set lsp=1                          " Space between lines
    set go=c                           " For text messages instead of gui
    set background=dark                " Usable for colorschemes
    set noantialias                    " Disable antialiasing
    set colorcolumn=0                  " Color eol limiter off
    set mousehide                      " hide the mouse pointer while typing
    set mousemodel=popup               " right mouse button pops up a menu in the GUI
   "  set mouse=a                         " enable full mouse support
    set mouse=                          " enable full mouse support
    set ttymouse=xterm2                " more accurate mouse tracking
    set ttyfast                        " more redrawing characters sent to terminal

    set synmaxcol=256                  " improve hi performance
    syntax sync minlines=256
    set ttyscroll=32
    set lazyredraw

   "  set selection=exclusive            " exclusive selection is better [?]

    set guicursor=n-v-c:block-Cursor   " Full cursor for visual,command,normal
    set guicursor+=i:ver40-iCursor     " It set cursor width in insert mode
    set guicursor+=n-v-c:blinkon0      " Disable all blinking:
    set guicursor+=a:blinkon0          " Disable all blinking:
    set previewheight=8                " Preview window should be minimal

    set winaltkeys=no                  "
    set wildcharm=<Tab>                " Want to be able to use <Tab> within our mappings
    
    set ballooneval                    " add popups for gui
    set balloondelay=400               " popups delay

    " Paste from PRIMARY and CLIPBOARD
    inoremap <silent> <M-v> <Esc>"+p`]a
    inoremap <silent> <S-Insert> <Esc>"*p`]a

    if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8') && version >= 700
      let &listchars = "tab:\u21e5\u00b7,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
      let &fillchars = "vert:\u259a,fold:\u00b7"
    else
      set listchars=tab:>\ ,trail:-,extends:>,precedes:<
    endif
    set guitablabel=%-0.12t%M

    let g:mirodark_enable_higher_contrast_mode=0
    colorscheme mirodark
    
endif

if !has("gui_running")
    " ENABLE CTRL INTERPRETING FOR VIM
    silent !stty -ixon > /dev/null 2>/dev/null

    set ttyscroll=1024
    set lazyredraw
    colorscheme miromiro

    set <M-1>=1
    set <M-2>=2
    set <M-3>=3
    set <M-4>=4
    set <M-5>=5
    set <M-6>=6
    set <M-7>=7
    set <M-8>=8
    set <M-9>=9
    set <M-0>=0
    set <M-a>=a
    set <M-b>=b
    set <M-c>=c
    set <M-d>=d
    set <M-e>=e
    set <M-f>=f
    set <M-g>=g
    set <M-h>=h
    set <M-i>=i
    set <M-j>=j
    set <M-k>=k
    set <M-l>=l
    set <M-m>=m
    set <M-n>=n
    set <M-o>=o
    set <M-p>=p
    set <M-q>=q
    set <M-r>=r
    set <M-s>=s
    set <M-t>=t
    set <M-u>=u
    set <M-v>=v
    set <M-w>=w
    set <M-x>=x
    set <M-y>=y
    set <M-z>=z
    set <M->=
    set <M-/>=/
    " Doing "set <M->>=^[>" throws up an error, so we be dodgey and use Char-190
    " instead, which is ASCII 62 ('>' + 128).
    set <Char-190>=>
    " Probably don't need both of these ;)
    set <Char-188>=<
    set <M-<>=<
    set <M-0>=0

    set <M-%>=%
    set <M-*>=*
    set <M-.>=.
    set <M-^>=^


   "  let g:solarized_termcolors=256
   "  let g:solarized_termtrans=1
   "  let g:solarized_contrast="high"
   "  let g:solarized_visibility="normal"
   "  colorscheme solarized
   "  source ~/.vim/colors/99-solarized.vim
endif

if has ('x') && has ('gui') " On Linux use + register for copy-paste
    set clipboard=unnamedplus
elseif has ('gui')          " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
endif
"----------------------------------------------------------------------------
set keywordprg=:help
" let $PATH = $PATH . ':' . expand("~/.cabal/bin")

set encoding=utf-8                          " Set default enc to utf-8
" set autowrite                             " Autowrite by default
set noautowrite                             " Don't autowrite by default
set noautochdir                             " Dont't change pwd automaticly
set showmode                                " show the mode ("-- INSERT --") at the bottom

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

if has('unnamedplus')
  " By default, Vim will not use the system clipboard when yanking/pasting to
  " the default register. This option makes Vim use the system default
  " clipboard.
  " Note that on X11, there are _two_ system clipboards: the "standard" one, and
  " the selection/mouse-middle-click one. Vim sees the standard one as register
  " '+' (and this option makes Vim use it by default) and the selection one as
  " '*'.
  " See :h 'clipboard' for details.
  set clipboard=unnamedplus,unnamed
else
  " Vim now also uses the selection system clipboard for default yank/paste.
  set clipboard+=unnamed
endif

" Unicode support (taken from http://vim.wikia.com/wiki/Working_with_Unicode)
" if has("multi_byte")
"   if &termencoding == ""
"     let &termencoding = &encoding
"   endif
"   set encoding=utf-8
"   setglobal fileencoding=utf-8
"   set fileencodings=ucs-bom,utf-8,latin1
" endif

" set completeopt=menu
set completeopt=menu,menuone,longest
set switchbuf=useopen,usetab
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
set matchtime=2                 " Default time to hi brackets too long for me

" allow backspace and cursor keys to cross line boundaries
set gdefault            " this makes search/replace global by default

" set nowrap                      " Do not wrap lines
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too

set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
" Windowing settings set splitright splitbelow
"set swapsync=""                " don't call fsync() or sync(); let linux handle it
" set autowrite                   " Automatically write a file when leaving a modified buffer
set virtualedit=onemore         " Allow for cursor beyond last character
set noswapfile                  " Disable swap to prevent ugly messages
set shortmess=a                 " Abbrev. of messages (avoids 'hit enter')
set nomore                      " ----------------------------------------
" set shortmess+=filmnrxoOtT      " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set history=1000                " Store a ton of history (default is 20)
" set spell                     " Spell checking on
set expandtab                   " Tabs are spaces, not tabs
set shiftwidth=4                " spaces for autoindents
set shiftround                  " makes indenting a multiple of shiftwidth
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

" options for formatting text; see :h formatoptions
set formatoptions=tcroqnj

" set formatoptions+=t    " auto-wrap using textwidth (not comments)
" set formatoptions+=c    " auto-wrap comments too
" set formatoptions+=r    " continue the comment header automatically on <CR>
" set formatoptions-=o    " don't insert comment leader with 'o' or 'O'
" set formatoptions+=q    " allow formatting of comments with gq
" " set formatoptions-=w   " double-carriage-return indicates paragraph
" " set formatoptions-=a   " don't reformat automatically
" set formatoptions+=n    " recognize numbered lists when autoindenting
" set formatoptions+=2    " use second line of paragraph when autoindenting
" set formatoptions-=v    " don't worry about vi compatiblity
" set formatoptions-=b    " don't worry about vi compatiblity
" set formatoptions+=l    " don't break long lines in insert mode
" set formatoptions+=1    " don't break lines after one-letter words, if possible

" this can cause problems with other filetypes
" see comment on this SO question http://stackoverflow.com/questions/234564/tab-key-4-spaces-and-auto-indent-after-curly-braces-in-vim/234578#234578
"set smartindent         " smart auto indenting
set autoindent          " on new lines, match indent of previous line
set copyindent          " copy the previous indentation on autoindenting
set cindent             " smart indenting for c-like code
set cino=b1,g0,N-s,t0,(0,W4  " see :h cinoptions-values
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
set grepprg=ag\ --nogroup\ --nocolor  "use ag over grep

set iminsert=0
set cmdheight=1

if has("cscope")
  set csprg=/usr/bin/gtags-cscope
  set csto=0
  set cscopetag
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

" this makes sure that shell scripts are highlighted
" as bash scripts and not sh scripts
let g:is_posix        = 1

"--[ Indent_guides ]--------------
let g:indent_guides_auto_colors = 1
" For some colorschemes, autocolor will not work (eg: 'desert', 'ir_black')
" autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#000936 ctermbg=3
" autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#000A40 ctermbg=4
let g:indent_guides_start_level           = 2
let g:indent_guides_guide_size            = 1
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent  = 7

let g:indentLine_char = '│'
let g:indentLine_faster = 1
"--[ Ctags ]----------------------
set tags=./tags;/;~/.vim/tags
" Make tags placed in .git/tags file available in all levels of a repository
let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
if gitroot != ''
    let &tags = &tags . ',' . gitroot . '/.git/tags'
endif

let g:gundo_playback_delay = 240

let mapleader      = ','
let maplocalleader = ' '
let g:mapleader    = ","

let g:session_autoload = "no"
let g:session_autosave = "yes"

let g:LustyJugglerDefaultMappings = 0
let LustyExplorerDefaultMappings  = 0
" -------------------------------------------------------------------
" When using the taglist plugin, don't attempt to resize the terminal
let Tlist_Inc_Winwidth = 0
let g:is_bash          = 1

let g:clj_highlight_builtins = 1

" let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd   = 'CtrlPMRUFiles'
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

if executable('ag')
  " Use ag in unite grep source.
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
        \ '--line-numbers --nocolor --nogroup --hidden --ignore ' .
        \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
elseif executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
endif

let g:haddock_browser = "dwb"

"--[ Vim-Airline ]----------------
let g:airline#extensions#tabline#enabled = 0
let g:airline_powerline_fonts = 1 " Use airline fonts
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#whitespace#checks = []

let g:airline_exclude_preview  = 1
let g:airline_symbols          = {}
let g:airline_left_sep         = ' '
let g:airline_left_alt_sep     = ' '
let g:airline_right_sep        = ''
let g:airline_right_alt_sep    = ''

let g:airline_symbols.branch   = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr   = ''
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
"--[ Syntastic ]------------------
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol  = '⚡'
let g:syntastic_style_warning_symbol  = '⚡'
let g:syntastic_python_pylint_exe = "pylint2"
let g:syntastic_mode_map = { 'mode': 'active',
            \ 'active_filetypes': [],
            \ 'passive_filetypes': ['python'] }

let g:syntastic_cpp_compiler_options = ' -std=c++11'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--select=F,C9 --max-complexity=10'

let g:syntastic_c_compiler_options = "-std=gnu11
                                  \  -Wall -Wextra -Wshadow -Wpointer-arith
                                  \  -Wcast-align -Wwrite-strings -Wmissing-prototypes
                                  \  -Wmissing-declarations -Wredundant-decls -Wnested-externs
                                  \  -Winline -Wno-long-long -Wuninitialized -Wconversion
                                  \  -Wstrict-prototypes -pedantic"
let g:syntastic_stl_format = '[=> ln:%F (%t)]'
let g:syntastic_aggregate_errors=1
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_always_populate_loc_list=1
let g:syntastic_c_no_include_search = 1
let g:syntastic_c_auto_refresh_includes = 1
let g:syntastic_c_check_header = 1
"--[ YouCompleteMe ]--------------
let g:ycm_extra_conf_globlist = []
" let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra.conf.py'

let g:ycm_confirm_extra_conf = 1
let g:ycm_show_diagnostics_ui = 1 " syntastic enabling
let g:ycm_seed_identifiers_with_syntax = 0
let g:ycm_use_ultisnips_completer = 0

let g:ycm_semantic_triggers =  {
    \   'c' : ['->', '.'],
    \   'objc' : ['->', '.'],
    \   'cpp,objcpp' : ['->', '.', '::'],
    \   'perl' : ['->'],
    \   'php' : ['->', '::'],
    \   'cs,java,javascript,d,vim,rubyythonerl6,scala,vb,elixir,go' : ['.'],
    \   'lua' : ['.', ':'],
    \   'erlang' : [':'],
    \ }

" let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_collect_identifiers_from_tags_files = 0

let g:ycm_filetype_blacklist = {
      \ 'notes'      : 1,
      \ 'markdown'   : 1,
      \ 'text'       : 1,
      \ 'unite'      : 1,
      \ 'conqueterm' : 1,
      \ 'asm'        : 1,
      \ 'tagbar'     : 1,
      \ 'qf'         : 1,
      \ 'vimwiki'    : 1,
      \ 'pandoc'     : 1,
      \ 'mail'       : 1
      \}

" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_add_preview_to_completeopt                = 1
let g:ycm_min_num_identifier_candidate_chars = 4
let g:ycm_filetype_specific_completion_to_disable = {'javascript': 1}
let g:ackprg = 'ag --nogroup --nocolor --column'
"--[ YankRing ]-------------------
" this is so that single char deletes don't end up in the yankring
let g:yankring_min_element_length = 2
let g:yankring_window_height = 14
let g:yankring_history_dir = '/tmp'
let g:yankring_history_file = 'yankring_hist'
"--[ Vimux ]----------------------
let g:VimuxUseNearestPane = 1
"--[ Utl exec ]-------------------
let g:utl_cfg_hdl_scm_http_system = "silent !firefox %u &"
let g:utl_cfg_hdl_mt_application_pdf = 'silent :!zathura %p &'
let g:utl_cfg_hdl_mt_image_jpeg = 'silent :!sxiv %p &'
let g:utl_cfg_hdl_mt_image_gif = 'silent :!sxiv %p &'
let g:utl_cfg_hdl_mt_image_png = 'silent :!sxiv %p &'
"--[ PythonMode ]-----------------
nmap <silent><Leader>n :PymodeLint<CR>

let g:pymode_breakpoint_bind = '<Leader>B'

let g:pymode_lint = 1
let g:pymode_lint_on_write = 0
let g:pymode_lint_checkers = ['pylint', 'pep8', 'mccabe', 'pep257']
let g:pymode_lint_ignore = ''
let g:pymode_virtualenv = 0
let g:pymode_rope = 1

let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 1
"--[ Gitv ]-----------------------
let g:Gitv_OpenHorizontal = 'auto'
let g:Gitv_OpenPreviewOnLaunch = 1
let g:Gitv_WipeAllOnClose = 1
let g:Gitv_DoNotMapCtrlKey = 1
let g:Gitv_CommitStep = 1024
"--[ Gitgutter ]------------------
" https://github.com/airblade/vim-gitgutter/issues/106
let g:gitgutter_realtime = 0
"--[ xkbSwitchWrapper ]-----------
let g:XkbSwitchEnabled = 1
let g:XkbSwitchIMappings = ['ru']
let g:XkbSwitchLib = '/usr/local/lib/libxkbswitch.so'
let g:XkbSwitchSkipFt = [ 'nerdtree', 'tex' ]
"--[ Conque gdb wrapper ]---------
let g:ConqueGdb_Leader          = '\'        "<leader>, by default is painful
"--[ Eclim ]----------------------
let g:EclimCompletionMethod     = 'omnifunc' "To provide ycm autocompletion
"--[ Gtags-cscope ]---------------
let GtagsCscope_Auto_Map        = 1
let GtagsCscope_Use_Old_Key_Map = 0
let GtagsCscope_Ignore_Case     = 1
let GtagsCscope_Absolute_Path   = 1
let GtagsCscope_Keep_Alive      = 1
let GtagsCscope_Auto_Load       = 0
"--[ Rainbow Parentheses ]--------
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
"--[ DelimitMate ]----------------
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr    = 0
let g:delimitMate_smart_quotes = 1
let g:delimitMate_balance_matchpairs = 1
"--[ LivePreview ]----------------
let g:livepreview_previewer = 'zathura'
"--[ ListToggle ]-----------------
let g:lt_location_list_toggle_map = '<c-e>i'
let g:lt_quickfix_list_toggle_map = '<c-e>u'
let g:lt_height = 10
"--[ Eregex ]---------------------
let g:eregex_default_enable = 0
"--[ MatchTagAlways ]-------------
let g:mta_use_matchparen_group = 0
"--[ Zencoding ]------------------
let g:user_zen_leader_key = '<c-b>'
let g:user_zen_settings = {
      \  'indentation' : '  '
      \}
