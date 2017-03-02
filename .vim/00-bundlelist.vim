"--[ Main ]------------------------------------------------------------------------------
NeoBundle 'Valloric/YouCompleteMe' "best vim autocomplete engine for now
NeoBundle 'metakirby5/codi.vim' "nice repl for vim8
if !has("nvim")
    NeoBundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
endif
if !(&runtimepath =~ 'site-packages/powerline/bindings/vim') || has("nvim")
    NeoBundle 'itchyny/lightline.vim.git' "lightline is more fancy than default
    NeoBundle 'nhooyr/neoman.vim' "better alternative to vimpager
endif
NeoBundle 'thinca/vim-quickrun' "run a bunch of text
if has("nvim")
    NeoBundle 'Shougo/denite.nvim' "newer replacement for unite
endif
NeoBundle 'Shougo/neomru.vim' "add neomru source
NeoBundle 'junegunn/vim-pseudocl'
"--[ Additions ]--------------------------------------------------------------------------
NeoBundle 'kopischke/vim-fetch' "vim path/to/file.ext:12:3
NeoBundle 'FooSoft/vim-argwrap' "vim arg wrapper
"is all about surroundings: parentheses, brackets, quotes, XML tags, and more
NeoBundle 'Valloric/ListToggle.git' "toggle quickfix and location list <leader>l by def
NeoBundle 'tpope/vim-projectionist' "better alternate files switcher and more
NeoBundle 'othree/eregex.vim' "Perl-like extended regex for vim
NeoBundle 'lyokha/vim-xkbswitch.git' "Autoswitch on <esc> with libxkb needs xkb-switch-git to run
NeoBundle 'kana/vim-arpeggio.git' "mappings for simultaneously pressed keys
NeoBundle 'tyru/open-browser.vim' "open browser with gx
NeoBundle 'tyru/open-browser-github.vim' "open links in vim
NeoBundle 'rhysd/vim-grammarous' "powerful vim spell-checking with LangTool
"--[ Search ]-----------------------------------------------------------------------------
if executable(resolve(expand("ack")))
    NeoBundle 'mileszs/ack.vim' "ack wrapper
endif
if executable(resolve(expand("ag")))
    NeoBundle 'rking/ag.vim.git' "ag (ack replacement) wrapper
endif
if has("fzf_use") 
    NeoBundle 'junegunn/fzf' "fast fuzzy finder
    NeoBundle 'junegunn/fzf.vim' "fzf vim bindings
else
    NeoBundle 'lotabout/skim.vim' "replacement for fzf
endif
NeoBundle 'eugen0329/vim-esearch' "interactive search in vim
NeoBundle 'sjbach/lusty.git' "file/buffer explorer
"--[ Rice ]-------------------------------------------------------------------------------
NeoBundle 'luochen1990/rainbow'  "rainbow parentheses
NeoBundleLazy 'chrisbra/colorizer' "css and colors colorizer
NeoBundleLazy 'chrisbra/unicode.vim', { 'commands' : ['UnicodeComplete','UnicodeGA', 'UnicodeTable'] } "better digraphs
NeoBundleLazy 'sunaku/vim-hicterm' "highlight colors in terminal
NeoBundle 'nathanaelkane/vim-indent-guides' "indent tabs visually with |-es too slow
NeoBundle 'thinca/vim-qfreplace.git' "visual replace for multiple files
"--[ Edit ]-------------------------------------------------------------------------------
NeoBundle 'rhysd/vim-clang-format.git' "format code by clang, better than astyle -A14
NeoBundle 'SirVer/ultisnips.git' "Snippets with ycm compatibility
NeoBundle 'godlygeek/tabular.git' "for tabularizing
NeoBundleLazy 'tpope/vim-repeat', { 'mappings' : '.' } "dot for everything
NeoBundleLazy 'sjl/gundo.vim', { 'commands' : 'GundoToggle' }
NeoBundleLazy 'Raimondi/delimitMate', { 'insert' : 1 } "autopair ()[]{}
NeoBundle 'chrisbra/Join.git' "Extended and fast Join for vim
NeoBundleLazy 'tpope/vim-surround', { 'mappings' : [ ['n', 'cs', 'ds', 'ys', 'yS'], ['x', 'S']] }
NeoBundle 'tpope/vim-unimpaired.git' "good mappings and toggles
"-----------------------------------------------------------------------------------------
NeoBundle 'mattboehm/vim-unstack' "stack trace parser
"generate config for ycm
NeoBundle 'rdnetto/YCM-Generator'
    \, { 'autoload': { 'commands': ['ColorToggle'] } } "ascii to colors
