" We reset the vimrc augroup. Autocommands are added to this group throughout
" the file
" Didn't work for a while %(
" autocmd InsertEnter * :setlocal nohlsearch

augroup vimrc
    autocmd!
augroup END

  
augroup cline
	au!
	au WinLeave * set nocursorline
	au WinEnter * set cursorline

	au InsertEnter * set nocursorline
	au InsertLeave * set cursorline

	au VimEnter * set cursorline
augroup END

" OmniComplete {
if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
        \if &omnifunc == "" |
        \setlocal omnifunc=syntaxcomplete#Complete |
        \endif
endif


" forced powerline/airline redraw
" " I think there is bug with airline
" au FocusGained * :redraw!

" autocmd VimEnter * echo "Welcome back Sergey :)"
" autocmd VimLeave * echo "Cya in Hell."

" Return to last edit position (You want this!) *N*
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

"--------------------------------------------------------------------------------------------
" --- [ Autocmds ] --------------------------------------------------------------------------
"--------------------------------------------------------------------------------------------
autocmd BufNewFile,BufRead  *             if getline(1) =~ '#!\s*/bin/dash' | setf sh | endif
autocmd BufRead,BufNewFile  *.viki        setlocal ft=viki
autocmd BufNewFile,BufRead  *.t2t         setlocal ft=txt2tags
autocmd Filetype            txt2tags      source   $HOME/.vim/syntax/txt2tags.vim
autocmd FileType            make          setlocal noexpandtab
autocmd FileType            javascript    setlocal noautoindent nosmartindent
" autocmd BufWritePre         *.py          mark z | %s/ *$//e | 'z
autocmd BufNewFile,BufRead  *.t2t         setlocal wrap
autocmd BufNewFile,BufRead  *.t2t         setlocal lbr
autocmd BufRead,BufNewFile *.json         setlocal filetype=json foldmethod=syntax
autocmd BufNewFile,BufRead .pentadactylrc setlocal filetype=pentadactyl

autocmd FileType git set nofoldenable

autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk "%" - |fmt -csw78
autocmd BufReadPost *.doc silent %!antiword "%"
autocmd BufReadPost *.odt silent %!odt2txt "%"
"Sourced from vim tip: http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text
" Enable omni completion.
autocmd FileType c,cc,h,s      imap <C-c>m <Esc>:make!<CR>a | nmap <C-c>m :make!<CR>
autocmd FileType tex           map  <C-c>m :!pdflatex -shell-escape "%"<CR> | :NoMatchParen | setlocal nocursorline | setlocal updatetime=1

au FileType mail setl spell fo=wantq1 smc=0

" Omni-completion
autocmd FileType css           setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript    setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml           setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType css           setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType ruby          setlocal omnifunc=rubycomplete#Complete
autocmd FileType haskell       setlocal omnifunc=necoghc#omnifunc
" markdown filetype file
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown
autocmd FileType markdown NeoBundleSource vim-markdown
autocmd FileType markdown NeoBundleSource vim-markdown-extra-preview

au BufRead,BufNewFile rc.lua setlocal foldmethod=marker
au FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2

function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction
au FileType javascript setl fen
au BufRead,BufNewFile *.textile setf textile
augroup filetypedetect
    autocmd BufReadPost,BufNewFile .sawmillrc,.sawfishrc,*.jl setfiletype lisp
    autocmd BufReadPost,BufNewFile *.tmpl                     setfiletype html
    autocmd BufReadPost,BufNewFile *.wiki                     setfiletype Wikipedia
    autocmd BufReadPost,BufNewFile *wikipedia.org.*           setfiletype Wikipedia
    autocmd BufReadPost,BufNewFile hpedia.fc.hp.com.*         setfiletype Wikipedia
    autocmd BufReadPost,BufNewFile hpedia.hp.com.*            setfiletype Wikipedia
    autocmd BufReadPost,BufNewFile griffis1.net.*             setfiletype Wikipedia
augroup END
"=================================== XML ===================================
function! LoadTypeXML()
  set shiftwidth=2
  runtime scripts/closetag.vim
  inoremap <C-/> <C-R>=GetCloseTag()<CR>
  syntax cluster xmlRegionHook add=SpellErrors,SpellCorrected
endfunction

augroup ag_xml
  autocmd!
  autocmd FileType html,xml,xslt,htmldjango call LoadTypeXML()
augroup END

autocmd FileType c,cpp,java,go,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> call StripTrailingWhitespace()
autocmd FileType cpp let b:delimitMate_matchpairs = "(:),[:],{:}" 
" autocmd FileType cpp let b:delimitMate_matchpairs = "(:),[:],{:}"  | hi Function guifg=#85A2CC
" This handles c++ files with the ".cc" extension.
augroup ccfiles
  au!
  au BufEnter *.cc let b:fswitchdst  = 'h,hxx'
  au BufEnter *.cc let b:fswitchlocs = './,reg:/src/include/,reg:|src|include/**|,../include'
  au BufEnter *.h  let b:fswitchdst  = 'cpp,cc,c'
  au BufEnter *.h  let b:fswitchlocs = './,reg:/include/src/,reg:/include.*/src/,../src'
