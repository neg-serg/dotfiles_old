" NeoBundle '5t111111/alt-gtags.vim.git'      "no tagstack :(, use unite 
" NeoBundleLazy 'tacahiroy/ctrlp-funky'       "jump to function without tags
" NeoBundle 'roman/golden-ratio.git'          "buggy and not compatible with  unite for me
" NeoBundle 'kablamo/vim-git-log.git'         "There is no need in it, not fancy
" NeoBundle 'mattn/zencoding-vim'             "web
" NeoBundle 'matthias-guenther/hammer.vim'    "web
" NeoBundle 'Shougo/echodoc.git'              "haskell stuff
" NeoBundle 'davidhalter/jedi-vim'            "jedi completion for python
" NeoBundle 'ardagnir/united-front'           "share registers with all vim instances
" NeoBundle 'jmcantrell/vim-virtualenv'       "virtualenv for python
" NeoBundle 'vim-scripts/UnconditionalPaste'  "to insert that yanked text in the middle of some other line (or vice versa)
" conflict with tcomment
" NeoBundle 'Shougo/vinarise.git'             "Hex editor
" NeoBundle 'vim-scripts/restore_view.vim'    "allow you to restore view on last git commit
" NeoBundle 'dag/vim2hs'                      "very and very good additions and hi for hs. Allow gf&go TOOOOOOOO SLOW!!!!!!!
" NeoBundle 'gerw/vim-latex-suite.git'        "tex autocompletion TOOOOOOOOOOOOOO SLOOOOOW
" NeoBundle 'itchyny/thumbnail.vim.git'       "Thumbnail-style buffer selector(nice!)
" NeoBundle 'matze/vim-move.git'              "Move text in vim(works!)
" NeoBundle 'kbairak/TurboMark.git'           "Simple marking
" NeoBundle 'dpwright/vim-gf-ext'             "open external program with gf
" NeoBundle 'junkblocker/patchreview-vim'     "codereview for dvcs
" NeoBundle 'junkblocker/VimSpy.git'          "browse through almost all vim structs
" NeoBundle 'AndrewRadev/multichange.vim.git' "Test
" NeoBundle 'dbakker/vim-projectroot.git'     "experimental replacement for project-root
" NeoBundle 'reedes/vim-one.git'              "only 1 vim for osx
" NeoBundle 'vim-scripts/vim-cmake-project.git'
" NeoBundle 'zepto/unite-tmux'

" ------------------------------------------------------------------------------------------------------------
" --[ good but not useful yet ]-------------------------------------------------------------------------------
" ------------------------------------------------------------------------------------------------------------
" NeoBundle 'edkolev/tmuxline.vim.git'        "Tmuxline for tmux  :
" NeoBundle 'edkolev/promptline.vim.git'      "Promptline for zsh : should be maked standalone

" NeoBundle 'goldfeld/vim-seek.git'           "Navigate fast like with f
" NeoBundle 'kien/rainbow_parentheses.vim'    "rainbow ()[]
" NeoBundle 'amdt/vim-niji.git'               "rainbox ()[] replacement
" NeoBundle 'glts/vim-cottidie'               "tips :)
" NeoBundle 'vim-scripts/LanguageTool.git'    "Language tool for cheking style
" NeoBundle 'svermeulen/vim-easyclip'         "Try to not garbage copy/paste(work) add dd append
" NeoBundle 'sickill/vim-pasta.git'           "Test it again for pasting
" NeoBundle 'airblade/vim-gitgutter.git'      "Shows changes Tooooooo slow
" NeoBundle 'xolox/vim-session.git'           "Session managment for vim
" NeoBundle 'eagletmt/ghcmod-vim'             "ghc-mod happy hacking integration for vim
" NeoBundle 'vim-scripts/sessionman.vim'      "session manager
" NeoBundle 'nelstrom/vim-visual-star-search' "Probably it's star operator replacement
" NeoBundle 'wikitopian/hardmode.git'         "Nice stuff (:
" NeoBundle 'henrik/vim-indexed-search.git'   "when you do searches will show you 'Match 2 of 4' in the status line
"                                             "not useful and probably slowpoke
" NeoBundle 'vim-scripts/SearchComplete.git'  "Tab completion for search
" NeoBundle 'Keithbsmiley/investigate.vim'    "Search for under cursor info
" NeoBundle 'itchyny/lightline.vim.git'       "fancy statusline
" NeoBundle 'gavinbeatty/dragvisuals.vim.git' "drag test visually
" NeoBundle 'mjbrownie/swapit'                "Generic swapper too complicate for me
" NeoBundle 'justinmk/vim-sneak'              " S with two chars
" NeoBundle 'https://bitbucket.org/ZyX_I/aurum' "hg/git and others wrapper
" NeoBundle 'a.vim'                             "switch to header from src quickly
" NeoBundle 'bling/vim-bufferline.git'          "Show buffers in statusline
" NeoBundle 'mhinz/vim-signify'                 "Show diff information +/- like counts
" NeoBundle 'ntpeters/vim-better-whitespace'    "hi for whitespaces
" NeoBundle 'xuhdev/SingleCompile'              "for only one file compilation
" NeoBundle 'Valloric/vim-operator-highlight'   "hi for []()\, too bright for me
" NeoBundle 'spf13/vim-preview'                 "markdown preview for vim
" NeoBundle 'ardagnir/pterosaur.git'            "edit text with vim in pentadactyl, didn't work, bad
" NeoBundle 'jimsei/winresizer.git'             "Resize window simply
" NeoBundle 'gcmt/wildfire.vim.git'             "<enter> for visualmode
" NeoBundle 'gcmt/surfer.vim.git'               "Yet another natigator for tags // ctags //
" NeoBundle 'derekwyatt/vim-protodef'           "automake cpp by hpp
" NeoBundle 'Chiel92/vim-autoformat'            "astyle wrapper. I like to use astyle manually
" NeoBundle 'tpope/vim-afterimage.git'    "some nice stuff for edit xpm
" NeoBundle 'bitbucket.org/madevgeny/yate.git'  "Alternative workground to work with cscope
" NeoBundle 'gilligan/vim-lldb.git'             "lldb frontend tooo buggy for now
" NeoBundle 'tpope/vim-abolish.git'             "advanced abbreviation & substitution replaced by egrep
" NeoBundle 'joedicastro/DirDiff.vim.git'       "Recursive diff on two directories and generate a diff 'window'

" --[ Make additional config for it"  ]-----------------------
" NeoBundle 'xolox/vim-misc'                    "for vim notes
" NeoBundle 'xolox/vim-notes'                   "vim notes
" NeoBundle 'Zuckonit/vim-gnote.git'            "For gmail notes
" " Settings for VimClojure
" let g:vimclojure#HighlightBuiltins=1 " Highlight Clojure's builtins
" let g:vimclojure#ParenRainbow=1 " Rainbow parentheses'!
" let g:vimclojure#DynamicHighlighting=1 " Dynamically highlight functions
" let vimclojure#NailgunClient="/Users/hinmanm/bin/ng" " Nailgun location
" let vimclojure#WantNailgun=1
" let vimclojure#SplitPos = "right"
" "let vimclojure#SplitSize = 15
" "let g:clj_want_gorilla=1 " Bananas! (Make sure nailgun in is your path)
" " PHP settings
" let php_sql_query=1
" let php_htmlInStrings=1
" let php_noShortTags=1
" let php_folding=1
" 

" " Settings for twitvim
" let twitvim_login='' " Requires using ,ts to input your username/password
" let g:twitvim_enable_python=1 " Use python for fetchinng the tweets
" let g:twitvim_count=50 " Grab 50 tweets
" let g:twitvim_browser_cmd = 'open' " browser to use
" " Use SSL for twitter
" let twitvim_api_root = "https://twitter.com"

