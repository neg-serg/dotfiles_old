set shell=/bin/bash
if has('nvim')
    runtime! plugin/python_setup.vim
endif

if bufname('%') == ''
  set bufhidden=wipe
endif
if v:version >= 704
  " The new Vim regex engine is currently slooooow as hell which makes syntax
  " highlighting slow, which introduces typing latency.
  " Consider removing this in the future when the new regex engine becomes
  " faster.
  set regexpengine=1
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
    syntax sync minlines=256
    set ttyscroll=40
    set lazyredraw

    "set selection=exclusive           " exclusive selection is better [?]

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

    set guicursor=n-v-c:block-Cursor   " Full cursor for visual,command,normal
    set guicursor+=i:ver40-iCursor     " It set cursor width in insert mode
    set guicursor+=n-v-c:blinkon0      " Disable all blinking:
    set guicursor+=a:blinkon0          " Disable all blinking:

    set guioptions=                    " Disable all gui-oriented options in gvim

endif

if !has("gui_running")
    set runtimepath+=~/.vim/bundle/powerline/powerline/bindings/vim
    set t_Co=256 " I use 256-color terminals
    if &term == "rxvt-unicode-256color"
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

    set ttyscroll=256
    set ttymouse=urxvt                 " more accurate mouse tracking
    set ttyfast                        " more redrawing characters sent to terminal

    set synmaxcol=256                  " improve hi performance
    " set showmode                     " show what key had been pressed
    syntax sync minlines=256
    set lazyredraw                     " it's doesn't set by default for tmux

    if exists('$TMUX')
        let s:not_tmuxed_vim = system(expand("~/bin/scripts/not_tmuxed_wim"))
        if s:not_tmuxed_vim =~ "FALSE"
            " execute "set <xUp>=\e[1;*A"
            " execute "set <xDown>=\e[1;*B"
            " execute "set <xRight>=\e[1;*C"
            " execute "set <xLeft>=\e[1;*D"
            set t_ut=
            autocmd VimEnter * silent !echo -ne "\033Ptmux;\033\033]12;rgb:b0/d0/f0\007\033\\"
            let &t_SI="\033Ptmux;\033\033]12;rgb:32/4c/80\007\033\\"
            let &t_EI="\033Ptmux;\033\033]12;rgb:b0/d0/f0\007\033\\"
            autocmd VimEnter * silent !tmux set status off
            " set timeout  timeoutlen=1000
            " set ttimeout ttimeoutlen=100       " Usable for fast keybindings
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

command! -range=% Share silent <line1>,<line2>write !curl -s -F "sprunge=<-" http://sprunge.us | head -n 1 | tr -d '\r\n ' | DISPLAY=:0.0 xclip
command! -nargs=1 Indentation silent set ts=<args> shiftwidth=<args>
command! -nargs=1 IndentationLocal silent setlocal ts=<args> shiftwidth=<args>
"----------------------------------------------------------------------------
set keywordprg=:help
let $PATH = $PATH . ':' . expand("~/bin/go/bin")

set encoding=utf-8                          " Set default enc to utf-8
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

set scrolljump=5                " Lines to scroll when cursor leaves screen
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

set cursorline          " highlight current line
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
set nomodeline       " enable modelines
set grepprg=ag\ --nogroup\ --nocolor  "use ag over grep

set iminsert=0
set cmdheight=1

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
" "--------------------------------------------------------------------------------------------------------------
" " misc plugins settings
" "--------------------------------------------------------------------------------------------------------------
" https://github.com/airblade/vim-gitgutter/issues/106
let g:gitgutter_realtime = 0
let g:ConqueGdb_Leader          = '\\'       "<leader>, by default is painful
let g:EclimCompletionMethod     = 'omnifunc' "To provide ycm autocompletion
let g:livepreview_previewer = 'zathura'
let g:eregex_default_enable = 0
let g:mta_use_matchparen_group = 0
let g:lua_complete_omni = 1
let g:gasynctags_autostart = 0
let g:gundo_playback_delay = 240
" "--------------------------------------------------------------------------------------------------------------
" " plugin - nathanaelkane/vim-indent-guides.git
" " https://github.com/nathanaelkane/vim-indent-guides.git
" "--------------------------------------------------------------------------------------------------------------
if neobundle#tap('vim-indent-guides')
    let g:indent_guides_auto_colors = 1
    let g:indent_guides_start_level           = 2
    let g:indent_guides_guide_size            = 1
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_color_change_percent  = 7
endif
" "--------------------------------------------------------------------------------------------------------------
" " plugin - Yggdroot/indentLine.git
" " https://github.com/Yggdroot/indentLine.git
" "--------------------------------------------------------------------------------------------------------------
if neobundle#tap('indentLine')
    let g:indentLine_char = '│'
    let g:indentLine_faster = 1
endif
" "--------------------------------------------------------------------------------------------------------------
" " plugin - sjbach/lusty.git
" " https://github.com/sjbach/lusty.git
" "--------------------------------------------------------------------------------------------------------------
if neobundle#tap('lusty')
    let g:LustyJugglerDefaultMappings = 0
    let LustyExplorerDefaultMappings  = 0
endif
" "--------------------------------------------------------------------------------------------------------------
" " plugin - lyokha/vim-xkbswitch.git
" " https://github.com/lyokha/vim-xkbswitch.git
" "--------------------------------------------------------------------------------------------------------------
if neobundle#tap('vim-xkbswitch')
    let g:XkbSwitchEnabled = 1
    let g:XkbSwitchIMappings = ['ru']
    let g:XkbSwitchLib = '/usr/local/lib/libxkbswitch.so'
    let g:XkbSwitchSkipFt = [ 'nerdtree', 'tex' ]
endif
" "--------------------------------------------------------------------------------------------------------------
" " plugin - bling/vim-airline.git
" " https://github.com/bling/vim-airline.git
" "--------------------------------------------------------------------------------------------------------------
if neobundle#tap('vim-airline')
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#tab_nr_type = 1
    let g:airline#extensions#tabline#buffer_min_count = 1
    let g:airline#extensions#tabline#show_buffers = 0
    let g:airline_powerline_fonts = 1 " Use airline fonts
    let g:airline#extensions#hunks#enabled = 1
    let g:airline#extensions#branch#enabled = 1
    let g:airline#extensions#whitespace#checks = []

    let g:airline_exclude_preview  = 0
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
    \ 'i'  : 'INSERT',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }
endif
" "--------------------------------------------------------------------------------------------------------------
" " plugin - scrooloose/syntastic.git
" " https://github.com/scrooloose/syntastic.git
" "--------------------------------------------------------------------------------------------------------------
if neobundle#tap('syntastic')
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
endif
" "--------------------------------------------------------------------------------------------------------------
" " plugin - Valloric/YouCompleteMe.git
" " https://github.com/Valloric/YouCompleteMe.git
" "--------------------------------------------------------------------------------------------------------------
if neobundle#tap('YouCompleteMe')
    " let g:ycm_extra_conf_globlist = ['~/*','/mnt/home/*']
    " let g:ycm_extra_conf_globlist = []
    " let g:ycm_extra_conf_globlist = ['~/*','/mnt/home/*']
    " let g:ycm_extra_conf_globlist = ['~/dev/*', '~/kern/*', './']
    " let g:ycm_global_ycm_extra_conf = './.ycm_extra_conf.py'
    " let g:ycm_global_ycm_extra_conf = '~/dev/kern/linux/.ycm_extra.conf.py'
    let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
    let g:ycm_filepath_completion_use_working_dir = 0
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_cache_omnifunc = 1
    " let g:ycm_collect_identifiers_from_tags_files = 1
    "--[ syntastic enabling ]-----------------
    let g:ycm_show_diagnostics_ui          = 1 
    let g:ycm_seed_identifiers_with_syntax = 0
    let g:ycm_use_ultisnips_completer      = 0

    " let g:ycm_add_preview_to_completeopt = 1
    " let g:ycm_autoclose_preview_window_after_completion = 0
    " let g:ycm_autoclose_preview_window_after_insertion = 0 

    let g:ycm_semantic_triggers =  {
        \   'c' : ['->', '.'],
        \   'objc' : ['->', '.'],
        \   'cpp,objcpp' : ['->', '.', '::'],
        \   'perl' : ['->'],
        \   'php' : ['->', '::'],
        \   'cs,java,javascript,d,vim,python,ruby,perl6,scala,vb,elixir,go' : ['.'],
        \   'lua' : ['.', ':'],
        \   'erlang' : [':'],
        \   'ocaml' : ['.', '#'],
        \   'ruby' : ['.', '::'],
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
        \ 'infolog'    : 1,
        \ 'mail'       : 1
        \}
    let g:ycm_min_num_identifier_candidate_chars = 4
    let g:ycm_filetype_specific_completion_to_disable = {'javascript': 1}
    let g:ycm_goto_buffer_command = 'vertical-split'
endif
" "--------------------------------------------------------------------------------------------------------------
" " plugin - utl.vim
" " https://github.com/vim-scripts/utl.vim.git
" "--------------------------------------------------------------------------------------------------------------
if neobundle#tap('utl')
    let g:utl_cfg_hdl_scm_http_system = "silent !firefox %u &"
    let g:utl_cfg_hdl_mt_application_pdf = 'silent :!zathura %p &'
    let g:utl_cfg_hdl_mt_image_jpeg = 'silent :!sxiv %p &'
    let g:utl_cfg_hdl_mt_image_gif = 'silent :!sxiv %p &'
    let g:utl_cfg_hdl_mt_image_png = 'silent :!sxiv %p &'
endif
" "--------------------------------------------------------------------------------------------------------------
" " plugin - klen/python-mode.git
" " https://github.com/klen/python-mode.git
" "--------------------------------------------------------------------------------------------------------------
if neobundle#tap('python-mode')
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
endif
" "--------------------------------------------------------------------------------------------------------------
" " plugin - gregsexton/gitv.git
" " https://github.com/gregsexton/gitv.git
" "--------------------------------------------------------------------------------------------------------------
if neobundle#tap('gitv')
    let g:Gitv_OpenHorizontal = 'auto'
    let g:Gitv_OpenPreviewOnLaunch = 1
    let g:Gitv_WipeAllOnClose = 1
    let g:Gitv_DoNotMapCtrlKey = 1
    let g:Gitv_CommitStep = 1024
endif
" "--------------------------------------------------------------------------------------------------------------
" " plugin - Valloric/ListToggle.git
" " https://github.com/Valloric/ListToggle.git
" "--------------------------------------------------------------------------------------------------------------
if neobundle#tap('ListToggle')
    let g:lt_location_list_toggle_map = '<c-e>i'
    let g:lt_quickfix_list_toggle_map = '<c-e>u'
    let g:lt_height = 10
endif
" "--------------------------------------------------------------------------------------------------------------
" " plugin - mattn/zencoding-vim.git
" " https://github.com/mattn/zencoding-vim.git
" "--------------------------------------------------------------------------------------------------------------
if neobundle#tap('zencoding-vim')
    let g:user_zen_leader_key = '<c-b>'
    let g:user_zen_settings = {
        \  'indentation' : '  '
        \}
endif
" "--------------------------------------------------------------------------------------------------------------
" " plugin - Raimondi/delimitMate.git
" " https://github.com/Raimondi/delimitMate.git
" "--------------------------------------------------------------------------------------------------------------
if neobundle#tap('delimitMate')
    let g:delimitMate_expand_space = 1
    let g:delimitMate_expand_cr    = 0
    let g:delimitMate_smart_quotes = 1
    let g:delimitMate_balance_matchpairs = 1
endif
" "--------------------------------------------------------------------------------------------------------------
" " plugin - xolox/vim-easytags.git
" " https://github.com/xolox/vim-easytags.git
" "--------------------------------------------------------------------------------------------------------------
if neobundle#tap('vim-easytags')
    let g:easytags_updatetime_min = 9000
    let g:easytags_dynamic_files  = 1
    let g:easytags_events         = ['BufWritePost']
    let g:easytags_python_enabled = 1
    let g:easytags_auto_update    = 1
endif
" "--------------------------------------------------------------------------------------------------------------
" " plugin - benmills/vimux
" " https://github.com/benmills/vimux.git
" "--------------------------------------------------------------------------------------------------------------
if neobundle#tap('vimux')
    let g:VimuxUseNearestPane = 1
    " Vimux should split horizontally, but only if there isn't already a split
    " and only if there is room to split to the side and have two windows open.
    if (&columns > (&winwidth * 2) + (&winwidth * 0.25))
    let g:VimuxOrientation = "h"
    else
    let g:VimuxOrientation = "v"
    endif
    " The percent of the screen the split pane Vimux will spawn should take up.
    let g:VimuxHeight = "25"
    " Vimux should only open a pane when there isn't one already
    let g:VimuxUseNearestPane = 1
    " The keys sent to the runner pane before running a command. By default it sends
    " `q` to make sure the pane is not in scroll-mode and `C-u` to clear the line.
    let g:VimuxResetSequence = 'q C-l C-u'
endif
" "--------------------------------------------------------------------------------------------------------------
" " plugin - YankRing.vim
" " https://github.com/vim-scripts/YankRing.vim.git
" "--------------------------------------------------------------------------------------------------------------
" this is so that single char deletes don't end up in the yankring
if neobundle#tap('YankRing.vim')
    let g:yankring_history_dir = '/tmp'
    let g:yankring_history_file = 'yankring_hist'
    let g:yankring_min_element_length = 2
    let g:yankring_window_height = 14
endif
" "--------------------------------------------------------------------------------------------------------------
" " plugin - Shougo/unite.vim
" " https://github.com/Shougo/unite.vim.git
" "--------------------------------------------------------------------------------------------------------------
if neobundle#tap('unite.vim')
    function! s:unite_my_settings()
    nnoremap <silent><buffer> <C-o> :call unite#mappings#do_action('tabopen')<CR>
    nnoremap <silent><buffer> <C-v> :call unite#mappings#do_action('vsplit')<CR>
    nnoremap <silent><buffer> <C-s> :call unite#mappings#do_action('split')<CR>
    nnoremap <silent><buffer> <C-r> :call unite#mappings#do_action('rec')<CR>
    nnoremap <silent><buffer> <C-f> :call unite#mappings#do_action('preview')<CR>
    inoremap <silent><buffer> <C-o> <Esc>:call unite#mappings#do_action('tabopen')<CR>
    inoremap <silent><buffer> <C-v> <Esc>:call unite#mappings#do_action('vsplit')<CR>
    inoremap <silent><buffer> <C-s> <Esc>:call unite#mappings#do_action('split')<CR>
    inoremap <silent><buffer> <C-r> <Esc>:call unite#mappings#do_action('rec')<CR>
    inoremap <silent><buffer> <C-e> <Esc>:call unite#mappings#do_action('edit')<CR>
    inoremap <silent><buffer> <C-f> <C-o>:call unite#mappings#do_action('preview')<CR>
    " I hope to use <C-o> and return to the selected item after action...
    nmap <silent><buffer> jl <Plug>(unite_exit)
    imap <silent><buffer> jl <Plug>(unite_exit)
    imap <silent><buffer> <C-c> <Plug>(unite_exit)
    imap <silent><buffer> <C-j> <Plug>(unite_exit)
    imap <silent><buffer> <ESC> <NOP>
    nmap <silent><buffer> <C-j> <Plug>(unite_all_exit)
    inoremap <silent><buffer> <SPACE> _
    inoremap <silent><buffer> _ <SPACE>
    endfunction
    autocmd FileType unite call s:unite_my_settings()

    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    call unite#filters#sorter_default#use(['sorter_rank'])
    call unite#custom#source('file_mru,file_rec,file_rec/async,grep,locate',
                \ 'ignore_pattern', join(['\.git/', 'tmp/', 'bundle/'], '\|'))
    " call unite#custom#source( 'neomru/file', 'matchers', ['matcher_project_files', 'matcher_fuzzy'])
    call unite#custom#profile('neomru/file', 'filters', 'sorter_ftime')

    let g:unite_enable_ignore_case               = 1
    let g:unite_enable_smart_case                = 1
    let g:unite_enable_start_insert              = 1
    let g:unite_enable_split_vertically          = 0
    let g:unite_source_file_mru_limit            = 300
    let g:unite_source_file_mru_time_format      = '(%d-%m-%Y %H:%M:%S) '
    let g:unite_source_directory_mru_time_format = '(%d-%m-%Y %H:%M:%S) '
    let g:unite_source_mru_update_interval       = 300
    let g:unite_source_file_rec_min_cache_files  = 300
    let g:unite_source_file_rec_max_depth        = 10
    let g:unite_source_history_yank_enable       = 1
    let g:unite_source_bookmark_directory        = $HOME . "/.config/unite/bookmark"
    let g:unite_data_directory                   = $HOME.'/.config/unite'
    let g:junkfile#directory                     = expand($HOME."/.config/unite/junk")
    let g:unite_source_gtags_treelize            = 1
    let g:unite_source_history_yank_enable       = 1
    let g:unite_enable_short_source_mes          = 0
    let g:unite_force_overwrite_statusline       = 0
    let g:unite_prompt                           = '>> '
    let g:unite_marked_icon                      = '✓'
    let g:unite_update_time                      = 200
    let g:unite_split_rule                       = 'botright'
    let g:unite_source_buffer_time_format        = '(%d-%m-%Y %H:%M:%S) '
    let g:unite_winheight                        = 10
    let g:unite_candidate_icon                   = "▷"

    if executable('ag')
        let g:unite_source_grep_command               = 'ag'
        let g:unite_source_grep_default_opts =
            \ '--smart-case --line-numbers --nocolor --nogroup'
        let g:unite_source_grep_recursive_opt         = ''
        let g:unite_source_grep_search_word_highlight = 1
    elseif executable('ack')
        let g:unite_source_grep_command               = 'ack'
        let g:unite_source_grep_default_opts          = '--no-group --no-color'
        let g:unite_source_grep_recursive_opt         = ''
        let g:unite_source_grep_search_word_highlight = 1
    endif

    function! s:vimfiler_toggle()
        if &filetype == 'vimfiler'
            execute 'silent! buffer #'
            if &filetype == 'vimfiler'
                execute 'enew'
            endif
        elseif exists('t:vimfiler_buffer') && bufexists(t:vimfiler_buffer)
            execute 'buffer ' . t:vimfiler_buffer
        else
            execute 'VimFilerCreate'
            let t:vimfiler_buffer = @%
        endif
    endfunction
    function! s:vimfiler_settings()
        setlocal nobuflisted
        setlocal colorcolumn=
        nmap <buffer> q :call <SID>vimfiler_toggle()<CR>
        nmap <buffer> <ENTER> o
        nmap <buffer> <expr> o vimfiler#smart_cursor_map("\<Plug>(vimfiler_expand_tree)", "\<Plug>(vimfiler_edit_file)")
        nmap <buffer> <expr> C vimfiler#smart_cursor_map("\<Plug>(vimfiler_cd_file)", "")
        nmap <buffer> j <Plug>(vimfiler_loop_cursor_down)
        nmap <buffer> k <Plug>(vimfiler_loop_cursor_up)
        nmap <buffer> gg <Plug>(vimfiler_cursor_top)
        nmap <buffer> R <Plug>(vimfiler_redraw_screen)
        nmap <buffer> <SPACE> <Plug>(vimfiler_toggle_mark_current_line)
        nmap <buffer> U <Plug>(vimfiler_clear_mark_all_lines)
        nmap <buffer> cp <Plug>(vimfiler_copy_file)
        nmap <buffer> mv <Plug>(vimfiler_move_file)
        nmap <buffer> rm <Plug>(vimfiler_delete_file)
        nmap <buffer> mk <Plug>(vimfiler_make_directory)
        nmap <buffer> e <Plug>(vimfiler_new_file)
        nmap <buffer> u <Plug>(vimfiler_switch_to_parent_directory)
        nmap <buffer> . <Plug>(vimfiler_toggle_visible_ignore_files)
        nmap <buffer> I <Plug>(vimfiler_toggle_visible_ignore_files)
        nmap <buffer> yy <Plug>(vimfiler_yank_full_path)
        nmap <buffer> cd <Plug>(vimfiler_cd_vim_current_dir)
        vmap <buffer> <Space> <Plug>(vimfiler_toggle_mark_selected_lines)
    endfunction
    autocmd FileType vimfiler call s:vimfiler_settings()
    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_safe_mode_by_default = 0
    let g:vimfiler_tree_leaf_icon = ' '
    let g:vimfiler_tree_opened_icon = '▾'
    let g:vimfiler_tree_closed_icon = '▸'
    let g:vimfiler_enable_auto_cd = 1
    let g:vimfiler_no_default_key_mappings = 1
endif
" "--------------------------------------------------------------------------------------------------------------
" " plugin - luochen1990/rainbow
" " https://github.com/luochen1990/rainbow.git
" "--------------------------------------------------------------------------------------------------------------
if neobundle#tap('rainbow')
    let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
    let g:rainbow_conf = {
        \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
        \   'ctermfgs': ['darkgray', 'darkblue', 'darkmagenta', 'darkcyan'],
        \   'operators': '_,_',
        \   'parentheses': [['(',')'], ['\[','\]'], ['{','}']],
        \   'separately': {
        \       '*': {},
        \       'lisp': {
        \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
        \           'ctermfgs': ['darkgray', 'darkblue', 'darkmagenta', 'darkcyan', 'darkred', 'darkgreen'],
        \       },
        \       'vim': {
        \           'parentheses': [['(',')'], ['\[','\]'], ['{','}']],
        \       },
        \       'tex': {
        \           'parentheses': [['(',')'], ['\[','\]'], ['\\begin{.*}','\\end{.*}']],
        \       },
        \       'css': 0,
        \       'stylus': 0,
        \   }
        \}
endif
