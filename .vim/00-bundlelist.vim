NeoBundle 'tomtom/tinykeymap_vim.git' "test it for a new keymaps
NeoBundle 'amix/open_file_under_cursor.vim.git' "open file under cursor with gf
"--[ Main ]--------------------------------------------------------------------------------------------------
NeoBundle 'Valloric/YouCompleteMe' "ultimate completion engine for c/cpp and python etc
NeoBundle 'junegunn/fzf' "use fzf plug for vim
NeoBundle 'szw/vim-ctrlspace.git' "better sessions
NeoBundle 'dyng/ctrlsf.vim.git' " An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2 
NeoBundle 'xolox/vim-misc.git' "helpers for lua-mode
NeoBundleLazy 'chrisbra/NrrwRgn', {
            \ 'commands' : ['NR', 'NRP']
            \ }
NeoBundle 'neg-serg/vim-colors' "all colors which I want
NeoBundle 'NLKNguyen/papercolor-theme' "new light colorscheme
NeoBundle 'luochen1990/rainbow.git' "improved rainbow-parentesis
NeoBundle 'Shougo/vimproc' "vimproc is for faster work of unite
NeoBundle 'Shougo/vimproc.vim', {
            \ 'build' : {
            \ 'windows' : 'make -f make_mingw32.mak',
            \ 'cygwin' : 'make -f make_cygwin.mak',
            \ 'mac' : 'make -f make_mac.mak',
            \ 'unix' : 'make -f make_unix.mak',
            \ }
            \ }
NeoBundle 'Shougo/neomru.vim.git' "mru for unite
NeoBundle 'vim-jp/vital.vim.git' "improve unite perf
NeoBundle 'Shougo/unite.vim.git' "unite for creating ui
NeoBundle 'mopp/autodirmake.vim.git' "automake dir which didnt exists
NeoBundleLazy 'Shougo/vimfiler.vim', {
            \ 'depends' : 'Shougo/unite.vim',
            \ 'commands' : [
            \ { 'name' : 'VimFiler',
            \ 'complete' : 'customlist,vimfiler#complete' },
            \ { 'name' : 'VimFilerTab',
            \ 'complete' : 'customlist,vimfiler#complete' },
            \ { 'name' : 'VimFilerExplorer',
            \ 'complete' : 'customlist,vimfiler#complete' },
            \ { 'name' : 'Edit',
            \ 'complete' : 'customlist,vimfiler#complete' },
            \ { 'name' : 'Write',
            \ 'complete' : 'customlist,vimfiler#complete' },
            \ 'Read', 'Source'],
            \ 'mappings' : '<Plug>(vimfiler_',
            \ 'explorer' : 1,
            \ }
NeoBundleLazy 'hewes/unite-gtags', {
            \ 'external_commands' : 'global',
            \ 'unite_sources' : 'gtags'
            \ }
NeoBundleLazy 'Shougo/unite-outline', {
            \ 'unite_sources' : 'outline'
            \ }
NeoBundleLazy 'tsukkee/unite-tag', {
            \ 'unite_sources' : 'tag'
            \ }
NeoBundle 'Shougo/junkfile.vim.git' "junkfile for unite
NeoBundle 'neg-serg/vim-like-emacs' "add some bindings from readline and emacs for nice vim editing
NeoBundle 'rhysd/vim-clang-format.git' "format code by clang, better that astyle -A14
NeoBundle 'sjbach/lusty.git' "file/buffer explorer
NeoBundle 'SirVer/ultisnips.git' "Snippets with ycm compatibility
NeoBundle 'godlygeek/tabular.git' "for tabularizing
if executable("ack")
    NeoBundle 'mileszs/ack.vim' "ack wrapper
endif
if executable("ag")
    NeoBundle 'rking/ag.vim.git' "ag (ack replacement) wrapper
endif
NeoBundleLazy 'tpope/vim-repeat', {
            \ 'mappings' : '.'
            \ }
NeoBundle 'tpope/vim-eunuch.git' "for SudoWrite, Locate, Find etc
NeoBundleLazy 'sjl/gundo.vim', {
            \ 'commands' : 'GundoToggle'
            \ }
NeoBundleLazy 'Raimondi/delimitMate', {
            \ 'insert' : 1
            \ }
NeoBundleLazy 'scrooloose/syntastic', {
            \ 'insert' : 1
            \ }
" NeoBundle 'nathanaelkane/vim-indent-guides' "indent tabs visually with |-es too slow
NeoBundle 'Yggdroot/indentLine.git' "indent tabs visually with |-es too slow
NeoBundle 'xkdcc/Session-Viminfo-Management.git' "session managing
NeoBundle 'tpope/vim-abolish.git' "substitute with steroids
NeoBundle 'thinca/vim-qfreplace.git' "visual replace for multiple files
"--[ dcvs ]--------------------------------------------------------------------------------------------------
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
"------------------------------------------------------------------------------------------------------------
if executable("tmux")
    NeoBundle 'tpope/vim-tbone.git' "tmux basics
    NeoBundle 'benmills/vimux.git' "exec commands in tmux
    NeoBundle 'christoomey/vim-tmux-navigator' "easy jump between windows
endif
NeoBundle 'tpope/vim-dispatch.git' "Should provide async build
if (executable("ghci") && executable("ghcmod"))
    NeoBundle 'ujihisa/neco-ghc' "autocomplete for hs using ghc-mod