NeoBundle 'mopp/autodirmake.vim.git' "automake dir which didnt exists
NeoBundle 'tpope/vim-eunuch.git' "for SudoWrite, Locate, Find etc
NeoBundle 'tpope/vim-abolish' "for different case coersion
NeoBundleLazy 'scrooloose/syntastic', { 'insert' : 1 } "syntax checker
if has("ololo")
    NeoBundle 'https://github.com/w0rp/ale' "async syntastic
endif
NeoBundle 'c9s/vimomni.vim' "autocompletion for VimL
"--[ dcvs ]------------------------------------------------------------------------------
if executable(resolve(expand("git")))
    NeoBundle 'tpope/vim-fugitive.git' "Git stuff. Needed for powerline etc
    NeoBundle 'junegunn/vim-github-dashboard.git' "Git dashboard in vim
    NeoBundle 'jaxbot/github-issues.vim.git' "github issues autocomp
    NeoBundle 'idanarye/vim-merginal.git' "to handle branches/merge conflicts
    NeoBundle 'junegunn/gv.vim' "yet another git commit browser
    NeoBundle 'vim-scripts/DirDiff.vim.git' "diff directories easyer with vim
    NeoBundle 'airblade/vim-gitgutter.git' "last changes
    NeoBundle 'jreybert/vimagit' "vimagit like magit from emacs inter. mode
endif
"----------------------------------------------------------------------------------------
if executable(resolve(expand("tmux")))
    NeoBundle 'tpope/vim-tbone.git' "tmux basics
    NeoBundle 'benmills/vimux.git' "exec commands in tmux
    NeoBundle 'christoomey/vim-tmux-navigator' "easy jump between windows
    NeoBundle 'epeli/slimux' "better interaction with tmux
    NeoBundle 'wincent/terminus' "better tmux support(focuslist for example)
endif
"--[ Misc ]------------------------------------------------------------------------------
NeoBundle 'mjbrownie/swapit' "vim nice swapit
NeoBundle 's3rvac/AutoFenc' " try to autodelect filetype
NeoBundle 'sheerun/vim-polyglot' "language pack collection
NeoBundle 'wellle/targets.vim' "better text objects
NeoBundle 'vim-scripts/Improved-AnsiEsc' "text to esc-seqs in vim
NeoBundle 'Konfekt/FastFold' "Do not update folds when it's not needed
NeoBundle 'Shougo/neossh.vim.git' "work with ssh easier
NeoBundle 'vim-scripts/ViewOutput.git' "VO commandline output
NeoBundle 'kana/vim-gf-user.git' "framework open file by context
NeoBundle 'kana/vim-gf-diff.git' "go to the changed block under the cursor from diff output
NeoBundle 'mattn/gf-user-vimfn.git' "vim-gf-user extension: jump Vim script function
NeoBundle 'ardagnir/vimbed' "embeded vim for athame
NeoBundle 'wikitopian/hardmode' "funny vim hardmode plugin
if has("nvim")
    NeoBundle 'bfredl/nvim-ipy' "nvim client for jupiter
