"--[ Main ]------------------------------------------------------------------------------
NeoBundle 'Valloric/YouCompleteMe'
" python powerline autodetection
if !(&runtimepath =~ 'site-packages/powerline/bindings/vim')
    NeoBundle 'itchyny/lightline.vim.git' "lightline is more fancy than default
endif
NeoBundle 'junegunn/fzf'
NeoBundle 'junegunn/fzf.vim' "use fzf plug for vim
NeoBundle 'xolox/vim-misc.git' "helpers for lua-mode
NeoBundle 'chrisbra/colorizer'
    \, { 'autoload': { 'commands': ['ColorToggle'] } } "ascii to colors
NeoBundle 'luochen1990/rainbow.git' "improved rainbow-parentesis
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
NeoBundle 'Shougo/vimshell.vim' "shell inside a vim for unite and vimfiler integration
NeoBundleLazy 'Shougo/unite-outline', { 'unite_sources' : 'outline' }
NeoBundle 'junkblocker/unite-codesearch' "junkblocker google codesearch wrapper
NeoBundle 'Shougo/junkfile.vim.git' "junkfile for unite
NeoBundle 'rhysd/vim-clang-format.git' "format code by clang, better than astyle -A14
NeoBundle 'sjbach/lusty.git' "file/buffer explorer
NeoBundle 'SirVer/ultisnips.git' "Snippets with ycm compatibility
NeoBundle 'godlygeek/tabular.git' "for tabularizing
if executable("ack")
    NeoBundle 'mileszs/ack.vim' "ack wrapper
endif
if executable("ag")
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
if executable("git")
    NeoBundle 'tpope/vim-fugitive.git' "Git stuff. Needed for powerline etc
    NeoBundle 'kablamo/vim-git-log.git' "Git commit browser/log wrapper
    NeoBundle 'junegunn/vim-github-dashboard.git' "Git dashboard in vim
    NeoBundle 'jaxbot/github-issues.vim.git' "github issues autocomp
    NeoBundle 'idanarye/vim-merginal.git' "to handle branches/merge conflicts
    NeoBundle 'cohama/agit.vim.git' "git commit browser
    NeoBundle 'vim-scripts/DirDiff.vim.git' "diff directories easyer with vim
    NeoBundle 'airblade/vim-gitgutter.git' "last changes
endif
"----------------------------------------------------------------------------------------
if executable("tmux")
    NeoBundle 'tpope/vim-tbone.git' "tmux basics
    NeoBundle 'benmills/vimux.git' "exec commands in tmux
    NeoBundle 'christoomey/vim-tmux-navigator' "easy jump between windows