augroup END

autocmd FileType go                         autocmd BufWritePre <buffer> Fmt
autocmd FileType haskell                    setlocal expandtab shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead *.html.twig      set filetype=html.twig
augroup json_autocmd
  autocmd FileType json set foldmethod=syntax
augroup END

" hi Search    term=reverse ctermfg=0 ctermbg=11 guifg=#002B36 guibg=#899ca1
" hi IncSearch term=reverse cterm=reverse gui=reverse guifg=#8008AAD guibg=#002B36
" hi DiffDelete     xxx term=bold ctermfg=12 ctermbg=6 gui=bold guifg=Blue guibg=DarkCyan
" hi DiffText       xxx term=reverse cterm=bold ctermbg=9 gui=bold guibg=Red
" For solarized
" highlight SpellBad term=underline gui=undercurl guisp=Orange

" http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
" Restore cursor to file position in previous editing session
" To disable this, add the following to your .vimrc.before.local file:
"   let g:spf13_no_restore_cursor = 1
function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END


" if !executable("ghcmod")
"     autocmd BufWritePost *.hs GhcModCheckAndLintAsync
" endif

" Strip whitespace {
function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
" }

" Execution permissions by default to shebang (#!) files {{{

" augroup shebang_chmod
"   autocmd!
"   autocmd BufNewFile  * let b:brand_new_file = 1
"   autocmd BufWritePost * unlet! b:brand_new_file
"   autocmd BufWritePre *
"         \ if exists('b:brand_new_file') |
"         \   if getline(1) =~ '^#!' |
"         \     let b:chmod_post = '+x' |
"         \   endif |
"         \ endif
"   autocmd BufWritePost,FileWritePost *
"         \ if exists('b:chmod_post') && executable('chmod') |
"         \   silent! execute '!chmod '.b:chmod_post.' "<afile>"' |
"         \   unlet b:chmod_post |
"         \ endif
" augroup END

" }}}
function! GHDashboard (...)
  if &filetype == 'github-dashboard'
    " first variable is the statusline builder
    let builder = a:1

    call builder.add_section('airline_a', 'GitHub ')
    call builder.add_section('airline_b',
                \ ' %{get(split(get(split(github_dashboard#statusline(), " "),
                \ 1, ""), ":"), 0, "")} ')
    call builder.add_section('airline_c',
                \ ' %{get(split(get(split(github_dashboard#statusline(), " "),
                \ 2, ""), "]"), 0, "")} ')

    " tell the core to use the contents of the builder
    return 1
  endif
endfunction

autocmd FileType github-dashboard call airline#add_statusline_func('GHDashboard')

" augroup vimrcEx
"   autocmd!
"
"   " For all text files set 'textwidth' to 78 characters.
"   autocmd FileType text setlocal textwidth=78
"
"   " When editing a file, always jump to the last known cursor position.
"   " Don't do it for commit messages, when the position is invalid, or when
"   " inside an event handler (happens when dropping a file on gvim).
"   autocmd BufReadPost *
"     \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
"     \   exe "normal g`\"" |
"     \ endif
"
"   " Set syntax highlighting for specific file types
"   autocmd BufRead,BufNewFile Appraisals set filetype=ruby
"   autocmd BufRead,BufNewFile *.md set filetype=markdown
"
"   " Enable spellchecking for Markdown
"   autocmd FileType markdown setlocal spell
"
"   " Automatically wrap at 80 characters for Markdown
"   autocmd BufRead,BufNewFile *.md setlocal textwidth=80
" augroup END

" UltiSnips is missing a setf trigger for snippets on BufEnter
autocmd vimrc BufEnter *.snippets setf snippets

" In UltiSnips snippet files, we want actual tabs instead of spaces for indents.
" US will use those tabs and convert them to spaces if expandtab is set when the
" user wants to insert the snippet.
autocmd vimrc FileType snippets set noexpandtab

" The stupid python filetype plugin overrides our settings!
autocmd vimrc FileType python
      \ set tabstop=2 |
      \ set shiftwidth=2 |
      \ set softtabstop=2 |
      \ setlocal omnifunc=pythoncomplete#Complete |
      \ setlocal foldlevel=1000

" autocmd FileType gitcommit DiffGitCached | wincmd paugroup mkd
"   autocmd BufRead       *.mkd          set ai formatoptions=tcroqn2 comments=n:&gt;
"   au BufRead,BufNewFile *.go           set filetype=go
" augroup END
" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
" au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" cindent is a bit too smart for its own good and triggers in text files when
" you're typing inside parens and then hit enter; it aligns the text with the
" opening paren and we do NOT want this in text files!
autocmd vimrc FileType text,markdown,gitcommit set nocindent

" Turn on spell checking by default for git commit messages
au vimrc FileType gitcommit setlocal spell! spelllang=en_us
autocmd vimrc FileType markdown setlocal spell! spelllang=en_us

let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * hi IndentGuidesOdd  ctermbg=239
autocmd VimEnter,Colorscheme * hi IndentGuidesEven ctermbg=240