endif
" There is no need in fixkey for nvim because of it's default behaviour
if !has("nvim")
    NeoBundle 'drmikehenry/vim-fixkey' "fixes key codes for console Vim
endif
NeoBundle 'jamessan/vim-gnupg.git' "Transparent work with gpg-encrypted files
if executable(resolve(expand("task")))
    NeoBundle 'blindFS/vim-taskwarrior' "add taskwarrior vim plug wrapper
endif
NeoBundle 'junegunn/goyo.vim' "distraction free vim writing
NeoBundle 'justinmk/vim-gtfo' "to term of fm
NeoBundle 'ReekenX/vim-rename2.git' "rename for files even with spaces in filename
"--[ Docs ]------------------------------------------------------------------------------
NeoBundle 'mhinz/vim-rfc' "view and search rfc
NeoBundle 'Shougo/echodoc.vim' "prints doc in echo area
NeoBundle 'thinca/vim-ref.git' "integrated reference viewer man/perldoc etc
NeoBundle 'sunaku/vim-dasht' "dasht integration
"--[ Dev ]-------------------------------------------------------------------------------
NeoBundleLazy 'majutsushi/tagbar', { 'commands' : 'TagbarToggle' }
NeoBundle 'chrisbra/vim-diff-enhanced.git' "patience diff
NeoBundle 'vhdirk/vim-cmake' "experimental cmake support
NeoBundle 'tpope/vim-dispatch.git' "provide async build via tmux
if executable(resolve(expand("rc")))
    NeoBundle 'lyuts/vim-rtags.git' "rtags plugin for vim
endif
NeoBundle 'tpope/vim-commentary.git' "try it instead of tcomment
NeoBundle 'tpope/vim-endwise' "to insert endif for if, end for begin and so on
NeoBundle 'dbakker/vim-projectroot' "better rooter
NeoBundle 'derekwyatt/vim-fswitch.git' "switching between companion source files (e.g. .h and .cpp)
NeoBundle 'janko-m/vim-test.git' "easy testing for various langs
NeoBundle 'mh21/errormarker.vim' "mark strings with errors
"--[ Scala ]-----------------------------------------------------------------------------
if !has("nvim") && has("ololo")
" [ Delete Scala support for now ]
    NeoBundle 'ensime/ensime-vim' "scala vim autocompletion
    NeoBundle 'derekwyatt/vim-scala' "various initial scala support for vim
    NeoBundle 'derekwyatt/vim-sbt' "basic SBT support for vim
endif
"--[ Python ]-----------------------------------------------------------------------------
NeoBundle 'vim-scripts/IndentConsistencyCop.git' "autochecks for indent
NeoBundle 'hynek/vim-python-pep8-indent.git' "python autoindent pep8 compatible
NeoBundle 'fs111/pydoc.vim' , {'autoload': {'filetypes': ['python']} } "pydoc integration
NeoBundle 'mkomitee/vim-gf-python.git' "gf for python
" NeoBundle 'python-rope/ropevim' "python refactoring
"--[ R ]----------------------------------------------------------------------------------
if has("nvim")
    NeoBundle 'jalvesaq/Nvim-R' "nvim R support
endif
"--[ Mono ]-------------------------------------------------------------------------------
if executable("mono")
    NeoBundleLazy 'nosami/Omnisharp.git', { 'filetypes' : 'cs' } "omnisharp completion
endif
"--[ Go ]---------------------------------------------------------------------------------
if executable(resolve(expand("gotags")))
    NeoBundle 'jstemmer/gotags.git' "tags for go
endif
if executable(resolve(expand("go")))
    NeoBundle 'Blackrush/vim-gocode.git' "omnicomplete for go
    NeoBundle 'fatih/vim-go.git' "golang support
endif
NeoBundle 'jnwhiteh/vim-golang.git' "golang syntax highlight
"--[ Rust ]-------------------------------------------------------------------------------
if executable(resolve(expand("rustc")))
    NeoBundle 'rust-lang/rust.vim' "detection of rust files
    NeoBundle 'jtdowney/vimux-cargo' "rust-cargo bindings
