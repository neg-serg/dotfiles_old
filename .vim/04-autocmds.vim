" We reset the vimrc augroup. Autocommands are added to this group throughout
" the file
augroup vimrc
    autocmd!
    au BufRead *.session let g:session = expand('%:p:h') | so % | bd #
    au VimLeave * if exists('g:session') | call Mks(g:session) | endif
    au BufEnter * call MySetupTitleString()
augroup end
au StdinReadPost * set buftype=nofile
au BufReadCmd file:///* exe "bd!|edit ".substitute(expand("<afile>"),"file:/*","","")

fun! Mks(path)
    exe "mksession! ".a:path."/".fnamemodify(a:path, ':t').".session"
endfun

" Return to last edit position (You want this!) *N*
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" --- [ Autocmds ] --------------------------------------------------------------------------
autocmd vimrc BufRead,BufNewFile  *.viki         setlocal ft=viki
autocmd vimrc BufNewFile,BufRead  *.t2t          setlocal ft=txt2tags
autocmd vimrc Filetype            txt2tags       source   $HOME/.vim/syntax/txt2tags.vim
autocmd vimrc FileType            make           setlocal noexpandtab
autocmd vimrc FileType            javascript     setlocal noautoindent nosmartindent
autocmd vimrc FileType            tex            setlocal conceallevel=0
autocmd vimrc FileType            latex          setlocal conceallevel=0
autocmd vimrc FileType            markdown       call MarkdownKeymaps()
autocmd vimrc BufNewFile,BufRead  *.t2t          setlocal wrap lbr
autocmd vimrc BufRead,BufNewFile  *.json         setlocal filetype=json foldmethod=syntax
autocmd vimrc BufNewFile,BufRead  .pentadactylrc setlocal filetype=pentadactyl

autocmd vimrc FileType git set nofoldenable

function! MarkdownKeymaps()
    " format current line as a top-level heading in Markdown (uses `z marker)
    nnoremap <silent><buffer> <Leader>=1 mzyyp:s/^\s*//<Return>Vr===:.+g/^\s*=\+\s*/d<Return>`z

    " format current line as a second-level heading in Markdown (uses `z marker)
    nnoremap <silent><buffer> <Leader>=2 mzyyp:s/^\s*//<Return>Vr-==:.+g/^\s*-\+\s*/d<Return>`z

    " format current line as table/body separator in Markdown (uses `z marker)
    nnoremap <silent><buffer> <Leader>=<Bar> mzyyp:s/^\s*//
        \ <Bar>s/[^<Bar>]/-/g
        \ <Bar>s/-<Bar>/ <Bar>/g
        \ <Bar>s/<Bar>-/<Bar> /g<Return>
        \ ==:.+g/^\s*[<Bar>-]\+\s*/d<Return>`z

    " format selected Markdown indented code block into a fenced code block
    vnoremap <silent><buffer> <Leader>=` 2<']o<Esc>3i`<Esc>yy<C-o>PA
endfunction

autocmd vimrc BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
autocmd vimrc BufReadPost *.pdf silent %!pdftotext -nopgbrk "%" - |fmt -csw78

autocmd vimrc BufReadPre  *.doc set ro | silent %!antiword "%"
autocmd vimrc BufReadPost *.odt silent %!odt2txt "%"

autocmd vimrc FileType mail setl spell fo=wantq1 smc=0

autocmd vimrc BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,Procfile,Guardfile,config.ru,*.rake} set ft=ruby
autocmd vimrc FileType haskell setlocal omnifunc=necoghc#omnifunc
autocmd vimrc BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown

autocmd vimrc BufRead,BufNewFile rc.lua setlocal foldmethod=marker
autocmd vimrc FileType ruby setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd vimrc FileType ruby setlocal re=1 nornu

autocmd vimrc FileType javascript setl fen
autocmd vimrc BufRead,BufNewFile *.textile setf textile

augroup filetypedetect
    autocmd BufReadPost,BufNewFile .sawmillrc,.sawfishrc,*.jl setfiletype lisp
    autocmd BufReadPost,BufNewFile *.tmpl                     setfiletype html
    autocmd BufReadPost,BufNewFile *.wiki                     setfiletype Wikipedia
    autocmd BufReadPost,BufNewFile *wikipedia.org.*           setfiletype Wikipedia
    autocmd BufReadPost,BufNewFile hpedia.fc.hp.com.*         setfiletype Wikipedia
    autocmd BufReadPost,BufNewFile hpedia.hp.com.*            setfiletype Wikipedia
    autocmd BufReadPost,BufNewFile griffis1.net.*             setfiletype Wikipedia