"--[ Tlist = taglist ]-------------------------------------------------------
" let &errorformat="%f:%l:%c: %t%*[^:]:%m,%f:%l: %t%*[^:]:%m," . &errorformat
" let g:Tlist_Show_One_File=1                  
" let g:Tlist_GainFocus_On_ToggleOpen=1       
" let g:Tlist_Compact_Format=1
" let g:Tlist_Close_On_Select=0              
" let g:Tlist_Auto_Highlight_Tag=1          
" let g:slimv_port = 10101
" let g:slimv_client = 'python ~/.vim/plugin/slimv.py -r "urxvt -T Slimv -e @p @s -l clisp -s"'
" --------------------
" ShowMarks
" --------------------
" let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
" let g:showmarks_enable = 1
" let g:NERDCustomDelimiters = {
"     \ 'haskell': { 'left': '--' , 'right': '' },
"     \ 'hamlet' : { 'left': '\<!-- ', 'right': ' -->' },
"     \ 'cassius': { 'left': '/* ' , 'right': ' */' },
"     \ 'lucius' : { 'left': '/* ' , 'right': ' */' },
"     \ 'julius' : { 'left': '//' , 'right': '' }
" \ }
"
" Complete options (disable preview scratch window)
"set completeopt = menu,menuone,longest
" Limit popup menu height
" SuperTab option for context aware completion
" let g:SuperTabDefaultCompletionType = "context"
" Disable auto popup, use <Tab> to autocomplete
" let g:ctk_execprg=''

" Supertab settings
" supertab + eclim == java win
" let g:SuperTabDefaultCompletionType = "context"
" let g:SuperTabLongestHighlight = 1

"" 'open' on OSX will open the url in the default browser without issue
"let g:EclimBrowser='open'
"" Disable Eclim's taglisttoo because I use the regular taglist plugin
""let g:taglisttoo_disabled = 1
"" Disable HTML & PHP validation
"let g:EclimHtmlValidate = 0
"let g:EclimPhpValidate = 0

"
"" EASYGREP
" let g:EasyGrepMode=1
" let g:EasyGrepCommand=0
" let g:EasyGrepRecursive=0
" let g:EasyGrepIgnoreCase=1
" let g:EasyGrepHidden=0
" let g:EasyGrepAllOptionsInExplorer=1
" let g:EasyGrepWindow=1
" let g:EasyGrepReplaceWindowMode=0
" let g:EasyGrepOpenWindowOnMatch=1
" let g:EasyGrepEveryMatch=0
" let g:EasyGrepJumpToMatch=1
" let g:EasyGrepInvertWholeWord=0
" let g:EasyGrepFileAssociationsInExplorer=0
" let g:EasyGrepOptionPrefix='<leader>vy'
" let g:EasyGrepReplaceAllPerFile=0
" 
"
" " ,nn will toggle NERDTree on and off
" " html conversion (:help 2html.vim)
" let g:html_use_css = 1
" let g:use_xhtml = 1
" let g:html_use_encoding = "utf8"
" let g:html_number_lines = 1
" let html_number_lines=1
" let html_use_css=1
" "Syntax highlighting settings
" " Switch syntax highlighting on, when the terminal has colors
" " Also switch on highlighting the last used search pattern.
" 
"

" NerdTree {
" let NERDTreeShowBookmarks=1
" let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
" let NERDTreeChDirMode=0
" let NERDTreeQuitOnOpen=1
" let NERDTreeShowHidden=1
" let NERDTreeKeepTreeInNewTab=1
" let NERDTreeChDirMode=2
" let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\~$']
" let NERDTreeHightlightCursorline=1

"----[  buftabs  ]----------------------
" let g:buftabs_only_basename=1
" let g:buftabs_separator = "."
" let g:buftabs_marker_start = "["
" let g:buftabs_marker_end = "]"
" let g:buftabs_marker_modified = "*"
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" -- New-New-New!
"" Plugin Settings {{{
"" -----------------------------------------------------------------------------
"let g:ctrlp_custom_ignore = {
"      \ 'dir':  '\.git$\|\.hg$\|\.svn$\|__pycache__$',
"      \ 'file': '\.pyc$\|\.so$\|\.swp$',
"      \ }

"let g:syntastic_mode_map = { 'mode': 'passive' }
"let g:syntastic_python_checker_args='--ignore=E501'

" "-------[  viki  ]----------------------------------
" let g:vikiNameSuffix=".viki"
" let g:vikiOpenFileWith_html  = "silent !firefox %{FILE}"
" "let g:vikiOpenFileWith_pdf  = ""silent !zathura %{FILE}"
" let g:vikiOpenUrlWith_mailto = 'urxvtc -e mutt %{URL}'
" "let g:vikiOpenUrlWith_ANY    = ""silent !firefox %{URL}"
" 

" Goddammit Apple, just enable 256 colors
" if g:VIM_PLATFORM == 'macunix' && $TERM_PROGRAM == 'Apple_Terminal'
"     let &t_Co = 16
" elseif &term =~ '^rxvt-unicode' || &term =~ '^xterm'

    " From ECMA-48:
    "   OSC - OPERATING SYSTEM COMMAND:
    "     Representation: 09/13 or ESC 05/13 (this is \033] here)
    "     OSC is used as the opening delimiter of a control string for
    "     operating system use.  The command string following may consist
    "     of a sequence of bit combinations in the range 00/08 to 00/13 and
    "     02/00 to 07/14.  The control string is closed by the terminating
    "     delimiter STRING TERMINATOR (ST).  The interpretation of the
    "     command string depends on the relevant operating system.
    " From :h t_SI:
    "   Added by Vim (there are no standard codes for these):
    "     t_SI start insert mode (bar cursor shape)
    "     t_EI end insert mode (block cursor shape)
    let &t_SI = "\033]12;rgb:00/CC/FF\007"
    let &t_EI = "\033]12;rgb:FF/F5/9B\007"

    :silent !echo -ne "\033]12;rgb:FF/F5/9B\007"

    augroup Terminal
        autocmd!
        autocmd VimLeave * :silent :!echo -ne "\033]12;rgb:FF/F5/9B\007"
    augroup END
elseif &term =~ '^screen'
    " From man screen:
    "   Virtual Terminal -> Control Sequences:
    "     ESC P  (A)  Device Control String
    "                 Outputs a string directly to the host
    "                 terminal without interpretation.
    "     ESC \  (A)  String Terminator
    let &t_SI = "\033P\033]12;rgb:00/CC/FF\007\033\\"
    let &t_EI = "\033P\033]12;rgb:FF/F5/9B\007\033\\"

    :silent !echo -ne "\033P\033]12;rgb:FF/F5/9B\007\033\\"

    augroup Terminal
        autocmd!
        autocmd VimLeave * :silent :!echo -ne "\033P\033]12;rgb:FF/F5/9B\007\033\\"
    augroup END
endif

" " ==== FILE SPECIFIED OPTIONS ===============================
" fun! s:setup_exec_cmd()
"   let cmd = input("cmd:",'','file')
"   return cmd
" endf
" 
" fun! s:run_exe()
"   if ! exists('g:exec_cmd')
"     let g:exec_cmd = s:setup_exec_cmd()
"   endif
"   echo "Executing.."
"   exec '! clear && '  . g:exec_cmd
"   echo "Done"
" endf
" 
" fun! s:init_c()
"   let c_comment_strings=1
" 
"   set path+=/usr/local/include/js/
"   set path+=/opt/local/include/cairo/
"   set path+=/opt/local/include/glib-2.0/
" 
"   com! RunExe      :cal s:run_exe()
"   nmap <C-c><C-c>  :make<CR>
"   nmap <C-c><C-x>  :RunExe<CR>
" 
"   setlocal cindent
"   setlocal fdm=syntax
"   ab #d #define
"   ab #i #include
"   setlocal equalprg=indent
" endf  
" 
" fu! s:init_cpp()
"   let c_comment_strings=1
"   set ep=indent
"   nm <F7>  :make<CR>
"   "au bufread,bufnewfile *.cpp  nm <c-f7> :!g++ -wall % -o %:r.out<cr>
"   "au bufread,bufnewfile *.cpp  :set makeprg=g++\ -wall\ %\ -o\ %:r.out
" endf  
" 
" "                                                                                             }}}
" "   html code                                                                                 
" 
" let html_use_css = 1
" fun! s:init_html()
"   nm  <F7>  :!firefox %<CR>
"   setlocal sw=1
"   setlocal et
" endf
" 
" " Filetype Rc Autocmd {{{
" augroup FiletypeRC
"   au!
"   au Filetype c              :cal s:init_c()
"   au Filetype cpp            :cal s:init_cpp()
"   au Filetype css            :cal s:init_css()
"   au Filetype html           :cal s:init_html()
"   au Filetype html           :cal s:js_rc()
"   au Filetype javascript     :cal s:js_rc()
"   au Filetype mason          :cal s:js_rc()
"   au Filetype perl           :cal s:init_perl()
"   au Filetype xul            :0r ~/.vim/skeleton/template.xul
"   au Filetype php            :cal s:init_php()
"   au filetype haskell        :cal s:init_hs()
"   au filetype vim            :cal s:init_vim()
" augroup END
" "}}}
" 
" fun! s:init_php()
"   setlocal ai si
"   setlocal fdm=marker
"   nmap <buffer> <C-x><C-x>  :!php %
" endf
" 
" fun! s:init_hs()
" 
" endf
" 
" " vim script helpers ======================================== 
" " bind load key for vim script file  
" fun! s:init_vim()
"   com! SearchCamelCaseFunctions /\<\([A-Z][a-z]*\)*(.*)
"   com! TranslateNamingStyle     :cal s:TranslateNamingStyle()
"   setlocal sw=2
"   nmap <buffer> <F6> :so %<CR>
"   nmap <buffer> ,s   :so %<CR>
"   " select vim function
"   nmap sf  ?^fu\%[nction]!?\s\+<CR>V/^endf\%[unction]<CR>
" endf
"
" fun! s:init_perl()
"   "check perl code with :make
"   set makeprg=perl\ -c\ %\ $*
"   set errorformat=%f:%l:%m
" 
"   "iabbr w warn
"   "iabbr p print
"   "iabbr end __END__
"   iabbr pkg __PACKAGE__
"   "iabbr $s_  $self
"   "iabbr $c_  $class
" 
"   iabbr _perl #!/usr/bin/env perl
"   iabbr _s    $self->
"   iabbr _pkg  package
"   " set tt2 as html
"   "au BufRead,BufNewFile *.tt2  :setfiletype html
" 
"   " syntax tuning.
"   let perl_include_pod             = 1
"   let perl_extended_vars           = 0
"   let perl_want_scope_in_variables = 1
"   let perl_fold                     = 1
"   let perl_fold_blocks              = 0
" 
"   " jifty syntax
"   let jifty_fold_schema             = 1
"   let jifty_fold_schema_column      = 1
"   let jifty_fold_template           = 1
"   let jifty_fold_tags               = 1
"   let jifty_fold_dispatcher         = 1
" 
"   " run perl code
"   " nmap <C-c><C-c>  :!perl %<CR>
"   " syntax check
"   " nmap <C-c><C-y>  :!perl -c %<CR>
" 
"   nmap <buffer> <silent> <C-c><C-c>  :make<CR>
"   nnoremap <silent><buffer> [[ m':call search('^\s*sub\>', "bW")<CR>
"   vnoremap <silent><buffer> [[ m':<C-U>exe "normal! gv"<Bar>call search('^\s*sub\>', "bW")<CR>
"   nnoremap <silent><buffer> ]] m':call search('^\s*sub\>', "W")<CR>
"   vnoremap <silent><buffer> ]] m':<C-U>exe "normal! gv"<Bar>call search('^\s*sub\>', "W")<CR>
" 
"   nnoremap <silent><buffer> ss :cal SyncWindowFunction()<CR>
" 
"   " Data::Dumper Helper
"   nmap <buffer> <leader>dd  Iuse<Space>Data::Dumper;warn<Space>Dumper(<ESC>A);<ESC>
" 
"   setlocal equalprg=perltidy
"   setlocal fdm=syntax
"   setlocal fdc=2 fdn=2 fdl=2 
"   " fdl: fold level
"   " fdn: fold nest max
"   " fdc: fold column
"   " set fml=3 " fml: fold min line
" 
"   "set  fdm=manual
"   " indentexpr , indent-expression , XXX read from <cWORD>
"   "set fde=GetPerlFold()
" endf  
" 
" fun! s:perl_test_rc()
"   " nmap <silent> <C-c><C-c>   :!clear && perl -Ilib %<CR>
"   nmap <buffer> <silent> <C-c><C-c>   :PerlTestThis<CR>
" endf
" 
" autocmd BufReadPost *.t :cal s:perl_test_rc()
"
"==================================== C ====================================
"" Default options for C files
"function! LoadTypeC()
"  setlocal formatoptions-=tc " don't wrap text or comments automatically
"  setlocal comments=s1:/*,mb:*,ex:*/,://