endif
"--[ Nim ]---------------------------------------------------------------------------------
if has("nvim")
    NeoBundle 'baabelfish/nvim-nim' "nim support for vim and advanced support for neovim
endif
"--[ Haskell ]-----------------------------------------------------------------------------
if executable(resolve(expand("ghci")))
    NeoBundle 'ujihisa/neco-ghc' "autocomplete for hs using ghc-mod
    NeoBundle 'eagletmt/ghcmod-vim.git'
    NeoBundle 'bitc/vim-hdevtools' "type-related features
    NeoBundle 'neg-serg/vim2hs' "better haskell syntax hi with better indenting
endif
"--[ Ruby ]--------------------------------------------------------------------------------
if has("ruby")
    if executable(resolve(expand("ruby")))
        if has("nvim")
            NeoBundle 'osyo-manga/vim-monster' "alternative ruby autocompletion
        else
            NeoBundle 'vim-ruby/vim-ruby' "ruby autocompletion
        endif
        NeoBundle 'tpope/vim-rails.git' "rails plugin from Tim Pope
        NeoBundle 'tpope/vim-rake.git' "ruby rake support
        NeoBundle 'tpope/vim-rbenv.git' "ruby rbenv support
        NeoBundle 'tpope/vim-bundler' "ruby bundler support
        NeoBundle 'vim-scripts/dbext.vim' "provides database access to many dbms
        NeoBundle 'skalnik/vim-vroom' "plugin to run ruby tests
    endif
endif
"--[ Lisp-like ]---------------------------------------------------------------------------
NeoBundle 'guns/vim-clojure-static' "better clojure support
if has("ololo")
    NeoBundleLazy 'guns/vim-sexp' "manipulate with s-expressions
endif
"--[ Misc Langs ]--------------------------------------------------------------------------
NeoBundle 'shawncplus/phpcomplete.vim.git' "better than default phpcomplete.vim
" Multi-language DBGP debugger client for Vim (PHP, Python, Perl, Ruby, etc.)
NeoBundleLazy 'joonty/vdebug', { 'autoload': { 'commands': 'VdebugStart' }}
" html5 autocomplete and syntax
NeoBundleLazy 'othree/html5.vim' , {'autoload': {'filetypes': ['html', 'htmldjango']} }
NeoBundle 'mattn/emmet-vim' "expanding abbreviations similar to emmet
NeoBundleLazy 'vim-perl/vim-perl', { 'filetypes' : 'perl' }
NeoBundleLazy 'wannesm/wmgraphviz.vim', { 'filetypes' : 'dot' }
NeoBundleLazy 'sbl/scvim.git', { 'filetypes' : 'sc' } "vim plugin for supercollider
NeoBundleLazy 'oscarh/vimerl', { 'filetypes' : 'erl' } "vim erlang support
NeoBundleLazy 'kballard/vim-swift', { 'filetypes' : 'swift' } "tiny swift support
"----------------[  DBMS  ]--------------------------------------------------------------
" NeoBundle 'talek/vorax4' "Oracle DB IDE
"----------------[  Tags  ]--------------------------------------------------------------
NeoBundle 'szw/vim-tags' "autogen ctags
if executable(resolve(expand("gtags")))
    NeoBundle 'yuki777/gtags.vim.git' "Gtags v0.64
    NeoBundle 'bbchung/gasynctags.git' "autogenerate gtags to cscope db
    NeoBundle 'tranngocthachs/gtags-cscope-vim-plugin.git' "gtags-cscope navigation