endif
"--[ misc ]------------------------------------------------------------------------------
" NeoBundle 'amix/open_file_under_cursor.vim.git' "better gf
NeoBundle 'Shougo/neossh.vim.git' "work with ssh easier
NeoBundle 'junegunn/vim-peekaboo.git' "visual quote(paste) operator
NeoBundle 'manicmaniac/betterga.git' "better ga
NeoBundle 'vim-scripts/ViewOutput.git' "VO commandline output
NeoBundle 'kana/vim-gf-user.git' "framework open file by context
NeoBundle 'kana/vim-gf-diff.git' "go to the changed block under the cursor from diff output
NeoBundle 'mattn/gf-user-vimfn.git' "vim-gf-user extension: jump Vim script function
NeoBundle 'mkomitee/vim-gf-python.git' "gf for python
NeoBundle 'drmikehenry/vim-fixkey' "fixes key codes for console Vim
NeoBundle 'ReekenX/vim-rename2.git' "rename for files even with spaces in filename
NeoBundle 'thinca/vim-ref.git' "integrated reference viewer man/perldoc etc
NeoBundle 'othree/eregex.vim' "Perl-like extended regex for vim
NeoBundle 'chrisbra/Join.git' "Extended and fast Join for vim
NeoBundle 'lyokha/vim-xkbswitch.git' "Autoswitch on <esc> with libxkb needs xkb-switch-git to run
"is all about surroundings: parentheses, brackets, quotes, XML tags, and more
NeoBundleLazy 'tpope/vim-surround', { 'mappings' : [ ['n', 'cs', 'ds', 'ys', 'yS'], ['x', 'S']] }
NeoBundle 'kana/vim-arpeggio.git' "mappings for simultaneously pressed keys
NeoBundle 'scrooloose/nerdtree' "classic NERDTree plugin
NeoBundle 'Xuyuanp/nerdtree-git-plugin' "NERDTree with git support
NeoBundle 'jamessan/vim-gnupg.git' "Transparent work with gpg-encrypted files
NeoBundle 'Shougo/echodoc.vim' "prints doc in echo area
NeoBundle 'blindFS/vim-taskwarrior' "add taskwarrior vim plug wrapper
NeoBundle 'kopischke/vim-fetch' "vim path/to/file.ext:12:3
NeoBundle 'FooSoft/vim-argwrap' "vim arg wrapper
"--[ dev ]-------------------------------------------------------------------------------
NeoBundleLazy 'majutsushi/tagbar', { 'commands' : 'TagbarToggle' }
NeoBundle 'chrisbra/vim-diff-enhanced.git' "patience diff
NeoBundle 'sombr/vim-scala-worksheet.git' "tiny Vim plugin that turns your file into interactive worksheet
"NeoBundle 'tomtom/tcomment_vim.git' "easier comments
NeoBundle 'tpope/vim-commentary.git' "try it instead of tcomment
NeoBundle 'tpope/vim-endwise' "to insert endif for if, end for begin and so on
NeoBundle 'tpope/vim-unimpaired.git' "good mappings and toggles
NeoBundle 'dbakker/vim-projectroot' "better rooter
NeoBundle 'Valloric/ListToggle.git' "toggle quickfix and location list <leader>l by def
NeoBundle 'derekwyatt/vim-fswitch.git' "switching between companion source files (e.g. .h and .cpp)
NeoBundle 'vim-scripts/IndentConsistencyCop.git' "autochecks for indent
NeoBundle 'hynek/vim-python-pep8-indent.git' "python autoindent pep8 compatible
NeoBundle 'fs111/pydoc.vim' , {'autoload': {'filetypes': ['python']} } "pydoc integration
if executable("mono")
    NeoBundleLazy 'nosami/Omnisharp.git', { 'filetypes' : 'cs' } "omnisharp completion
endif
NeoBundle 'jstemmer/gotags.git' "tags for go
if executable("go")
    NeoBundle 'Blackrush/vim-gocode.git' "omnicomplete for go
    NeoBundle 'fatih/vim-go.git' "golang support
endif
NeoBundle 'rust-lang/rust.vim' "detection of rust files
NeoBundle 'jtdowney/vimux-cargo' "rust-cargo bindings
" NeoBundle 'racer-rust/vim-racer.git' "rust autocomplete
NeoBundle 'vim-scripts/taglist.vim.git' "show taglist
NeoBundleLazy 'vim-perl/vim-perl', { 'filetypes' : 'perl' }
NeoBundleLazy 'wannesm/wmgraphviz.vim', { 'filetypes' : 'dot' }
NeoBundle 'sbl/scvim.git' "vim plugin for supercollider
NeoBundle 'janko-m/vim-test.git' "easy testing with vim
NeoBundle 'xolox/vim-lua-ftplugin.git' "test lua bindings
NeoBundle 'vim-scripts/ifdef-highlighting.git' "ifdef highlight
NeoBundle 'oscarh/vimerl' "vim erlang support
NeoBundle 'lyuts/vim-rtags.git' "rtags plugin for vim
NeoBundle 'tpope/vim-dispatch.git' "provide async build via tmux
if (executable("ghci") && executable("ghcmod"))
    NeoBundle 'ujihisa/neco-ghc' "autocomplete for hs using ghc-mod
    NeoBundle 'eagletmt/ghcmod-vim.git'
    NeoBundle 'bitc/vim-hdevtools' "type-related features