"  let b:c_gnu=1                 " highlight gcc specific items
"  let b:c_space_errors=1        " highlight trailing w/s and spaces before tab
"  let b:c_no_curly_error=1      " don't highlight {} inside ()
"  if &filetype == 'c'
"    let b:c_syntax_for_h=1
"  endif

"  " Check for apparent shiftwidth=8; my default is 4
"  let l:foundbrace = v:version >= 700 ?
"        \ search('{\s*$', 'cnw', 1000) : search('{\s*$', 'cnw')
"  if l:foundbrace != 0
"    if match(getline(l:foundbrace+1), '^ *\t\|^ \{8\}') > -1
"      setlocal shiftwidth=8
"    endif
"  endif

"  if has("cindent")
"    setlocal cindent cinoptions+=(0,u0,t0,l1
"  endif

"  if has("perl")
"    " Line up continuations on long #defines
"    vnoremap ,D :perldo s/(.*?)\s*\\*$/$1.(' 'x(79-length $1)).'\\'/e<CR>
"  endif

"  " Add support for various types of cscope searches based on the current word
"  if has("cscope")
"    noremap ,cc :cs find c <C-R>=expand("<cword>")<CR><CR>
"    noremap ,cd :cs find d <C-R>=expand("<cword>")<CR><CR>
"    noremap ,ce :cs find e <C-R>=expand("<cword>")<CR><CR>
"    noremap ,cf :cs find f <C-R>=expand("<cword>")<CR><CR>
"    noremap ,cg :cs find g <C-R>=expand("<cword>")<CR><CR>
"    noremap ,ci :cs find i <C-R>=expand("<cword>")<CR><CR>
"    noremap ,cs :cs find s <C-R>=expand("<cword>")<CR><CR>
"    noremap ,ct :cs find t <C-R>=expand("<cword>")<CR><CR>
"  endif
"endfunction

"augroup ag_c
"  autocmd!
"  autocmd FileType c,cpp call LoadTypeC()
"augroup END
"
" map <LocalLeader>tf :FriendsTwitter<cr>
" map <LocalLeader>ts :let twitvim_login=inputdialog('Twitter USER:PASS? ')<cr>
" map <LocalLeader>tw :PosttoTwitter<cr>
"
"" Eclim settings
"" ,i imports whatever is needed for current line
"nnoremap <silent> <LocalLeader>i :JavaImport<cr>
"" ,d opens javadoc for statement in browser
"nnoremap <silent> <LocalLeader>d :JavaDocSearch -x declarations<cr>
"" ,<enter> searches context for statement
"nnoremap <silent> <LocalLeader><cr> :JavaSearchContext<cr>
"" ,jv validates current java file
"nnoremap <silent> <LocalLeader>jv :Validate<cr>
"" ,jc shows corrections for the current line of java
"nnoremap <silent> <LocalLeader>jc :JavaCorrect<cr>
"