endif
"--[ LaTeX ]-----------------------------------------------------------------------------
NeoBundleLazy 'lervag/vimtex', { 'filetypes' : ['tex'] } "LaTeX-Box replacement
NeoBundleLazy 'xuhdev/vim-latex-live-preview', { 'filetypes' : ['tex'] } "add latex live preview
"--[ Web ]-------------------------------------------------------------------------------
NeoBundleLazy 'rstacruz/sparkup.git', { 'filetypes' : ['html'] } "write html code faster
NeoBundleLazy 'Valloric/vim-instant-markdown', { 'filetypes' : ['markdown'] } "realtime markdown preview
NeoBundleLazy 'marijnh/tern_for_vim', { 'autoload': { 'filetypes': ['javascript'] } }
"---------------[ Misc syntax ]----------------------------------------------------------
NeoBundleLazy 'vimez/vim-tmux', { 'filetypes' : ['tmux'] } "syntax hi for tmux
NeoBundleLazy 'elzr/vim-json', { 'filetypes' : ['json'] } "syntax hi for json format
NeoBundleLazy 'cespare/vim-toml', { 'filetypes' : ['toml'] } "syntax hi for toml format
NeoBundleLazy 'rsmenon/vim-mathematica.git', { 'filetypes' : ['mathematica'] } "Mathematica syntax and omnicomp
NeoBundleLazy 'jelera/vim-javascript-syntax.git', { 'filetypes' : ['javascript'] } "js highlighting
NeoBundle 'tpope/vim-git' "syntax, indent, and filetype plugin files for git
NeoBundle 'ekalinin/Dockerfile.vim' "dockerfile hi
NeoBundleLazy 'blindFS/vim-regionsyntax', { 'filetypes' : ['vimwiki', 'markdown', 'tex', 'html'] }
NeoBundleLazy 'JulesWang/css.vim', { 'filetypes' : ['css'] } "better css syntax hi
NeoBundleLazy 'leafo/moonscript-vim', { 'filetypes' : ['moonscript'] } "basic moonscript support
NeoBundleLazy 'rodjek/vim-puppet', { 'filetypes' : ['puppet'] } "basic puppet support
NeoBundle 'fatih/vim-nginx' "nginx runtime files
NeoBundle 'trapd00r/irc.vim' "syntax file for irc logs
NeoBundleLazy 'zah/nim.vim', { 'filetypes' : ['nim'] } "syntax file for nim
NeoBundle 'junegunn/vim-journal' "pretty markdown-like look
NeoBundle 'baskerville/vim-sxhkdrc' "sxhkd config syntax
NeoBundleLazy 'peterhoeg/vim-qml', { 'filetypes' : ['qml'] } "qml syntax file
" NeoBundle 'bbchung/clighter8' "10x faster clighter highlighter replacement
if has("gui_running")
    NeoBundle 'drmikehenry/vim-fontsize.git' "set fontsize on the fly
    NeoBundle 'tyru/restart.vim.git' "add restart support
    NeoBundle 'vim-scripts/utl.vim.git' "Open urls in files
    NeoBundle 'bling/vim-airline.git' "statusline for gvim only
endif
if has("nvim")
    NeoBundle 'whatyouhide/vim-gotham' "gotham colorscheme for nvim
endif
NeoBundle 'aperezdc/vim-elrond' "new colorscheme
NeoBundle 'joshdick/onedark.vim' "nice atom-like colorscheme
NeoBundle 'chriskempson/base16-vim' "base16 colorschemes pack
NeoBundle 'cstrahan/vim-capnp' "capnproto syntax highlighting
NeoBundle 'ryanoasis/vim-devicons.git' "fancy icons for fonts
if has("google_plugs")
    NeoBundle 'google/vim-maktaba' "vim plugin library
    NeoBundle 'google/vim-coverage' "test coverage visualize, require vim-maktaba
    NeoBundle 'google/vim-glaive' "configuring for maktaba plugins
    NeoBundle 'google/vim-codefmt' "clang-based codeformatter
endif
NeoBundle 'PotatoesMaster/i3-vim-syntax' "i3 syntax