augroup END

autocmd vimrc FileType c,cpp,java,go,php,javascript,python,twig,xml,yml,rust,sql autocmd BufWritePre <buffer> call StripTrailingWhitespace()
autocmd vimrc FileType c,cpp,bash,zsh,sh let b:delimitMate_matchpairs = "(:),[:],{:}" | hi Function guifg=#85A2CC | let b:indentLine_enabled = 1

" This handles c++ files with the ".cc" extension.
augroup ccfiles
  autocmd!
  autocmd BufEnter *.cc let b:fswitchdst  = 'h,hxx'
  autocmd BufEnter *.cc let b:fswitchlocs = './,reg:/src/include/,reg:|src|include/**|,../include'
  autocmd BufEnter *.h  let b:fswitchdst  = 'cpp,cc,c'
  autocmd BufEnter *.h  let b:fswitchlocs = './,reg:/include/src/,reg:/include.*/src/,../src'
augroup END

autocmd vimrc FileType go                     autocmd BufWritePre <buffer> Fmt
autocmd vimrc FileType haskell,rust           setlocal expandtab shiftwidth=4 softtabstop=4 nospell
autocmd vimrc BufNewFile,BufRead *.html.twig  set filetype=html.twig
augroup json_autocmd
  autocmd FileType json set foldmethod=syntax
augroup END

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

autocmd vimrc FileType github-dashboard call airline#add_statusline_func('GHDashboard')

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
      \ setlocal completeopt-=preview |
      \ setlocal foldlevel=1000 |
      \ map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" cindent is a bit too smart for its own good and triggers in text files when
" you're typing inside parens and then hit enter; it aligns the text with the
" opening paren and we do NOT want this in text files!
autocmd vimrc FileType text,markdown,gitcommit set nocindent

" Turn on spell checking by default for git commit messages
autocmd vimrc FileType gitcommit setlocal spell! spelllang=en_us
autocmd vimrc FileType markdown setlocal spell! spelllang=en_us tw=77 fo+=t

let g:indent_guides_auto_colors = 0
autocmd vimrc VimEnter,Colorscheme * hi IndentGuidesOdd  ctermbg=239
autocmd vimrc VimEnter,Colorscheme * hi IndentGuidesEven ctermbg=240

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
autocmd vimrc Filetype help call s:on_FileType_help_define_mappings()

" git-rebase
autocmd vimrc Filetype gitrebase nnoremap <buffer><C-p> :<C-u>Pick<CR>
autocmd vimrc Filetype gitrebase nnoremap <buffer><C-s> :<C-u>Squash<CR>
autocmd vimrc Filetype gitrebase nnoremap <buffer><C-e> :<C-u>Edit<CR>
autocmd vimrc Filetype gitrebase nnoremap <buffer><C-r> :<C-u>Reword<CR>
autocmd vimrc Filetype gitrebase nnoremap <buffer><C-f> :<C-u>Fixup<CR>

autocmd vimrc FileType slim                                set commentstring=/\ %s
autocmd vimrc FileType xdefaults                           set commentstring=!%s
autocmd vimrc FileType gtkrc,nginx,inittab,tmux,sshdconfig set commentstring=#%s

augroup modechange_settings
  autocmd!

  " Clear search context when entering insert mode, which implicitly stops the
  " highlighting of whatever was searched for with hlsearch on. It should also
  " not be persisted between sessions.
  autocmd InsertEnter * let @/ = ''
  autocmd BufReadPre,FileReadPre * let @/ = ''

  autocmd InsertLeave * setlocal nopaste
augroup END

if has('autocmd')
    fun! MyAutoScrollOff()
        if exists('g:no_auto_scrolloff')
            return
        endif
        if &ft == 'help'
            let scrolloff = 999
        elseif &buftype != ""
            " Especially with quickfix (mouse jumping, more narrow).
            let scrolloff = 0
        elseif &diff
            let scrolloff = 10
        else
            let scrolloff = 3
        endif
        if &scrolloff != scrolloff
            let &scrolloff = scrolloff
        endif
    endfun
    augroup set_scrolloff
        au!
        au BufEnter,WinEnter * call MyAutoScrollOff()
        if exists('#TermOpen')  " neovim
            au TermOpen * set sidescrolloff=0 scrolloff=0
        endif
    augroup END
endif

" enter will work in command edit mode as intended, since by default it's
" mapped to :nohl
autocmd vimrc CmdwinEnter * noremap <buffer><CR> <CR>