""--------------------------------------------------------------------------------
"" from: http://vim.wikia.com/wiki/Easy_%28un%29commenting_out_of_source_code
"" lhs comments
"" ,# shell, python, perl
"" ,/ c++
"" ,> email quote
"" ," vim
"" ,% latex, prolog
"" ,! assembly/X-resources
"" ,; scheme
"" ,- sql, ada, lua
"" ,c clears any of the previous comments
"map <leader>c# :s/^/#/<CR>
"map <leader>c/ :s/^/\/\//<CR>
"map <leader>c> :s/^/> /<CR>
"map <leader>c" :s/^/\"/<CR>
"map <leader>c% :s/^/%/<CR>
"map <leader>c! :s/^/!/<CR>
"map <leader>c; :s/^/;/<CR>
"map <leader>c- :s/^/--/<CR>
"map <leader>cc :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR>
"" wrapping comments
"" ,* c
"" ,( Standard ML
"" ,< html
"" ,d clears any of the wrapping comments
"map <leader>c* :s/^\(.*\)$/\/\* \1 \*\//<CR>
"map <leader>c( :s/^\(.*\)$/\(\* \1 \*\)/<CR>
"map <leader>c< :s/^\(.*\)$/<!-- \1 -->/<CR>
"map <leader>cd :s/^\([/(]\*\\|<!--\) \(.*\) \(\*[/)]\\|-->\)$/\2/<CR>
""--------------------------------------------------------------------------------

"---------------------------------------------------------------
" It is really useful, but reduse performance
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vnoremap $1 <esc>`>a)<esc>`<i(<esc>
" vnoremap $2 <esc>`>a]<esc>`<i[<esc>
" vnoremap $3 <esc>`>a}<esc>`<i{<esc>
" vnoremap $$ <esc>`>a"<esc>`<i"<esc>
" vnoremap $q <esc>`>a'<esc>`<i'<esc>
" vnoremap $e <esc>`>a"<esc>`<i"<esc>
" 
" " Map auto complete of (, ", ', [
" inoremap $1 ()<esc>i
" inoremap $2 []<esc>i
" inoremap $3 {}<esc>i
" inoremap $4 {<esc>o}<esc>O
" inoremap $q ''<esc>i
" inoremap $e ""<esc>i
" inoremap $t <><esc>i

" показать\спрятать номера строк
" imap <C-c>n <Esc>:set<Space>nu!<CR>a
" nmap <C-c>n :set<Space>nu!<CR>
" 
" imap <C-c>s <Esc>:setlocal spell spelllang=ru,en<CR>a
" nmap <C-c>s :setlocal spell spelllang=ru,en<CR>
" imap <C-c>ss <Esc>:setlocal spell spelllang=<CR>a
" nmap <C-c>ss :setlocal spell spelllang=<CR>
" map  <C-c>sm :emenu Spl.<TAB>
"
"-------------
"NerdTreeStuff
"--
" map <leader>e :NERDTreeToggle<CR>:NERDTreeMirror<CR>
" nmap <LocalLeader>nn :NERDTreeToggle<cr>
"--
"
" Bundle 'lyokha/vim-xkbswitch.git'
" let g:XkbSwitchEnabled = 1 
" let g:XkbSwitchIMappings = ['ru']
"
"set guicursor+=i:blinkwait10
"set guicursor=n-c:block-Cursor-blinkon0
"set guicursor+=v:block-vCursor-blinkon0
"set guicursor+=i-ci:ver100-iCursor
"
"set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>
"
"binds for latex LaTeX
" set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
"set statusline=%<[%02n]\ %F%(\ %m%h%w%y%r%)\ %a%=\ %8l,%c%V/%L\ (%P)\ [%08O:%02B]A
"
" vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
"
" "  In visual mode when you press * or # to search for the current selection
" vnoremap <silent> * :call VisualSelection('f')<CR>
" vnoremap <silent> # :call VisualSelection('b')<CR>
" 
" " When you press gv you vimgrep after the selected text
" vnoremap <silent> gv :call VisualSelection('gv')<CR>
" 
" " When you press <leader>r you can search and replace the selected text
" vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>
" nnoremap <M-t> x<Left>P2<Right>
" inoremap <M-t> <Esc><Right>x<Left>P2<Right>i
"
" " commands
" " grep pattern in this file
" " com! -nargs=* VG   :vimgrep <args> % 
" com! RC :tabedit $MYVIMRC
" com! Reload :source $MYVIMRC
" com! -complete=file -nargs=* G :grep <args>
" " convert <arrow  {{{
" com! -range -nargs=0 ConvertArrow  :cal s:ConvertArrow(<line1>,<line2>)
" cabbr carrow ConvertArrow
" fu! s:ConvertArrow(s,e)
"   silent! exec a:s . ',' . a:e . 's/</\&lt;/g'
"   silent! exec a:s . ',' . a:e . 's/>/\&gt;/g'
" endf  
" " }}}
" "   buffer sel by pattern {{{
" fu! BufSel(pattern)
"   let buf_count = bufnr("$")
"   let cur_bufnr = 1
"   let nummatches = 0
"   let firstmatchingbufnr = 0
"   while cur_bufnr <= buf_count
"     if(bufexists(cur_bufnr))
"       let currbufname = bufname(cur_bufnr)
"       if(match(currbufname, a:pattern) > -1)
"         echo cur_bufnr . ": ". bufname(cur_bufnr)
"         let nummatches += 1
"         let firstmatchingbufnr = cur_bufnr
"       endif
"     endif
"     let cur_bufnr = cur_bufnr + 1
"   endwhile
"   if(nummatches == 1)
"     execute ":buffer ". firstmatchingbufnr
"   elseif(nummatches > 1)
"     let desiredbufnr = input("Enter buffer number: ")
"     if(strlen(desiredbufnr) != 0)
"       execute ":buffer ". desiredbufnr
"     endif
"   else
"     echo "No matching buffers"
"   endif
" endf
" 
" fu! BufSelInput()
"   let pattern = input( "pattern: " )
"   call BufSel( pattern )
" endf
" 
" "Bind the BufSel() function to a user-command
" com! -nargs=1 Bs    :call BufSel("<args>")
" nmap <leader>bf      :call BufSelInput()<CR>
" "}}}
"
" fun! s:EnableView()
"   augroup UpdateView
"       au!
"       autocmd! BufWritePost *.*     silent mkview
"       autocmd! BufReadPost *.*      silent loadview
"   augroup END
" endf
" com! EnableView     :cal s:EnableView()
" com! DisableView    :au! UpdateView
" let s:enable_view = 1
" if s:enable_view
"   cal s:EnableView()
" endif
" 
" toggle colored right border after 80 chars
" set colorcolumn=0
" let s:color_column_old = 80

" function! s:ToggleColorColumn()
"     if s:color_column_old == 0
"         let s:color_column_old = &colorcolumn
"         windo let &colorcolumn = 0
"     else
"         windo let &colorcolumn=s:color_column_old
"         let s:color_column_old = 0
"     endif
" endfunction
"
" set keymap=russian-jcukenwin

"set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
"set fillchars=diff:⣿
"
" " Source some Files 
" " Note: The "expand" is necessary to evaluate ~dope
" "
" " File: VBlockquote.vim (Insert (Quote) stuff the way some emacs people do)
" let VBLOCK=expand("~/.vim/macros/VBlockquote.vim")
" if filereadable(VBLOCK)
"         exec "source " VBLOCK
" endif
"
" if ! has('gui_running')
" set ttimeoutlen=10
" augroup FastEscape
"     autocmd!
"     au InsertEnter * set timeoutlen=0
"     au InsertLeave * set timeoutlen=1000
" augroup END
" endif

" " set rtp+=/usr/lib/python3.3/site-packages/Powerline-beta-py3.3.egg/powerline/bindings/vim
" " python from powerline.vim import setup as powerline_setup
" " python powerline_setup()
" " python del powerline_setup
" let s:import_cmd = 'from powerline.vim import VimPowerline'
" try
"     exec s:powerline_pycmd "try:\n"
"                 \         ."    ".s:import_cmd."\n"
"                 \         ."except ImportError:\n"
"                 \         ."    import sys, vim\n"
"                 \         ."    sys.path.append(vim.eval('expand(\"<sfile>:h:h:h:h:h\")'))\n"
"                 \         ."    ".s:import_cmd
"     let s:launched = 1
" finally
"     if !exists('s:launched')
"         call s:CriticalError('An error occurred while importing the Powerline package.
"             \ This could be caused by an invalid sys.path setting, or by an incompatible
"             \ Python version (Powerline requires Python 2.6+ or 3.2+ to work). Please consult
"             \ the troubleshooting section in the documentation for possible solutions.')
"         finish
"     else
"         unlet s:launched
"     endif
" endtry
  
" 
" let g:Powerline_symbols = 'fancy'
" let g:Powerline_theme="default"
" let g:Powerline_colorscheme="skwp"
" let g:Powerline_mode_n = 'N'
"
" " Autocommands {{{
"   function! s:CreateAutocmds()
"     augroup PowerlineMain
"       autocmd!
" 
"       " Reload statuslines when changing color scheme
"       autocmd ColorScheme *
"         \ call Pl#Load()
" 
"       autocmd BufEnter,WinEnter,FileType,BufUnload *
"         \ call Pl#UpdateStatusline(1)
" 
"       autocmd BufLeave,WinLeave *
"         \ call Pl#UpdateStatusline(0)
" 
"       autocmd BufWritePost */autoload/Powerline/Colorschemes/*.vim
"         \ :PowerlineReloadColorscheme
"     augroup END
"   endfunction
" 
"   augroup PowerlineStartup
"     autocmd!
" 
"     autocmd VimEnter * call s:CreateAutocmds() | call Pl#UpdateStatusline(1)
"   augroup END
" " }}}
"
" augroup FastEscape
"   autocmd!
"   set notimeout
"   set ttimeout
"   set timeoutlen=10
"   au InsertEnter * set timeout
"   au InsertLeave * set notimeout
" augroup END
"
" nnoremap <bar> :call <SID>ToggleColorColumn()<cr>
"
" if has('gui_gtk')
"   noremap <silent> <m-c> "+y
"   noremap <silent> <m-v> "+p
"   noremap <silent> <m-x> "+d
" endif

" " Find a file and pass it to cmd
" function! DmenuOpen(cmd)
"   let fname = Chomp(system("find ~ -type f | dmenu -i -l 20 -p " . a:cmd))
"   if empty(fname)
"     return
"   endif
"   execute a:cmd . " " . fname
" endfunction
" 
" " use ctrl-t to open file in a new tab
" " use ctrl-f to open file in current buffer
" map <c-t> :call DmenuOpen("tabe")<cr>
" map <c-f> :call DmenuOpen("e")<cr>
"
" let g:airline_powerline_fonts = 1
" let g:airline_theme='solarized'
"
" -------------------------------------------------------------------------------------------------
" -----DUDE CONFIG---------------------------------------------------------------------------------
"set nocompatible
" 
" syntax on
" filetype off
" 
" colorscheme romockee
" " colorscheme lucius
" " let g:lucius_style="light"
" 
" " if (strftime("%H")>=9)
" " set background=light
" " endif
" " if (strftime("%H")>=21)
" " set background=dark
" " endif
" 
" "|||||||| Vundle:
" 
" set rtp+=~/.vim/bundle/vundle/
" call vundle#rc()
" Bundle 'gmarik/vundle'
" 
" "|||||||| Ruby specific bundlelist:
" 
" Bundle 'vim-ruby/vim-ruby'
" Bundle 'tpope/vim-rails'
" Bundle 'tpope/vim-endwise'
" " Bundle 'tpope/vim-rake'
" " Bundle 'tpope/vim-bundler'
" Bundle 'benmills/vimux'
" " Bundle 'pgr0ss/vimux-ruby-test'
" " Bundle 'cloud8421/vimux-cucumber'
" " Bundle 'benmills/vimux-golang'
" " Bundle 'jgdavey/vim-turbux'
" Bundle 'slim-template/vim-slim'
" 
" "|||||||| Lisp/Scheme specific bundlelist:
" 
" " Bundle 'wlangstroth/vim-racket'
" " Bundle 'vim-scripts/scribble.vim'
" 
" "|||||||| Bundlelist:
" 
" " Bundle 'kien/ctrlp.vim'
" Bundle 'Valloric/YouCompleteMe'
" Bundle 'tpope/vim-commentary'
" Bundle 'tpope/vim-repeat'
" " Bundle 'jimsei/winresizer'
" Bundle 'mattn/emmet-vim'
" Bundle 'merlinrebrovic/focus.vim'
" Bundle 'mhinz/vim-startify'
" Bundle 'pangloss/vim-javascript'
" Bundle 'scrooloose/nerdcommenter'
" Bundle 'scrooloose/nerdtree'
" Bundle 'scrooloose/syntastic'
" Bundle 'kchmck/vim-coffee-script'
" Bundle 'tpope/vim-fugitive'
" Bundle 'tpope/vim-haml'
" Bundle 'tpope/vim-markdown'
" Bundle 'tpope/vim-surround'
" Bundle 'tpope/vim-unimpaired'
" Bundle 'paradigm/TextObjectify'
" Bundle 'jeetsukumaran/vim-buffergator'
" Bundle 'Raimondi/delimitMate'
" Bundle 'ryan-cf/netrw'
" Bundle 'altercation/vim-colors-solarized'
" " Bundle 'godlygeek/csapprox'
" " Bundle 'godlygeek/tabular'
" " Bundle 'rking/ag.vim'
" " Bundle 'Lokaltog/vim-easymotion'
" " Bundle 'vim-scripts/RangeMacro'
" " Bundle 'nelstrom/vim-visual-star-search'
" " Bundle 'derekwyatt/vim-scala'
" " Bundle 'SirVer/ultisnips'
" " Bundle 'honza/vim-snippets'
" " Bundle 'jimenezrick/vimerl'
" " Bundle 'yonchu/accelerated-smooth-scroll'
" " Bundle 'chriskempson/base16-vim'
" Bundle 'chrisbra/NrrwRgn'
" " Bundle 'chrisbra/changesPlugin'
" " Bundle 'joeytwiddle/sexy_scroller.vim'
" " Bundle 'glts/vim-cottidie'
" " Bundle 'sotte/presenting.vim' great for vimcasts! -> https://github.com/sotte/presenting.vim
" " Bundle 'kbairak/TurboMark'
" " Bundle 'moll/vim-node'
" " Bundle 'biskark/vim-ultimate-colorscheme-utility'
" " Bundle 'svermeulen/vim-easyclip'
" " Bundle 'bling/vim-airline'
" " Bundle 'justinmk/vim-gtfo'
" Bundle 'marijnh/tern_for_vim'
" " Bundle 'xolox/vim-colorscheme-switcher'
" " Bundle 'xolox/vim-misc'
" Bundle 'zweifisch/pipe2eval'
" " Bundle 'epeli/slimux'
" " Bundle 'suan/vim-instant-markdown'
" " Bundle ''
" 
" filetype plugin indent on
" filetype indent on
" filetype plugin on
" 
" "|||||||| Global options:
" 
" set autoindent
" set autoread
" set backspace=indent,eol,start
" " set clipboard=unnamedplus,unnamed
" set clipboard=unnamedplus,autoselect
" " set cpoptions+=n
" set encoding=utf-8
" set expandtab
" set fileencodings=utf-8,cp1251,koi8-r,cp866
" set foldcolumn=1
" set hidden
" set history=200
" set hlsearch
" set ignorecase smartcase
" set incsearch
" " set iskeyword=
" set laststatus=2
" " set lazyredraw
" " set magic
" " set winminheight=0
" set mouse=a
" set nobackup
" set noswapfile
" set nowritebackup
" " set nrformats=
" set number
" set numberwidth=4
" set ruler
" set scrolloff=3
" set shiftwidth=4
" set showmatch
" set showmode
" set shell=bash
" set smartindent
" set smarttab
" set t_Co=256
" set tabstop=4
" set timeoutlen=250
" set undolevels=1000
" set wildignore=*.swp,*.bak,*.pyc,*/.git/**/*,*/.hg/**/*,*/.svn/**/*
" set wildignorecase
" set wildmenu
" set wildmode=longest,full
" " set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>
" 
" "|||||||| Hotkeys und Shortkutz:
" 
" " let mapleader = ","
" set pastetoggle =<F2>
" imap <F1> <Nop>
" nmap <F1> <Nop>
" map <F1> :QFix<Return>
" map <F3> :call NextColorScheme()<CR>
" map <S-F3> :call PreviousColorScheme()<CR>
" nnoremap <F5> :GundoToggle<CR>
" map <F6> :setlocal spell! spelllang=en,ru<CR>
" map <S-Tab> :BuffergatorToggle<CR>
" imap <S-Tab> :BuffergatorToggle<CR>
" map <F7> <Esc>:Spacepaste<CR>
" nmap <C-F10> :qa!<cr>
" vmap <C-F10> <esc>:qa!<cr>i
" imap <C-F10> <esc>:qa!<cr>i
" map <C-F11> <Esc>:NERDTreeToggle<CR>
" imap <C-F12> <Esc>:set<Space>nu!<CR>a
" nmap <C-F12> :set<Space>nu!<CR>
" nnoremap <C-l> :nohls<CR><C-L>
" nmap <leader>w :w!<CR><C-l>
" nmap <leader>q :q!<CR>
" nmap <C-Up> [e
" nmap <C-Down> ]e
" vmap <C-Up> [egv
" vmap <C-Down> ]egv
" map <Insert> <Nop>
" imap <Insert> <Nop>
" imap <C-z> <Esc>ui
" map <C-z> <Nop>
" nnoremap <Leader>- :set cursorline!<CR>
" nnoremap <space> za
" imap <C-l> <space>=><space>
" nnoremap <C-j> 4jzz
" nnoremap <C-k> 4kzz
" " nmap <silent> mm :TurboMark<CR>
" " nmap <silent> '' :TurboFind<CR>
" nnoremap <leader>rc <C-w><C-v><C-l>:e $MYVIMRC<cr>
" map <PageUp> <C-U>
" map <PageDown> <C-D>
" imap <PageUp> <C-O><C-U>
" imap <PageDown> <C-O><C-D>
" 
" "|||||||| Nurturant mode:
" 
" map <Left> <Nop>
" imap <Left> <Nop>
" map <Right> <Nop>
" imap <Right> <Nop>
" map <Up> <Nop>
" imap <Up> <Nop>
" map <Down> <Nop>
" imap <Down> <Nop>
" inoremap kj <Esc>
" 
" "|||||||| Vimux:
" 
" map <Leader>] :w<CR>:call VimuxRunCommand("clear; rb " . bufname("%"))<CR>
" " map <Leader>rb :w<CR>:call VimuxRunCommand("clear; rb " . bufname("%"))<CR>
" " map <Leader>p :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>
" " map <Leader>rp :VimuxPromptCommand<CR>
" " map <Leader>rl :VimuxRunLastCommand<CR>
" " map <Leader>ri :VimuxInspectRunner<CR>
" map <Leader>[ :VimuxCloseRunner<CR>
" " map <Leader>rx :VimuxCloseRunner<CR>
" " map <Leader>rq :VimuxCloseRunner<CR>
" " map <Leader>rs :VimuxInterruptRunner<CR>
" " map <Leader>rh :let g:VimuxOrientation="v"<CR>
" " map <Leader>rv :let g:VimuxOrientation="h"<CR>
" let g:VimuxHeight = "50"
" 
" "|||||||| PowerLine:
" 
" let g:Powerline_symbols = 'fancy'
" let g:Powerline_mode_n = ' N '
" let g:Powerline_mode_i = ' I '
" let g:Powerline_mode_R = ' R '
" let g:Powerline_mode_v = ' V '
" let g:Powerline_mode_V = 'V·L'
" let g:Powerline_mode_cv = 'V·B'
" let g:Powerline_mode_s = ' S '
" let g:Powerline_mode_S = 'S·L'
" let g:Powerline_mode_cs = 'S·B'
" 
" "|||||||| Airline:
" 
" " set linespace=0
" let g:airline_powerline_fonts = 1
" let g:airline_left_sep = '⮀'
" let g:airline_left_alt_sep = '⮁'
" let g:airline_right_sep = '⮂'
" let g:airline_right_alt_sep = '⮃'
" let g:airline_branch_prefix = '⭠'
" let g:airline_readonly_symbol = '⭤'
" let g:airline_linecolumn_prefix = '⭡'
" " g:airline_enable_branch and g:airline_branch_prefix
" 
" "|||||||| vim-ruby:
" 
" " let g:rubycomplete_rails = 1
" " let g:rubycomplete_buffer_loading = 1
" " let g:rubycomplete_classes_in_global = 1
" 
" "|||||||| vim-JavaScript:
" 
" let g:html_indent_inctags = "html,body,head,tbody"
" let g:html_indent_script1 = "inc"
" let g:html_indent_style1 = "inc"
" 
" "|||||||| vim-CoffeScript:
" 
" hi link coffeeSpaceError NONE
" hi link coffeeSemicolonError NONE
" hi link coffeeReservedError NONE
" au BufWritePost *.coffee silent CoffeeMake!
" au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!
" let coffee_make_options = '--bare'
" let coffee_compiler = '/usr/bin/coffee'
" let coffee_compile_vert = 1
" let coffee_lint_options = '-f lint.json'
" let coffee_linter = '/usr/bin/coffeelint'
" au BufNewFile,BufReadPost *.coffee setl foldmethod=indent nofoldenable
" au BufNewFile,BufReadPost *.coffee setl foldmethod=indent
" au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
" 
" "|||||||| ag.vim/the_silver_searcher:
" 
" " let g:agprg="ag -H --nocolor --nogroup --column"
" 
" "|||||||| C-Support:
" 
" " let g:C_CFlags =
" " let g:C_CCompiler = 'gcc'
" " let g:C_CCompiler = 'clang'
" " let g:C_CCompiler = 'icc'
" 
" "|||||||| Syntastic:
" 
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_error_symbol='✖'
" let g:syntastic_warning_symbol='►'
" let g:syntastic_auto_jump=1
" 
" "|||||||| Emmet:
" 
" let g:user_emmet_leader_key = '<c-y>'
" " let g:user_emmet_expandabbr_key = ''
" " let g:user_emmet_expandword_key = ''
" " let g:user_emmet_balancetaginward_key = ''
" " let g:user_emmet_balancetagoutward_key = ''
" " let g:user_emmet_next_key = ''
" " let g:user_emmet_prev_key = ''
" " let g:user_emmet_imagesize_key = ''
" " let g:user_emmet_togglecomment_key = ''
" " let g:user_emmet_splitjointag_key = ''
" " let g:user_emmet_removetag_key = ''
" " let g:user_emmet_anchorizeurl_key = ''
" " let g:user_emmet_anchorizesummary_key = ''
" 
" "|||||||| Autocmd:
" 
" au FileType * setl fo-=cro
" au! FileType python setlocal et sw=4 ts=4 sts=4
" au! FileType ruby,html,haml,eruby,yaml,sass,cucumber setlocal et sw=2 ts=2 sts=2
" au FileType ruby inoremap { { }<Left><Left>
" " au FileType ruby inoremap <Bar> <Bar><Space><Space><Bar><Left><Left>
" au BufNewFile *.rb 0r /home/rom/.vim/snips/rb
" 
" "|||||||| Abbreviations:
" 
" ab #!b #!/bin/bash
" ab #!r #!/usr/bin/ruby
" ab #!p #!/usr/bin/python3
" ab #e # encoding: utf-8
" 
" ab attr_r attr_reader
" ab attr_w attr_writer
" ab attr_a attr_accessor
" 
" "|||||||| QFix:
" 
" command -bang -nargs=? QFix call QFixToggle(<bang>0)
" function! QFixToggle(forced)
"   if exists("g:qfix_win") && a:forced == 0
"       cclose
"   else
"       copen
"   endif
" endfunction
" augroup QFixToggle
" autocmd!
" autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
" autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win | unlet! g:qfix_win | endif
" augroup END
" 
" "|||||||| vim-instant-markdown:
" " let g:instant_markdown_slow = 1
" 
" "|||||||| vim-markdown:
" 
" " let g:markdown_fenced_languages = ['ruby', 'html', 'javascript', 'css', 'erb=eruby.html', 'bash=sh']
" 
" "|||||||| Autopaste:
" 
" let &t_SI .= "\<Esc>[?2004h"
" let &t_EI .= "\<Esc>[?2004l"
" 
" inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
" 
" function! XTermPasteBegin()
"   set pastetoggle=<Esc>[201~
"   set paste
"   return ""
" endfunction
" 
" "|||||||| Scrolling in vim autocomplete box with jk:
" 
" " inoremap <expr> <A-j> ((pumvisible())?("\<C-n>"):("j"))
" " inoremap <expr> <A-k> ((pumvisible())?("\<C-p>"):("k"))
" 
" "|||||||| RangeMacro (does not work):
" 
" " let g:RangeMacro_Mapping = '<Leader>@'
" 
" "|||||||| YCM:
" 
" " nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
" " let g:ycm_min_num_of_chars_for_completion = 99
" let g:ycm_complete_in_strings = 1
" " let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
" " let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']
" " let g:ycm_key_invoke_completion = '<C-Space>'
" 
" "|||||||||| Netrw settings:
" 
" " let g:netrw_altv = 1
" " let g:netrw_fastbrowse = 2
" " let g:netrw_keepdir = 0
" " let g:netrw_liststyle = 2
" " let g:netrw_retmap = 1
" " let g:netrw_silent = 1
" " let g:netrw_special_syntax= 1
" 
" "|||||||| GVim:
" 
" if has('gui_running')
"   set t_md=
"   set guioptions+=TLlRrbm
"   set guioptions-=TLlRrbm
"   set guicursor+=i-n-v-c:blinkon0
"   set guifont=PragmataProPowerline\ 9
"   map <A-M> :set guioptions-=m<CR>
"   map <A-m> :set guioptions+=m<CR>
"   colorscheme FreshCut
" endif
" 
" "|||||||||| Terminal-specific settings:
" 
" if $COLORTERM == 'Terminal'
"     Bundle 'Lokaltog/vim-powerline'
" endif
" 
" if $COLORTERM == 'rxvt-xpm'
"     Bundle 'godlygeek/csapprox'
"     Bundle 'bling/vim-airline'
"     let g:airline_theme='ubaryd'
"     colorscheme zazen
" endif
" 
" if $COLORTERM == 'termite'
"     syntax enable
"     set background=dark
"     colorscheme solarized
"     Bundle 'bling/vim-airline'
"     let g:airline_theme='solarized'
" endif
" 
" if $COLORTERM == 'rox'
"     Bundle 'bling/vim-airline'
"     colorscheme Github
"     let g:airline_theme='light'
"     hi FoldColumn ctermbg=015
" endif
" 
" " if $COLORTERM == 'sakura'
" " syntax enable
" " set background=dark
" " colorscheme solarized
" " Bundle 'bling/vim-airline'
" " let g:airline_theme='solarized'
" " endif
" 
" if $COLORTERM == 'tmux'
"     Bundle 'bling/vim-airline'
"     let g:airline_theme='luna'
"     let g:airline_powerline_fonts=0
"     let g:airline_left_sep = ''
"     let g:airline_left_alt_sep = ''
"     let g:airline_right_sep = ''
"     let g:airline_right_alt_sep = ''
"     let g:airline_branch_prefix = '⭠'
"     let g:airline_readonly_symbol = '⭤'
"     let g:airline_linecolumn_prefix = '⭡'
"     colorscheme 16color
" endif
" 
" " if &t_Co >= 256
" " colorscheme test
" " elseif &t_Co < 256
" " colorscheme af
" " endif
" 
" "|||||||| go to the last cursor position in the file:
" 
" autocmd BufReadPost *
"     \ if line("'\"") > 0 && line("'\"") <= line("$") |
"     \ exe "normal g`\"" |
"     \ endif
" 
" let perl_extended_vars = 1
" let perl_sync_dist = 250
" let ruby_operators = 1
" " let ruby_fold = 1
" " let ruby_space_errors = 1
" 
" "|||||||| Sudo write
" 
" noremap <leader>W :w !sudo tee %<CR>
" 
" "|||||||| Hard to type things
" 
" " imap >>>> →
" " imap <<<< ←
" " imap ^^^^ ↑
" " imap VVVV ↓
" " imap aaaa λ
" 
" "||||||| Showing cross cursor:
" 
" " hi CursorColumn term=NONE cterm=NONE ctermbg=240
" " hi CursorLine term=NONE cterm=NONE ctermbg=240
" " imap <F8><F9> <ESC>:set cuc! cul!<CR><INSERT><RIGHT>
" " nmap <F8><F9> <ESC>:set cuc! cul!<CR>
" 
" "||||||| Delete spaces
" 
" " imap <LocalLeader>ds <ESC>:%s/\s\+$//e<CR>
" " nmap <LocalLeader>ds <ESC>:%s/\s\+$//e<CR>
" 
" let g:startify_custom_header = [
"             \' ',
"             \' _| _| _| ',
"             \' _| _| _|_|_| _|_| ',
"             \' _| _| _| _| _| _| ',
"             \' _| _| _| _| _| ',
"             \' ',
"             \]
" 
" " """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " " SWITCH BETWEEN TEST AND PRODUCTION CODE
" " """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " function! OpenTestAlternate()
" " let new_file = AlternateForCurrentFile()
" " exec ':e ' . new_file
" " endfunction
" " function! AlternateForCurrentFile()
" " let current_file = expand("%")
" " let new_file = current_file
" " let in_spec = match(current_file, '^spec/') != -1
" " let going_to_spec = !in_spec
" " let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1 || match(current_file, '\<services\>') != -1 || match(current_file, '\<helpers\>') != -1
" " if going_to_spec
" " if in_app
" " let new_file = substitute(new_file, '^app/', '', '')
" " end
" " let new_file = substitute(new_file, '\.rb$', '_spec.rb', '')
" " let new_file = 'spec/' . new_file
" " else
" " let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
" " let new_file = substitute(new_file, '^spec/', '', '')
" " if in_app
" " let new_file = 'app/' . new_file
" " end
" " endif
" " return new_file
" " endfunction
" "
" " """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " " RUNNING TESTS
" " """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " function! RunTestFile(...)
" " if a:0
" " let command_suffix = a:1
" " else
" " let command_suffix = ""
" " endif
" "
" " " Run the tests for the previously-marked file.
" " let in_test_file = match(expand("%"), '\(.feature\|_spec.rb\)$') != -1
" " if in_test_file
" " call SetTestFile()
" " elseif !exists("t:grb_test_file")
" " return
" " end
" " call RunTests(t:grb_test_file . command_suffix)
" " endfunction
" "
" " function! RunNearestTest()
" " let spec_line_number = line('.')
" " call RunTestFile(":" . spec_line_number)
" " endfunction
" "
" " function! SetTestFile()
" " " Set the spec file that tests will be run for.
" " let t:grb_test_file=@%
" " endfunction
" "
" " function! RunTests(filename)
" " " Write the file and run tests for the given filename
" " :w
" " :silent !echo;echo;echo;echo;echo;echo;echo;echo;echo;echo
" " if match(a:filename, '\.feature$') != -1
" " exec ":!script/features " . a:filename
" " else
" " if filereadable("script/test")
" " exec ":!script/test " . a:filename
" " elseif filereadable("Gemfile")
" " exec ":!zeus rspec --color --format=nested --order default " . a:filename
" " else
" " exec ":!spec --color --format=nested " . a:filename
" " end
" " endfunction
" "
" " """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " " RAILS STUFFS
" " """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " function! ShowRoutes()
" " " Requires 'scratch' plugin
" " :topleft 100 :split __Routes__
" " " Make sure Vim doesn't write __Routes__ as a file
" " :set buftype=nofile
" " " Delete everything
" " :normal 1GdG
" " " Put routes output in buffer
" " :0r! rake -s routes
" " " Size window to number of lines (1 plus rake output length)
" " :exec ":normal " . line("$") . _ "
" " " Move cursor to bottom
" " :normal 1GG
" " " Delete empty trailing line
" " :normal dd
" " endfunction
"
 " " let g:airline#extensions#tabline#enabled = 1 " Enable airline tabs
 " " let g:airline#extensions#tabline#fnamemod = ':t' " :help filename-modifiers
 " let g:airline_powerline_fonts = 1 " Use airline fonts
 " let g:airline#extensions#hunks#enabled = 1
 " let g:airline#extensions#branch#enabled = 1
 " let g:airline#extensions#whitespace#checks = []

 " " are we in a VC?                                                            
 " if $TERM == 'linux'
 "   let &t_Co = 8
 "   "color peachpuff
 "   set nolist
 "   set colorcolumn+=81
 " endif
 "
 " setup for the visual environment

" Popup menu hightLight Group
" highlight Pmenu ctermbg=13 guibg=LightGray
" highlight PmenuSel ctermbg=7 guibg=DarkBlue guifg=White
" highlight PmenuSbar ctermbg=7 guibg=DarkGray
" highlight PmenuThumb guibg=Black
" highlight ShowMarksHLl gui=bold guibg=LightBlue guifg=Blue
" highlight ShowMarksHLu gui=bold guibg=LightRed guifg=DarkRed
" highlight ShowMarksHLo gui=bold guibg=LightYellow guifg=DarkYellow
" highlight ShowMarksHLm gui=bold guibg=LightGreen guifg=DarkGreen
There 

" " RagTag 
" imap <M-O> <Esc>o
" let g:ragtag_global_maps = 1
" imap <C-Space> <C-X><Space>
" imap <C-CR> <C-X><CR>
" 
" Eclipse style commenting (<C-/>).
"nnoremap <M-/> :call NERDComment(0, "invert")<CR>
"xnoremap <M-/> :call NERDComment(1, "invert")<CR>gv

" Use the arrows to something usefull
" map <right> :bn<cr>
" map <left> :bp<cr>
" map <leader>u :TMiniBufExplorer<cr>
""map M-<right> :bn<cr>
""map M-<left> :bp<cr>

" Work with vim-projects
" nmap <silent> <C-c>p <Plug>ToggleProject
" " work with taglist
" imap <C-c>t <Esc>:TlistToggle<CR>:TlistUpdate<CR>
" nmap <C-c>t :TlistToggle<CR>:TlistUpdate<CR>
" map <C-c>add :execute ProjectAdd()<CR>
" nmap <S-k> :exe ":Man " expand("<cword>")<CR>
"
" "----------------------------------------------------------------------------------------------------------------------------
" au Colorscheme hi CursorLineNr gui=none
" au Colorscheme highlight iCursor guifg=white   guibg=#005E6D
" au Colorscheme hi iCursorLine    guibg=#121212 gui=none
" au Colorscheme hi Error          cterm=NONE guibg=NONE
" au Colorscheme hi Pmenu  term=reverse ctermfg=0 ctermbg=7 gui=reverse guifg=#000000 guibg=#F8F8F8  
" au Colorscheme hi PmenuSbar  term=reverse ctermfg=3 ctermbg=7 guifg=#8A95A7 guibg=#F8F8F8  
" au Colorscheme hi PmenuThumb   term=reverse ctermfg=7 ctermbg=3 guifg=#F8F8F8 guibg=#8A95A7   
" au Colorscheme hi PmenuSel  term=reverse ctermfg=8 ctermbg=0 gui=reverse guifg=#586e75 guibg=#eee8d5
" 
" au GuiEnter hi CursorLineNr gui=none
" au GuiEnter highlight iCursor guifg=white   guibg=#005E6D
" au GuiEnter hi iCursorLine    guibg=#121212 gui=none
" au GuiEnter hi Error          cterm=NONE guibg=NONE
" au GuiEnter hi Pmenu  term=reverse ctermfg=0 ctermbg=7 gui=reverse guifg=#000000 guibg=#F8F8F8  
" au GuiEnter hi PmenuSbar  term=reverse ctermfg=3 ctermbg=7 guifg=#8A95A7 guibg=#F8F8F8  
" au GuiEnter hi PmenuThumb   term=reverse ctermfg=7 ctermbg=3 guifg=#F8F8F8 guibg=#8A95A7   
" au GuiEnter hi PmenuSel  term=reverse ctermfg=8 ctermbg=0 gui=reverse guifg=#586e75 guibg=#eee8d5
" " Automatically open and close the popup menu / preview window
" au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
" "----------------------------------------------------------------------------------------------------------------------------
"
" Configure mapping timeout in milliseconds (default 1000).
" Controls how long Vim waits for partially complete mapping
" before timing out and using prefix directly.
set timeout timeoutlen=3000

" Configure keycode timeout in milliseconds (default -1).
" Controls how long Vim waits for partially complete
" keycodes (such as <ESC>OH which is the <Home> key).
" If negative, uses 'timeoutlen'.
" Note that in insert mode, there is a special-case hack in the Vim
" source that checks for <Esc> and if there are no additional characters
" immediately waiting, Vim pretends to leave insert mode immediately.
" But Vim is still waiting for 'ttimeoutlen' milliseconds for keycodes,
" so if in insert mode you press <Esc>OH in console Vim (on Linux) within
" 'ttimeoutlen' milliseconds, you'll get <Home> instead of opening a new
" line above and inserting "H".
" Note: 120 words per minute ==> 10 character per second ==> 100 ms between,
" and 50 ms ==> 240 words per minute.
" Also, Tim Pope's vim-sensible plugin uses 50 ms as a reasonable value.
set ttimeout ttimeoutlen=40
" if has('gui_gtk') && has('gui_running')
" let s:border = synIDattr(synIDtrans(hlID('Normal')), 'bg', 'gui')
" exe 'silent !echo ''style "vimfix" { bg[NORMAL] = "' . escape(s:border, '#') . '" }'''.
"             \' > ~/.gtkrc-2.0'
" exe 'silent !echo ''widget "vim-main-window.*GtkForm" style "vimfix"'''.
"             \' >> ~/.gtkrc-2.0'
" endif
" if exists('$TMUX')
"   function! TmuxOrSplitSwitch(wincmd, tmuxdir)
"     let previous_winnr = winnr()
"     execute "wincmd " . a:wincmd
"     if previous_winnr == winnr()
"       " The sleep and & gives time to get back to vim so tmux's focus tracking
"       " can kick in and send us our ^[[O
"       execute "silent !sh -c 'sleep 0.01; tmux select-pane -" . a:tmuxdir . "' &"
"       redraw!
"     endif
"   endfunction
"   let previous_title = substitute(system("tmux display-message -p '#{pane_title}'"), '\n', '', '')
"   let &t_ti = "\<Esc>]2;vim\<Esc>\\" . &t_ti
"   let &t_te = "\<Esc>]2;". previous_title . "\<Esc>\\" . &t_te
"   nnoremap <silent> <C-h> :call TmuxOrSplitSwitch('h', 'L')<CR>
"   nnoremap <silent> <C-j> :call TmuxOrSplitSwitch('j', 'D')<CR>
"   nnoremap <silent> <C-k> :call TmuxOrSplitSwitch('k', 'U')<CR>
"   nnoremap <silent> <C-l> :call TmuxOrSplitSwitch('l', 'R')<CR>
" else
"   map <C-h> <C-w>h
"   map <C-j> <C-w>j
"   map <C-k> <C-w>k
"   map <C-l> <C-w>l
" endif
"
" Insert Mode <C-k> -- kill line from current to eol "{{{
" func! s:kill_line()
"   let curcol = col('.')
"   if curcol == col('$')
"     join!
"     call cursor(line('.'), curcol)
"   else
"     normal! D
"   endif
" endfunc
" inoremap <C-k> <C-o>:<C-u>call <SID>kill_line()<CR>
" cnoremap <C-k> <C-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>
" "}}}
"
" " Normal Mode <C-k> -- kill buffer, not close window {{{
" " http://nanasi.jp/articles/vim/kwbd_vim.html
" :com! Kwbd let kwbd_bn= bufnr("%")|enew|exe "bdel ".kwbd_bn|unlet kwbd_bn
" nnoremap <C-k> :Kwbd<CR>
" map <silent> <Leader>L :IndentLinesToggle<CR>
" let g:indentLine_enabled = 0
" let g:indentLine_char = '┊'
" let g:indentLine_color_term = 239
"
" map <silent> <Leader>L :IndentLinesToggle<CR>
" let g:indentLine_enabled = 0
" let g:indentLine_char = '┊'
" let g:indentLine_color_term = 239
" "}}}"
" " Fugitive {
"     nnoremap <silent> <leader>gs :Gstatus<CR>
"     nnoremap <silent> <leader>gd :Gdiff<CR>
"     nnoremap <silent> <leader>gc :Gcommit<CR>
"     nnoremap <silent> <leader>gb :Gblame<CR>
"     nnoremap <silent> <leader>gl :Glog<CR>
"     nnoremap <silent> <leader>gp :Git push<CR>
"     nnoremap <silent> <leader>gr :Gread<CR>:GitGutter<CR>
"     nnoremap <silent> <leader>gw :Gwrite<CR>:GitGutter<CR>
"     nnoremap <silent> <leader>ge :Gedit<CR>
"     nnoremap <silent> <leader>gg :GitGutterToggle<CR>
" "}
"---------------------------------------------------------------
" => Cope
"---------------------------------------------------------------
" Do :help cope if you are unsure what cope is. It's super useful!
" map <leader>cc :botright cope<cr>
" map <leader>n :cn<cr>
" map <leader>p :cp<cr>

" fix meta-keys which generate <Esc>a .. <Esc>z
" let c='a'
" while c <= 'z'
"   exec "set <M-".toupper(c).">=\e".c
"   exec "imap \e".c." <M-".toupper(c).">"
"   let c = nr2char(1+char2nr(c))
" endw
" for i in range(65,90) + range(97,122)
"   let c = nr2char(i)
"   exec "map \e".c." <M-".c.">"
"   exec "map! \e".c." <M-".c.">"
" endfor
" " Map key to toggle opt
" function MapToggle(key, opt)
"   let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
"   exec 'nnoremap '.a:key.' '.cmd
"   exec 'inoremap '.a:key." \<C-O>".cmd
" endfunction
" command -nargs=+ MapToggle call MapToggle(<f-args>)
" let g:unite_source_menu_menus.fenc = {
"       \     'description' : 'Change file fenc option.',
"       \ }
" let g:unite_source_menu_menus.fenc.command_candidates = [
"       \       ['utf8',      'set fenc=utf8'],
"       \       ['iso2022jp', 'set fenc=Iso2022jp'],
"       \       ['cp932',     'set fenc=Cp932'],
"       \       ['euc',       'set fenc=Euc'],
"       \       ['utf16',     'set fenc=Utf16'],
"       \       ['utf16-be',  'set fenc=Utf16be'],
"       \       ['jis',       'set fenc=Jis'],
"       \       ['sjis',      'set fenc=Sjis'],
"       \       ['unicode',   'set fenc=Unicode'],
"       \     ]
"
" "
