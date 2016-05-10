"--[ Main ]------------------------------------------------------------------------------
NeoBundle 'Valloric/YouCompleteMe' "best vim autocomplete engine for now
NeoBundle 'eugen0329/vim-esearch' "interactive search in vim
if !has("nvim")
    NeoBundle 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
endif
if !(&runtimepath =~ 'site-packages/powerline/bindings/vim')
    NeoBundle 'itchyny/lightline.vim.git' "lightline is more fancy than default
    NeoBundle 'nhooyr/neoman.vim' "better alternative to vimpager
endif
NeoBundle 'thinca/vim-quickrun' "run a bunch of text
NeoBundle 'junegunn/fzf'     "to work with fzf-vim
NeoBundle 'junegunn/fzf.vim' "use fzf plug for vim
NeoBundle 'luochen1990/rainbow'  "rainbow parentheses
NeoBundle 'mattboehm/vim-unstack' "stack trace parser
NeoBundle 'rdnetto/YCM-Generator' "generate config for ycm
NeoBundle 'chrisbra/colorizer'
    \, { 'autoload': { 'commands': ['ColorToggle'] } } "ascii to colors
"vimproc is for faster work of unite
NeoBundle 'Shougo/vimproc.vim', {
            \ 'build' : {
            \ 'windows' : 'make -f make_mingw32.mak',
            \ 'cygwin' : 'make -f make_cygwin.mak',
            \ 'mac' : 'make -f make_mac.mak',
            \ 'unix' : 'make -f make_unix.mak', } }
NeoBundle 'Shougo/neomru.vim.git' "mru for unite
NeoBundle 'vim-jp/vital.vim.git' "improve unite perf
NeoBundle 'Shougo/unite.vim.git' "unite for creating ui
NeoBundle 'mopp/autodirmake.vim.git' "automake dir which didnt exists
NeoBundle 'Shougo/vimfiler.vim', {
            \ 'depends' : 'Shougo/unite.vim', 'commands' : [
            \ { 'name' : 'VimFiler', 'complete' : 'customlist,vimfiler#complete' },
            \ { 'name' : 'VimFilerTab', 'complete' : 'customlist,vimfiler#complete' },
            \ { 'name' : 'VimFilerExplorer', 'complete' : 'customlist,vimfiler#complete' },
            \ { 'name' : 'Edit', 'complete' : 'customlist,vimfiler#complete' },
            \ { 'name' : 'Write', 'complete' : 'customlist,vimfiler#complete' },
            \ 'Read', 'Source'],
            \ 'mappings' : '<Plug>(vimfiler_', 'explorer' : 1, }
if !has("nvim")
    NeoBundle 'Shougo/vimshell.vim' "shell inside a vim for unite and vimfiler integration
endif
NeoBundleLazy 'Shougo/unite-outline', { 'unite_sources' : 'outline' }
NeoBundle 'junkblocker/unite-codesearch' "junkblocker google codesearch wrapper
NeoBundle 'Shougo/junkfile.vim.git' "junkfile for unite
NeoBundle 'rhysd/vim-clang-format.git' "format code by clang, better than astyle -A14
if !has("nvim")
    NeoBundle 'sjbach/lusty.git' "file/buffer explorer
else
    "temp disable because of segfault
    if has("ololo")
        NeoBundle 'https://bitbucket.org/mikehart/lycosaexplorer' "python lusty analog
    endif
endif
NeoBundle 'SirVer/ultisnips.git' "Snippets with ycm compatibility
NeoBundle 'godlygeek/tabular.git' "for tabularizing
if executable(resolve(expand("ack")))
    NeoBundle 'mileszs/ack.vim' "ack wrapper
endif
if executable(resolve(expand("ag")))
    NeoBundle 'rking/ag.vim.git' "ag (ack replacement) wrapper
endif
NeoBundleLazy 'tpope/vim-repeat', { 'mappings' : '.' } "dot for everything
NeoBundle 'tpope/vim-eunuch.git' "for SudoWrite, Locate, Find etc
NeoBundleLazy 'sjl/gundo.vim', { 'commands' : 'GundoToggle' }
NeoBundleLazy 'Raimondi/delimitMate', { 'insert' : 1 } "autopair ()[]{}
NeoBundleLazy 'scrooloose/syntastic', { 'insert' : 1 } "syntax checker
NeoBundle 'nathanaelkane/vim-indent-guides' "indent tabs visually with |-es too slow
NeoBundle 'thinca/vim-qfreplace.git' "visual replace for multiple files
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
endif
"----------------------------------------------------------------------------------------
if executable(resolve(expand("tmux")))
    NeoBundle 'tpope/vim-tbone.git' "tmux basics
    NeoBundle 'benmills/vimux.git' "exec commands in tmux
    NeoBundle 'christoomey/vim-tmux-navigator' "easy jump between windows
    NeoBundle 'epeli/slimux' "better interaction with tmux