endif                                        
NeoBundle 'derekwyatt/vim-scala' "different initial scala support for vim
NeoBundle 'derekwyatt/vim-sbt' "basic SBT support for vim
"--[ misc ]--------------------------------------------------------------------------------------------------
NeoBundle 'manicmaniac/betterga.git' "better ga
NeoBundle 'reedes/vim-pencil' "autowrap lines
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
NeoBundleLazy 'tpope/vim-surround', {
            \ 'mappings' : [
            \ ['n', 'cs', 'ds', 'ys', 'yS'],
            \ ['x', 'S']]
            \ }
NeoBundle 'lyuts/vim-rtags.git' "rtags plugin for vim
"--[ dev ]---------------------------------------------------------------------------------------------------
NeoBundleLazy 'majutsushi/tagbar', {
            \ 'commands' : 'TagbarToggle'
            \ }
NeoBundle 'chrisbra/vim-diff-enhanced.git' "patience diff
NeoBundle 'sombr/vim-scala-worksheet.git' "tiny Vim plugin that turns your file into interactive worksheet
NeoBundle 'tomtom/tcomment_vim.git' "easier comments
NeoBundle 'tpope/vim-endwise' "to insert endif for if, end for begin and so on
NeoBundle 'tpope/vim-unimpaired.git' "good mappings and toggles
NeoBundle 'dbakker/vim-projectroot' "better rooter
NeoBundle 'Valloric/ListToggle.git' "toggle quickfix and location list <leader>l by def
NeoBundle 'derekwyatt/vim-fswitch.git' "switching between companion source files (e.g. .h and .cpp)
NeoBundle 'vim-scripts/IndentConsistencyCop.git' "autochecks for indent
NeoBundle 'hynek/vim-python-pep8-indent.git' "python autoindent pep8 compatible
if executable("mono")
    NeoBundle 'nosami/Omnisharp.git' "omnisharp completion
endif
NeoBundle 'jstemmer/gotags.git' "tags for go
if executable("go")
    NeoBundle 'Blackrush/vim-gocode.git' "omnicomplete for go
endif
NeoBundle 'ebfe/vim-racer.git' "autocomp rust with racer
NeoBundle 'vim-scripts/taglist.vim.git' "show taglist
NeoBundleLazy 'vim-perl/vim-perl', {
            \ 'filetypes' : 'perl'
            \ }
NeoBundleLazy 'wannesm/wmgraphviz.vim', {
            \ 'filetypes' : 'dot'
            \ }
NeoBundle 'sbl/scvim.git' " vim plugin for supercollider
NeoBundle 'janko-m/vim-test.git' "easy testing with vim
NeoBundle 'xolox/vim-lua-ftplugin.git' "test lua bindings
NeoBundle 'vim-scripts/ifdef-highlighting.git' "ifdef highlight
""---------------[  Tags  ]-----------------------------------------------------------------------------------
NeoBundle 'szw/vim-tags' "autogen ctags
if executable("gtags")
    NeoBundle 'yuki777/gtags.vim.git' "Gtags v0.64
    NeoBundle 'vim-scripts/multiwindow-source-code-browsing.git' "gtag multiwindow
    NeoBundle 'bbchung/gasynctags.git' "autogenerate gtags to cscope db
    NeoBundle 'tranngocthachs/gtags-cscope-vim-plugin.git' "gtags-cscope navigation
endif
if has("cscope")
    "Alternative workground to work with cscope
    NeoBundle 'https://bitbucket.org/madevgeny/yate.git'
endif
"--[ latex ]-------------------------------------------------------------------------------------------------
" NeoBundle 'LaTeX-Box-Team/LaTeX-Box.git' "maybe latex-box is better than others
"--[ web ]---------------------------------------------------------------------------------------------------
NeoBundle 'jaxbot/browserlink.vim.git' "live edit for html/js/css
NeoBundle 'Valloric/vim-instant-markdown' "realtime markdown preview
NeoBundleLazy 'mattn/emmet-vim', {
            \ 'filetypes' : [
            \   'html', 'css', 'xml', 'vimwiki', 'markdown']
            \ }
NeoBundleLazy 'marijnh/tern_for_vim', {
    \ 'autoload': { 'filetypes': ['javascript'] }
\ }
"---------------[ syntax ]-----------------------------------------------------------------------------------
NeoBundle 'vimez/vim-tmux' "syntax hi for tmux
NeoBundle 'elzr/vim-json' "syntax hi for json format
NeoBundle 'rsmenon/vim-mathematica.git' "Mathematica syntax and omnicomp
NeoBundle 'wting/rust.vim' "rust bindings for vim syntax hi
NeoBundle 'jelera/vim-javascript-syntax.git' "js highlighting
NeoBundle 'travitch/hasksyn' "simple highlight for normal haskell code
NeoBundle 'tpope/vim-git' "syntax, indent, and filetype plugin files for git
NeoBundle 'jnwhiteh/vim-golang.git' "golang syntax highlight
NeoBundleLazy 'farseer90718/vim-regionsyntax', {
            \ 'filetypes' : ['vimwiki', 'markdown', 'tex', 'html']
            \ }
" NeoBundle 'bbchung/clighter.git'
if has("gui_running")
    NeoBundle 'drmikehenry/vim-fontsize.git' "set fontsize on the fly
    NeoBundle 'tyru/restart.vim.git' "add restart support
    NeoBundle 'vim-scripts/utl.vim.git' "Open urls in files
    NeoBundle 'bling/vim-airline.git' "statusline for gvim only
endif