endif                                        
NeoBundle 'derekwyatt/vim-scala' "various initial scala support for vim
NeoBundle 'derekwyatt/vim-sbt' "basic SBT support for vim
NeoBundle 'tpope/vim-rails.git' "rails plugin from Tim Pope
NeoBundle 'tpope/vim-rake.git' "ruby rake support
NeoBundle 'tpope/vim-rbenv.git' "ruby rbenv support
NeoBundle 'shawncplus/phpcomplete.vim.git' "better than default phpcomplete.vim
" Multi-language DBGP debugger client for Vim (PHP, Python, Perl, Ruby, etc.)
NeoBundleLazy 'joonty/vdebug', { 'autoload': { 'commands': 'VdebugStart' }}
" html5 autocomplete and syntax
NeoBundleLazy 'othree/html5.vim' , {'autoload': {'filetypes': ['html', 'htmldjango']} }
" It's not compatible with YouCompleteMe
" --------------------------------------
" NeoBundle 'davidhalter/jedi-vim'
" " Do not load vim-pyenv until *.py is opened and
" " make sure that it is loaded after jedi-vim is loaded.
" NeoBundleLazy 'lambdalisue/vim-pyenv', {
"         \ 'depends': ['davidhalter/jedi-vim'],
"         \ 'autoload': { 'filetypes': ['python', 'python3'], }}
NeoBundle 'fatih/vim-nginx' "nginx runtime files
"----------------[  Tags  ]--------------------------------------------------------------
NeoBundle 'szw/vim-tags' "autogen ctags
if executable("gtags")
    NeoBundle 'yuki777/gtags.vim.git' "Gtags v0.64
    NeoBundle 'bbchung/gasynctags.git' "autogenerate gtags to cscope db
    NeoBundle 'tranngocthachs/gtags-cscope-vim-plugin.git' "gtags-cscope navigation
endif
if has("cscope")
    "Alternative workground to work with cscope
    NeoBundle 'https://bitbucket.org/madevgeny/yate.git'
endif
"--[ latex ]-----------------------------------------------------------------------------
NeoBundle 'lervag/vimtex' "LaTeX-Box replacement
"--[ web ]-------------------------------------------------------------------------------
NeoBundle 'rstacruz/sparkup.git' "write html code faster
NeoBundle 'Valloric/vim-instant-markdown' "realtime markdown preview
"NeoBundleLazy 'marijnh/tern_for_vim', { 'autoload': { 'filetypes': ['javascript'] } }
"---------------[ syntax ]---------------------------------------------------------------
NeoBundle 'vimez/vim-tmux' "syntax hi for tmux
NeoBundle 'elzr/vim-json' "syntax hi for json format
NeoBundle 'cespare/vim-toml' "syntax hi for toml format
NeoBundle 'rsmenon/vim-mathematica.git' "Mathematica syntax and omnicomp
NeoBundle 'jelera/vim-javascript-syntax.git' "js highlighting
NeoBundle 'travitch/hasksyn' "simple highlight for normal haskell code
NeoBundle 'Twinside/vim-haskellConceal' "conceal operator for haskell
NeoBundle 'tpope/vim-git' "syntax, indent, and filetype plugin files for git
NeoBundle 'ekalinin/Dockerfile.vim' "dockerfile hi
NeoBundle 'jnwhiteh/vim-golang.git' "golang syntax highlight
NeoBundleLazy 'farseer90718/vim-regionsyntax', { 'filetypes' : ['vimwiki', 'markdown', 'tex', 'html'] }
NeoBundle 'JulesWang/css.vim' "better css syntax hi
NeoBundle 'leafo/moonscript-vim' "basic moonscript support
NeoBundle 'rodjek/vim-puppet' "basic puppet support
" if (false && !has("nvim"))
"     NeoBundle 'bbchung/clighter.git' "hi with clang
" else
"     NeoBundle 'bbchung/Clamp' "clighterr for neovim
" endif
if has("gui_running")
    NeoBundle 'drmikehenry/vim-fontsize.git' "set fontsize on the fly
    NeoBundle 'tyru/restart.vim.git' "add restart support
    NeoBundle 'vim-scripts/utl.vim.git' "Open urls in files
    NeoBundle 'bling/vim-airline.git' "statusline for gvim only
endif
NeoBundle 'ryanoasis/vim-devicons.git' "fancy icons for fonts