endif
"--[ misc ]------------------------------------------------------------------------------
NeoBundleLazy 'chrisbra/unicode.vim', { 'commands' : ['UnicodeComplete','UnicodeGA', 'UnicodeTable'] } "better digraphs
NeoBundle 'Shougo/neossh.vim.git' "work with ssh easier
NeoBundle 'vim-scripts/ViewOutput.git' "VO commandline output
NeoBundle 'kana/vim-gf-user.git' "framework open file by context
NeoBundle 'kana/vim-gf-diff.git' "go to the changed block under the cursor from diff output
NeoBundle 'mattn/gf-user-vimfn.git' "vim-gf-user extension: jump Vim script function
NeoBundle 'mkomitee/vim-gf-python.git' "gf for python
if has("nvim")
    NeoBundle 'bfredl/nvim-ipy' "nvim client for jupiter
endif
" There is no need in fixkey for nvim because of it's default behaviour
if !has("nvim")
    NeoBundle 'drmikehenry/vim-fixkey' "fixes key codes for console Vim
endif
NeoBundle 'ReekenX/vim-rename2.git' "rename for files even with spaces in filename
NeoBundle 'thinca/vim-ref.git' "integrated reference viewer man/perldoc etc
NeoBundle 'othree/eregex.vim' "Perl-like extended regex for vim
NeoBundle 'chrisbra/Join.git' "Extended and fast Join for vim
NeoBundle 'lyokha/vim-xkbswitch.git' "Autoswitch on <esc> with libxkb needs xkb-switch-git to run
"is all about surroundings: parentheses, brackets, quotes, XML tags, and more
NeoBundleLazy 'tpope/vim-surround', { 'mappings' : [ ['n', 'cs', 'ds', 'ys', 'yS'], ['x', 'S']] }
NeoBundle 'kana/vim-arpeggio.git' "mappings for simultaneously pressed keys
NeoBundle 'jamessan/vim-gnupg.git' "Transparent work with gpg-encrypted files
NeoBundle 'Shougo/echodoc.vim' "prints doc in echo area
if executable(resolve(expand("task")))
    NeoBundle 'blindFS/vim-taskwarrior' "add taskwarrior vim plug wrapper
endif
NeoBundle 'kopischke/vim-fetch' "vim path/to/file.ext:12:3
NeoBundle 'FooSoft/vim-argwrap' "vim arg wrapper
NeoBundle 'junegunn/goyo.vim' "distraction free vim writing
NeoBundle 'justinmk/vim-gtfo' "to term of fm
NeoBundle 'mhinz/vim-rfc' "view and search rfc
"--[ dev ]-------------------------------------------------------------------------------
NeoBundleLazy 'majutsushi/tagbar', { 'commands' : 'TagbarToggle' }
NeoBundle 'chrisbra/vim-diff-enhanced.git' "patience diff
NeoBundle 'sombr/vim-scala-worksheet.git' "tiny Vim plugin that turns your file into interactive worksheet
NeoBundle 'neg-serg/ensime-vim' "scala vim autocompletion
NeoBundle 'derekwyatt/vim-scala' "various initial scala support for vim
NeoBundle 'derekwyatt/vim-sbt' "basic SBT support for vim
NeoBundle 'tpope/vim-commentary.git' "try it instead of tcomment
NeoBundle 'tpope/vim-endwise' "to insert endif for if, end for begin and so on
NeoBundle 'tpope/vim-unimpaired.git' "good mappings and toggles
NeoBundle 'dbakker/vim-projectroot' "better rooter
NeoBundle 'Valloric/ListToggle.git' "toggle quickfix and location list <leader>l by def
NeoBundle 'derekwyatt/vim-fswitch.git' "switching between companion source files (e.g. .h and .cpp)
NeoBundle 'vim-scripts/IndentConsistencyCop.git' "autochecks for indent
NeoBundle 'hynek/vim-python-pep8-indent.git' "python autoindent pep8 compatible
NeoBundle 'fs111/pydoc.vim' , {'autoload': {'filetypes': ['python']} } "pydoc integration
NeoBundle 'artur-shaik/vim-javacomplete2' "completion for java in vim
if has("nvim")
    NeoBundle 'jalvesaq/Nvim-R' "nvim R support
endif
if executable("mono")
    NeoBundleLazy 'nosami/Omnisharp.git', { 'filetypes' : 'cs' } "omnisharp completion
endif
if executable(resolve(expand("gotags")))
    NeoBundle 'jstemmer/gotags.git' "tags for go
endif
if executable(resolve(expand("go")))
    NeoBundle 'Blackrush/vim-gocode.git' "omnicomplete for go
    NeoBundle 'fatih/vim-go.git' "golang support
endif
if executable(resolve(expand("rustc")))
    NeoBundle 'rust-lang/rust.vim' "detection of rust files
    NeoBundle 'jtdowney/vimux-cargo' "rust-cargo bindings
