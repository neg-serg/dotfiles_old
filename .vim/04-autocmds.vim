" We reset the vimrc augroup. Autocommands are added to this group throughout
" the file
" Didn't work for a while %(
" autocmd InsertEnter * :setlocal nohlsearch

augroup vimrc
    autocmd!
    au BufRead *.session let g:session = expand('%:p:h') | so % | bd #
    au VimLeave * if exists('g:session') | call Mks(g:session) | endif
augroup end

fun! Mks(path)
    exe "mksession! ".a:path."/".fnamemodify(a:path, ':t').".session"
endfun

" OmniComplete {
if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
        \if &omnifunc == "" |
        \setlocal omnifunc=syntaxcomplete#Complete |
        \endif
endif

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
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,Guardfile,config.ru,*.rake} set ft=ruby
autocmd FileType haskell       setlocal omnifunc=necoghc#omnifunc
" markdown filetype file
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown
" autocmd FileType markdown NeoBundleSource vim-markdown
" autocmd FileType markdown NeoBundleSource vim-markdown-extra-preview

au BufRead,BufNewFile rc.lua setlocal foldmethod=marker
au FileType ruby setlocal tabstop=4 softtabstop=4 shiftwidth=4

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
autocmd FileType c,cpp let b:delimitMate_matchpairs = "(:),[:],{:}" 
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
autocmd FileType haskell                    setlocal expandtab shiftwidth=4 softtabstop=4
autocmd BufNewFile,BufRead *.html.twig      set filetype=html.twig
augroup json_autocmd
  autocmd FileType json set foldmethod=syntax
augroup END

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

if executable('chmod')
    autocmd BufWritePost * call s:add_permission_x()
    function! s:add_permission_x()
        let file = expand('%:p')
        if getline(1) =~# '^#!' && !executable(file)
            silent! call vimproc#system('chmod a+x ' . shellescape(file))
        endif
    endfunction
endif

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

" UltiSnips is missing a setf trigger for snippets on BufEnter
autocmd vimrc BufEnter *.snippets setf snippets

" In UltiSnips snippet files, we want actual tabs instead of spaces for indents.
" US will use those tabs and convert them to spaces if expandtab is set when the
" user wants to insert the snippet.
autocmd vimrc FileType snippets set noexpandtab

" The stupid python filetype plugin overrides our settings!
autocmd vimrc FileType python
      \ set tabstop=4 |
      \ set shiftwidth=4 |
      \ set softtabstop=4 |
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

function! s:jedi_settings()
    nnoremap <buffer><Leader>jr :<C-u>call jedi#rename()<CR>
    nnoremap <buffer><Leader>jg :<C-u>call jedi#goto_assignments()<CR>
    nnoremap <buffer><Leader>jd :<C-u>call jedi#goto_definitions()<CR>
    nnoremap <buffer>K :<C-u>call jedi#show_documentation()<CR>
    nnoremap <buffer><Leader>ju :<C-u>call jedi#usages()<CR>
    nnoremap <buffer><Leader>ji :<C-u>Pyimport<Space>
    setlocal omnifunc=jedi#completions
    command! -nargs=0 JediRename call jedi#rename()
endfunction
autocmd Filetype python call <SID>jedi_settings()
"------------------------------------------------------------------------------------------------------------------
function! s:on_FileType_help_define_mappings()
    if &l:readonly
        nnoremap <buffer>J <C-]>
        nnoremap <buffer>K <C-t>
        nnoremap <buffer><silent><Tab> /\%(\_.\zs<Bar>[^ ]\+<Bar>\ze\_.\<Bar>CTRL-.\<Bar><[^ >]\+>\)<CR>
        nnoremap <buffer>u <C-u>
        nnoremap <buffer>d <C-d>
        nnoremap <buffer>q :<C-u>q<CR>
    endif
endfunction
autocmd Filetype help call s:on_FileType_help_define_mappings()

" git-rebase
autocmd Filetype gitrebase nnoremap <buffer><C-p> :<C-u>Pick<CR>
autocmd Filetype gitrebase nnoremap <buffer><C-s> :<C-u>Squash<CR>
autocmd Filetype gitrebase nnoremap <buffer><C-e> :<C-u>Edit<CR>
autocmd Filetype gitrebase nnoremap <buffer><C-r> :<C-u>Reword<CR>
autocmd Filetype gitrebase nnoremap <buffer><C-f> :<C-u>Fixup<CR>

augroup User chdir
    au!
augroup end

command -complete=dir -nargs=1 Cd call ChdirHook(<q-args>)
function! ChdirHook(dir)
    exec "chdir " . a:dir
    do User chdir
endfunction

