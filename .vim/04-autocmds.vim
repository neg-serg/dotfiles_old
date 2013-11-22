" experimental
"   " OmniComplete {
if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
        \if &omnifunc == "" |
        \setlocal omnifunc=syntaxcomplete#Complete |
        \endif
endif

"forced powerline redraw
" au FocusGained * :redraw!

" autocmd VimEnter * echo "Welcome back Sergey :)"
" autocmd VimLeave * echo "Cya in Hell."

" Return to last edit position (You want this!) *N*
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

"---------------------
" --- [ Autocmds ] ---
"---------------------
autocmd BufNewFile,BufRead  *             if getline(1) =~ '#!\s*/bin/dash' | setf sh | endif
autocmd BufRead,BufNewFile  *.viki        setlocal ft=viki
autocmd BufNewFile,BufRead  *.t2t         setlocal ft=txt2tags
autocmd Filetype            txt2tags      source   $HOME/.vim/syntax/txt2tags.vim
autocmd FileType            make          setlocal noexpandtab
autocmd FileType            javascript    setlocal noautoindent nosmartindent
autocmd BufWritePre         *.py          mark z | %s/ *$//e | 'z
autocmd BufNewFile,BufRead  *.t2t         setlocal wrap
autocmd BufNewFile,BufRead  *.t2t         setlocal lbr
autocmd BufRead,BufNewFile *.json         setlocal filetype=json foldmethod=syntax 
autocmd BufNewFile,BufRead .pentadactylrc setlocal filetype=vim

augroup mkd
  autocmd BufRead       *.mkd          set ai formatoptions=tcroqn2 comments=n:&gt;
  au BufRead,BufNewFile *.go           set filetype=go
augroup END

autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
autocmd BufReadPost *.pdf silent %!pdftotext -nopgbrk "%" - |fmt -csw78
autocmd BufReadPost *.doc silent %!antiword "%"
autocmd BufReadPost *.odt silent %!odt2txt "%"
"Sourced from vim tip: http://vim.wikia.com/wiki/Keep_folds_closed_while_inserting_text
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
"autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif
" Enable omni completion.
autocmd FileType c,cc,h,s      imap <C-c>m <Esc>:make!<CR>a
autocmd FileType c,cc,h,s      nmap <C-c>m :make!<CR>
autocmd FileType tex           map  <C-c>m :!pdflatex -shell-escape "%"<CR>

" Omni-completion
autocmd FileType css           setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript    setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python        setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml           setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType css           setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType ruby          setlocal omnifunc=rubycomplete#Complete
autocmd FileType haskell       setlocal omnifunc=necoghc#omnifunc

autocmd BufWritePost *.rb call Compile()
function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction
au FileType javascript call JavaScriptFold()
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
autocmd FileType go                                               autocmd BufWritePre <buffer> Fmt
autocmd FileType haskell                                          setlocal expandtab shiftwidth=2 softtabstop=2
autocmd BufNewFile,BufRead *.html.twig                            set filetype=html.twig

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


" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

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