endif
NeoBundleLazy 'vim-perl/vim-perl', { 'filetypes' : 'perl' }
NeoBundleLazy 'wannesm/wmgraphviz.vim', { 'filetypes' : 'dot' }
NeoBundle 'sbl/scvim.git' "vim plugin for supercollider
NeoBundle 'janko-m/vim-test.git' "easy testing for various langs
NeoBundle 'oscarh/vimerl' "vim erlang support
if has("nvim")
    NeoBundle 'baabelfish/nvim-nim' "nim support for vim and advanced support for neovim
endif
NeoBundle 'vhdirk/vim-cmake' "experimental cmake support
NeoBundle 'tpope/vim-dispatch.git' "provide async build via tmux
if executable(resolve(expand("rc")))
    NeoBundle 'lyuts/vim-rtags.git' "rtags plugin for vim
endif
if executable(resolve(expand("ghci")))
    NeoBundle 'ujihisa/neco-ghc' "autocomplete for hs using ghc-mod
    NeoBundle 'eagletmt/ghcmod-vim.git'
    NeoBundle 'bitc/vim-hdevtools' "type-related features
    NeoBundle 'neg-serg/vim2hs' "better haskell syntax hi with better indenting
endif
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
NeoBundle 'shawncplus/phpcomplete.vim.git' "better than default phpcomplete.vim
" Multi-language DBGP debugger client for Vim (PHP, Python, Perl, Ruby, etc.)
NeoBundleLazy 'joonty/vdebug', { 'autoload': { 'commands': 'VdebugStart' }}
NeoBundle 'guns/vim-clojure-static' "better clojure support
NeoBundle 'guns/vim-sexp' "manipulate with s-expressions
" html5 autocomplete and syntax
NeoBundleLazy 'othree/html5.vim' , {'autoload': {'filetypes': ['html', 'htmldjango']} }
"----------------[  Tags  ]--------------------------------------------------------------
NeoBundle 'szw/vim-tags' "autogen ctags
if executable(resolve(expand("gtags")))
    NeoBundle 'yuki777/gtags.vim.git' "Gtags v0.64
    NeoBundle 'bbchung/gasynctags.git' "autogenerate gtags to cscope db
    NeoBundle 'tranngocthachs/gtags-cscope-vim-plugin.git' "gtags-cscope navigation
endif
"--[ latex ]-----------------------------------------------------------------------------
NeoBundle 'lervag/vimtex' "LaTeX-Box replacement
"--[ web ]-------------------------------------------------------------------------------
NeoBundle 'rstacruz/sparkup.git' "write html code faster
NeoBundle 'Valloric/vim-instant-markdown' "realtime markdown preview
NeoBundleLazy 'marijnh/tern_for_vim', { 'autoload': { 'filetypes': ['javascript'] } }
"---------------[ syntax ]---------------------------------------------------------------
NeoBundle 'vimez/vim-tmux' "syntax hi for tmux
NeoBundle 'elzr/vim-json' "syntax hi for json format
NeoBundle 'cespare/vim-toml' "syntax hi for toml format
NeoBundle 'rsmenon/vim-mathematica.git' "Mathematica syntax and omnicomp
NeoBundle 'jelera/vim-javascript-syntax.git' "js highlighting
NeoBundle 'tpope/vim-git' "syntax, indent, and filetype plugin files for git
NeoBundle 'ekalinin/Dockerfile.vim' "dockerfile hi
NeoBundle 'jnwhiteh/vim-golang.git' "golang syntax highlight
NeoBundleLazy 'blindFS/vim-regionsyntax', { 'filetypes' : ['vimwiki', 'markdown', 'tex', 'html'] }
NeoBundle 'JulesWang/css.vim' "better css syntax hi
NeoBundle 'leafo/moonscript-vim' "basic moonscript support
NeoBundle 'rodjek/vim-puppet' "basic puppet support
NeoBundle 'fatih/vim-nginx' "nginx runtime files
NeoBundle 'trapd00r/irc.vim' "syntax file for irc logs
NeoBundle 'zah/nim.vim' "syntax file for nim
NeoBundle 'junegunn/vim-journal' "pretty markdown-like look
if !has("nvim") && has("ololo")
    NeoBundle 'bbchung/clighter.git' "hi with clang
elseif has("nvim")
    NeoBundle 'bbchung/Clamp' "clighterr for neovim
endif
if has("gui_running")
    NeoBundle 'drmikehenry/vim-fontsize.git' "set fontsize on the fly
    NeoBundle 'tyru/restart.vim.git' "add restart support
    NeoBundle 'vim-scripts/utl.vim.git' "Open urls in files
    NeoBundle 'bling/vim-airline.git' "statusline for gvim only
endif
if has("nvim")
    NeoBundle 'whatyouhide/vim-gotham' "gotham colorscheme for nvim
endif
NeoBundle 'ryanoasis/vim-devicons.git' "fancy icons for fonts
if has("google_plugs")
    NeoBundle 'google/vim-maktaba' "vim plugin library
    NeoBundle 'google/vim-coverage' "test coverage visualize, require vim-maktaba
    NeoBundle 'google/vim-glaive' "configuring for maktaba plugins
endif
