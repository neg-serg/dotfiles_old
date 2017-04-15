 " ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ misc plugins settings                                                             │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:gitgutter_realtime       = 0          " github.com/airblade/vim-gitgutter/issues/106
let g:EclimCompletionMethod    = 'omnifunc' "To provide ycm autocompletion
let g:livepreview_previewer    = 'zathura'
let g:eregex_default_enable    = 0
let g:mta_use_matchparen_group = 0
let g:colorizer_startup        = 0
let g:monster#completion#rcodetools#backend = "async_rct_complete"
let g:livepreview_previewer = 'zathura'
if has("nvim")
    let g:deoplete#enable_at_startup = 1 " Use deoplete.
endif
if has("python3")
    let g:powerline_pycmd = "py3"
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - kana/vim-arpeggio.git                                                    │ 
" │ https://github.com/kana/vim-arpeggio.git                                          │ 
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('vim-arpeggio')
    call arpeggio#map('i', '', 0, 'jk', '<ESC>l')
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - vim-airline/vim-airline                                                  │ 
" │ https://github.com/vim-airline/vim-airline                                        │ 
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('vim-airline')
    let g:airline_theme='one'
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols_branch = ''
    let g:airline_symbols_readonly = ''
    let g:airline_symbols_linenr = ''
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - lotabout/skim                                                            │ 
" │ https://github.com/lotabout/skim                                                  │ 
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('skim.vim')
    let $SKIM_DEFAULT_OPTS = $SKIM_DEFAULT_OPTS . " " . "-t index"
    nnoremap <silent> <Leader>. :call skim#run({
                \ 'source': 'sed "1d" $HOME/.cache/neomru/file',
                \ 'options': '--multi 15%,0',
                \ 'down': '20%',
                \ 'sink': 'e '
                \ })<CR>
    nnoremap qe :Files %:p:h<CR>
    nnoremap qE :Files<CR>
    nnoremap ed :Buffers<CR>
    if !dein#tap('lusty') && has("nvim")
        nnoremap <leader>l :Files %:p:h<CR>
    endif
    " Insert mode completion
    imap <c-x><c-f> <plug>(skim-complete-path)
    imap <c-x><c-l> <plug>(skim-complete-line)

    " Default skim layout
    " - down / up / left / right
    " - window (nvim only)
    let g:skim_layout = { 'down': '~20%' }
else
    " ┌───────────────────────────────────────────────────────────────────────────────────┐
    " │ plugin - junegunn/fzf.vim                                                         │ 
    " │ https://github.com/junegunn/fzf.vim                                               │ 
    " └───────────────────────────────────────────────────────────────────────────────────┘
    if dein#tap('fzf.vim')
        if !has("nvim")
            let $FZF_DEFAULT_OPTS = $FZF_DEFAULT_OPTS . " " . " --color=16"
        else
            let $FZF_DEFAULT_OPTS = $FZF_DEFAULT_OPTS . " " . " --color=16"
        endif
        if !dein#tap('lusty') && !dein#tap('lycosaexplorer') && has("nvim")
            nnoremap <leader>l :Files %:p:h<CR>
        endif

        " Taken from :
        " [https://github.com/aliev/vim/blob/master/vimrc]
        if executable('ag')
            " Silver searcher instead of grep
            set grepprg=ag\ --vimgrep
            set grepformat=%f:%l:%c%m

            " If you're running fzf in a large git repository, git ls-tree can boost up
            " the speed of the traversal.
            if isdirectory('.git') && executable('git')
                let $FZF_DEFAULT_COMMAND='
                            \ (git ls-tree -r --name-only HEAD ||
                            \ find . -path "*/\.*" -prune -o -type f -print -o -type l -print |
                            \ sed s/^..//) 2> /dev/null'
            else
                let $FZF_DEFAULT_COMMAND='ag -g ""'
            endif
        endif

        nnoremap qe :Files %:p:h<CR>
        nnoremap qE :Files<CR>
        nnoremap ed :Buffers<CR>
        " This is the default extra key bindings
        let g:fzf_action = { 'ctrl-x': 'split', 'ctrl-v': 'vsplit' }

        " Default fzf layout
        " - down / up / left / right
        " - window (nvim only)
        let g:fzf_layout = { 'down': '~20%' }

        " For Commits and BCommits to customize the options used by 'git log':
        let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

        " Advanced customization using autoload functions
        autocmd VimEnter * command! Colors
        \ call fzf#vim#colors({'left': '15%', 'options': '--reverse --margin 30%,0'})

        " Insert mode completion
        imap <c-x><c-f> <Plug>(fzf-complete-path)
        imap <c-x><c-l> <Plug>(fzf-complete-line)

        let g:fzf_colors =
        \ { 'fg':      ['fg', 'Normal'],
        \ 'bg':      ['bg', 'Normal'],
        \ 'hl':      ['fg', 'Comment'],
        \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
        \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
        \ 'hl+':     ['fg', 'Statement'],
        \ 'info':    ['fg', 'PreProc'],
        \ 'prompt':  ['fg', 'Conditional'],
        \ 'pointer': ['fg', 'Exception'],
        \ 'marker':  ['fg', 'Keyword'],
        \ 'spinner': ['fg', 'Label'],
        \ 'header':  ['fg', 'Comment'] }
        nnoremap <silent> <Leader>. :call fzf#run({
                    \ 'source': 'sed "1d" $HOME/.cache/neomru/file',
                    \ 'options': '--tiebreak=index --multi --reverse --margin 15%,0',
                    \ 'down': '20%',
                    \ 'sink': 'e '
                    \ })<CR>
        function! s:escape(path)
            return substitute(a:path, ' ', '\\ ', 'g')
        endfunction

        function! AgHandler(line)
            let parts = split(a:line, ':')
            let [fn, lno] = parts[0 : 1]
            execute 'e '. s:escape(fn)
            execute lno
            normal! zz
        endfunction

        command! -nargs=+ Fag call fzf#run({
                    \ 'source': 'ag "<args>"',
                    \ 'sink': function('AgHandler'),
                    \ 'options': '+m',
                    \ 'tmux_height': '60%'
                    \ })
    endif
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - sjl/gundo.vim.git                                                        │ 
" │ https://github.com/sjl/gundo.vim.git                                              │ 
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('gundo.vim')
    let g:gundo_playback_delay = 240
    nnoremap <Leader>u :GundoToggle<CR>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - nathanaelkane/vim-indent-guides.git                                      │
" │ https://github.com/nathanaelkane/vim-indent-guides.git                            │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('vim-indent-guides')
    let g:indent_guides_auto_colors = 1
    let g:indent_guides_start_level           = 2
    let g:indent_guides_guide_size            = 1
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_color_change_percent  = 7
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - SirVer/ultisnips.git                                                     │
" │ https://github.com/SirVer/ultisnips.git                                           │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('ultisnips')
    let g:UltiSnipsSnippetsDir         = $HOME . './vim/UltiSnips'
    if has("gui_macvim")
        " Ctrl conflicts with Dvorak-Qwerty Command
        let g:UltiSnipsExpandTrigger       = "<m-s>"
    else
        let g:UltiSnipsExpandTrigger       = "<m-s>"
        let g:UltiSnipsJumpForwardTrigger  = "<m-s>"
        let g:UltiSnipsJumpBackwardTrigger = "<m-f>"
        let g:UltiSnipsListSnippets        = "<c-m-s>"
    endif
    if has('conceal')
        set conceallevel=2 concealcursor=i
    endif
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - sjbach/lusty.git                                                         │
" │ https://github.com/sjbach/lusty.git                                               │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('lusty')
    let g:LustyJugglerDefaultMappings = 0
    let LustyExplorerDefaultMappings  = 0
    nmap <silent> <leader>l :LustyFilesystemExplorerFromHere<CR>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - lyokha/vim-xkbswitch.git                                                 │
" │ https://github.com/lyokha/vim-xkbswitch.git                                       │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('vim-xkbswitch')
    let g:XkbSwitchEnabled = 1
    let g:XkbSwitchIMappings = ['ru']
    let g:XkbSwitchLib = '/usr/local/lib/libxkbswitch.so'
    let g:XkbSwitchSkipFt = [ 'nerdtree', 'tex' ]
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - bling/vim-airline.git                                                    │
" │ https://github.com/bling/vim-airline.git                                          │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('vim-airline')
    let g:airline#extensions#tabline#enabled          = 1
    let g:airline#extensions#tabline#tab_nr_type      = 1
    let g:airline#extensions#tabline#buffer_min_count = 1
    let g:airline#extensions#tabline#show_buffers     = 0
    let g:airline_powerline_fonts                     = 1 " Use airline fonts
    let g:airline#extensions#hunks#enabled            = 1
    let g:airline#extensions#branch#enabled           = 1
    let g:airline#extensions#whitespace#checks        = []

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
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - scrooloose/syntastic.git                                                 │
" │ https://github.com/scrooloose/syntastic.git                                       │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('syntastic')
    " '⚡' '😱' '✗' '➽'
    " ⚑ ⚐ ♒ ⛢ ❕ ❗
    let g:syntastic_error_symbol='✗'
    let g:syntastic_warning_symbol='⚠'
    let g:syntastic_style_error_symbol  = '⚡'
    let g:syntastic_style_warning_symbol  = '⚡'
    let g:syntastic_python_pylint_exe = "pylint2"
    let g:syntastic_mode_map = { 'mode': 'active',
        \ 'active_filetypes': [],
        \ 'passive_filetypes': ['python'] }

    let g:syntastic_cpp_compiler_options = ' -std=c++11'
    let g:syntastic_tex_checkers = ['lacheck']
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
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - Valloric/YouCompleteMe.git                                               │
" │ https://github.com/Valloric/YouCompleteMe.git                                     │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('YouCompleteMe')
    " Do not display "Pattern not found" messages during YouCompleteMe completion.
    " Patch: https://groups.google.com/forum/#!topic/vim_dev/WeBBjkXE8H8
    if 1 && exists(':try')
        try
            set shortmess+=c
            " Catch "Illegal character" (and its translations).
        catch /E539: /
        endtry
    endif
    let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
    let g:racer_experimental_completer = 1
    let g:ycm_rust_src_path=substitute(system("rustc --print sysroot")."/lib/rustlib/src/rust/src","\n",'','g')
    let g:ycm_filepath_completion_use_working_dir = 1
    let g:ycm_disable_for_files_larger_than_kb = 1024
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_cache_omnifunc = 1
    let g:ycm_collect_identifiers_from_tags_files = 1
    "--[ syntastic enabling ]-----------------
    let g:ycm_show_diagnostics_ui          = 1 
    let g:ycm_seed_identifiers_with_syntax = 0
    let g:ycm_use_ultisnips_completer      = 1

    let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']
    let g:ycm_key_invoke_completion = '<M-x>'
    let g:ycm_autoclose_preview_window_after_insertion = 1
    nnoremap <leader>y :YcmForceCompileAndDiagnostics<cr>

    let g:ycm_semantic_triggers =  {
        \   'c' : ['->', '.'],
        \   'objc' : ['->', '.'],
        \   'cpp,objcpp' : ['->', '.', '::'],
        \   'perl' : ['->'],
        \   'php' : ['->', '::'],
        \   'cs,java,javascript,d,vim,ruby,perl6,scala,vb,elixir,go' : ['.'],
        \   'erlang' : [':'],
        \   'ocaml' : ['.', '#'],
        \   'ruby' : ['.', '::'],
        \   'rust' : ['.', '::'],
        \ }

    let g:ycm_collect_identifiers_from_tags_files = 0

    let g:ycm_filetype_blacklist = {
        \ 'notes'      : 1,
        \ 'markdown'   : 1,
        \ 'text'       : 1,
        \ 'unite'      : 1,
        \ 'lycosa'     : 1,
        \ 'conqueterm' : 1,
        \ 'asm'        : 1,
        \ 'tagbar'     : 1,
        \ 'qf'         : 1,
        \ 'vimwiki'    : 1,
        \ 'pandoc'     : 1,
        \ 'infolog'    : 1,
        \ 'mail'       : 1,
        \ 'scala'      : 1
        \}

    let g:ycm_min_num_identifier_candidate_chars = 4
    let g:ycm_filetype_specific_completion_to_disable = {
                \ 'javascript': 1
                \ }
    let g:ycm_goto_buffer_command = 'vertical-split'

    nnoremap <silent> <F3> :call youcompleteme#DisableCursorMovedAutocommands()<CR>
    nnoremap <silent> <F4> :call youcompleteme#EnableCursorMovedAutocommands()<CR>
    noremap  <silent> <C-g><C-g> :YcmCompleter GoTo<CR>
    noremap  <silent> <C-g>c :YcmCompleter GoToDeclaration<CR>
    noremap  <silent> <C-g>f :YcmCompleter GoToDefinition<CR>
    noremap  <silent> <C-g>i :YcmCompleter GoToInclude<CR>
    noremap  <silent> <C-g>i :YcmCompleter GoToInclude<CR>
    noremap  <silent> <C-g>I :YcmCompleter GoToImprecise<CR>

    function! s:SetCompleteFunc()
    if !g:neocomplete#force_overwrite_completefunc
        let &completefunc = 'youcompleteme#Complete'
        let &l:completefunc = 'youcompleteme#Complete'
    endif

    if pyeval( 'ycm_state.NativeFiletypeCompletionUsable()' )
        let &omnifunc = 'youcompleteme#OmniComplete'
        let &l:omnifunc = 'youcompleteme#OmniComplete'

  " If we don't have native filetype support but the omnifunc is set to YCM's
  " omnifunc because the previous file the user was editing DID have native
  " support, we remove our omnifunc.
    elseif &omnifunc == 'youcompleteme#OmniComplete'
        let &omnifunc = ''
        let &l:omnifunc = ''
    endif
endfunction
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - majutsushi/tagbar.git                                                    │
" │ https://github.com/majutsushi/tagbar.git                                          │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('tagbar')
    nnoremap <silent> <leader>tt :TagbarToggle<CR>
	let g:tagbar_type_markdown = {
        \ 'ctagstype' : 'markdown',
        \ 'kinds' : [
            \ 'h:Heading_L1',
            \ 'i:Heading_L2',
            \ 'k:Heading_L3'
        \ ]
	\ }
	let g:tagbar_type_css = {
        \ 'ctagstype' : 'Css',
        \ 'kinds' : [
            \ 'c:classes',
            \ 's:selectors',
            \ 'i:identities'
        \ ]
	\ }
	let g:tagbar_type_ruby = {
        \ 'kinds' : [
            \ 'm:modules',
            \ 'c:classes',
            \ 'd:describes',
            \ 'C:contexts',
            \ 'f:methods',
            \ 'F:singleton methods'
        \ ]
	\ }
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - derekwyatt/vim-fswitch.git                                               │
" │ https://github.com/derekwyatt/vim-fswitch.git                                     │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('vim-fswitch')
    " A "companion" file is a .cpp file to an .h file and vice versa
    " Opens the companion file in the current window
    nnoremap <Space>fs :FSHere<cr>
    " Opens the companion file in the window to the left (window needs to exist)
    " This is actually a duplicate of the :FSLeft command which for some reason
    " doesn't work.
    nnoremap <Space>sl :call FSwitch('%', 'wincmd l')<cr>
    " Same as above, only opens it in window to the right
    nnoremap <Space>sr :call FSwitch('%', 'wincmd r')<cr>
    " Creates a new window on the left and opens the companion file in it
    nnoremap <Space>sv :FSSplitLeft<cr>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - chrisbra/Join.git                                                        │
" │ https://github.com/chrisbra/Join.git                                              │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('Join')
    nmap J :Join<CR>
    vmap J :Join<CR>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - klen/python-mode.git                                                     │
" │ https://github.com/klen/python-mode.git                                           │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('python-mode')
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
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - gregsexton/gitv.git                                                      │
" │ https://github.com/gregsexton/gitv.git                                            │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('gitv')
    let g:Gitv_OpenHorizontal = 'auto'
    let g:Gitv_OpenPreviewOnLaunch = 1
    let g:Gitv_WipeAllOnClose = 1
    let g:Gitv_DoNotMapCtrlKey = 1
    let g:Gitv_CommitStep = 1024
    nnoremap <silent> <leader>gv :Gitv --all<CR>
    nnoremap <silent> <leader>gV :Gitv! --all<CR>
    vnoremap <silent> <leader>gV :Gitv! --all<CR>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - Valloric/ListToggle.git                                                  │
" │ https://github.com/Valloric/ListToggle.git                                        │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('ListToggle')
    let g:lt_height = 10
    let g:lt_location_list_toggle_map = '[Quickfix]<Space>'
    let g:lt_quickfix_list_toggle_map = '[Quickfix]q'
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - mattn/zencoding-vim.git                                                  │
" │ https://github.com/mattn/zencoding-vim.git                                        │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('zencoding-vim')
    let g:user_zen_leader_key = '<c-b>'
    let g:user_zen_settings = {
        \  'indentation' : '  '
        \}
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - Raimondi/delimitMate.git                                                 │
" │ https://github.com/Raimondi/delimitMate.git                                       │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('delimitMate')
    let g:delimitMate_expand_space = 1
    let g:delimitMate_expand_cr    = 0
    let g:delimitMate_smart_quotes = 1
    let g:delimitMate_balance_matchpairs = 1

    imap <Esc>OH <Plug>delimitMateHome
    imap <Esc>OF <Plug>delimitMateEnd
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - Raimondi/delimitMate.git                                                 │
" │ https://github.com/Raimondi/delimitMate.git                                       │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('vimfiler.vim')
    let g:vimfiler_as_default_explorer = 1
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - benmills/vimux                                                           │
" │ https://github.com/benmills/vimux.git                                             │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('vimux')
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

    map <Space>rc :VimuxPromptCommand<CR>
    map <Space>rl :VimuxRunLastCommand<CR>
    map <Space>rs :VimuxInterruptRunner<CR>
    map <Space>ri :VimuxInspectRunner<CR>
    map <Space>rq :VimuxCloseRunner<CR>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - tpope/vim-fugitive.git                                                   │
" │ https://github.com/tpope/vim-fugitive.git                                         │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('vim-fugitive')
    nnoremap <Space>gs :Gstatus<CR>
    nnoremap <Space>gw :Gwrite<CR>
    nnoremap <Space>go :Gread<CR>
    nnoremap <Space>gR :Gremove<CR>
    nnoremap <Space>gm :Gmove<Space>
    nnoremap <Space>gc :Gcommit<CR>
    nnoremap <Space>gd :Gdiff<CR>
    nnoremap <Space>gb :Gblame<CR>
    nnoremap <Space>gB :Gbrowse<CR>
    nnoremap <Space>gp :Git! push<CR>
    nnoremap <Space>gP :Git! pull<CR>
    nnoremap <Space>gi :Git!<Space>
    nnoremap <Space>ge :Gedit<CR>
    nnoremap <Space>gE :Gedit<Space>
    nnoremap <Space>gt :!tig<CR>:redraw!<CR>
    nnoremap <Space>gS :exe "silent !shipit"<CR>:redraw!<CR>
    nnoremap <Space>ggc :silent! Ggrep -i<Space>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - dbakker/vim-projectroot.git                                              │
" │ https://github.com/dbakker/vim-projectroot.git                                    │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('vim-projectroot')
    nnoremap <silent> cd :ProjectRootCD<cr>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - bbchung/gasynctags.git                                                   │
" │ https://github.com/bbchung/gasynctags.git                                         │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('gasynctags')
    let g:gasynctags_autostart = 0
    nmap <silent><space>d :GasyncTagsEnable<CR>:GtagsCscope<CR>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - othree/eregex.vim.git                                                    │
" │ https://github.com/othree/eregex.vim.git                                          │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('eregex.vim')
    " With this map, we can select some text in visual mode and by invoking the map,
    " have the selection automatically filled in as the search text and the cursor
    " placed in the position for typing the replacement text. Also, this will ask
    " for confirmation before it replaces any instance of the search text in the
    " file.
    " NOTE: We're using %S here instead of %s; the capital S version comes from the
    " eregex.vim plugin and uses Perl-style regular expressions.
    vnoremap <C-r> "hy:%S/<C-r>h//c<left><left>
    " Toggles '/' to mean eregex search or normal Vim search
    nnoremap <leader>/ :call eregex#toggle()<CR>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - tpope/vim-dispatch.git                                                   │
" │ https://github.com/tpope/vim-dispatch.git                                         │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('vim-dispatch')
    nmap MK :Make -j4
    nmap MC :Make clean<cr>
    nmap <Space>cc :Make -j4<cr>
    nmap <Space>mc :Make distclean<cr>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - davidhalter/jedi-vim.git                                                 │
" │ https://github.com/davidhalter/jedi-vim.git                                       │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('jedi-vim')
    let g:jedi#popup_on_dot = 1
    let g:jedi#popup_select_first = 0
    let g:jedi#completions_enabled = 1
    let g:jedi#usages_command = "<leader>z"
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
endif
if dein#tap('vital.vim') 
    function! dein#tapped.hooks.on_source(bundle)
        let g:V = vital#of('vital')
        let g:S = g:V.import("Web.HTTP")
        let g:L = g:V.import("Data.List")
        function! DecodeURI(uri)
            return g:S.decodeURI(a:uri)
        endfunction
        function! EncodeURI(uri)
            return g:S.encodeURI(a:uri)
        endfunction
        command -nargs=1 DecodeURI echo DecodeURI(<args>)
        command -nargs=1 EncodeURI echo EncodeURI(<args>)
    endfunction
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - xolox/vim-lua-ftplugin.git                                               │ 
" │ git@github.com:xolox/vim-lua-ftplugin.git                                         │ 
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('vim-lua-ftplugin') 
    let g:lua_complete_omni = 1
    " This sets the default value for all buffers.
    let g:lua_compiler_name = '/usr/bin/luac'
    " This is how you change the value for one buffer.
    let b:lua_compiler_name = '/usr/bin/lualint'
    let g:lua_check_globals = 1
    let g:lua_check_syntax = 0  " done via syntastic
    let g:lua_complete_keywords = 1 " interferes with YouCompleteMe
    let g:lua_complete_globals = 1  " interferes with YouCompleteMe?
    let g:lua_complete_library = 1  " interferes with YouCompleteMe
    let g:lua_complete_dynamic = 1  " interferes with YouCompleteMe
    let g:lua_omni_blacklist = ['pl\.strict', 'lgi\..']
    let g:lua_define_omnifunc = 1  " must be enabled also (g:lua_complete_omni=1, but crashes Vim!)
    let g:lua_define_completion_mappings = 0
    let g:lua_internal = 0
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - godlygeek/tabular                                                        │ 
" │ git@github.com:godlygeek/tabular                                                  │ 
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('tabular') 
    nmap <Leader>a&     :Tabularize /&<CR>
    vmap <Leader>a&     :Tabularize /&<CR>
    nmap <Leader>a=     :Tabularize /^[^=]*\zs=<CR>
    vmap <Leader>a=     :Tabularize /^[^=]*\zs=<CR>
    nmap <Leader>a=>    :Tabularize /=><CR>
    vmap <Leader>a=>    :Tabularize /=><CR>
    nmap <Leader>a:     :Tabularize /:<CR>
    vmap <Leader>a:     :Tabularize /:<CR>
    nmap <Leader>a::    :Tabularize /:\zs<CR>
    vmap <Leader>a::    :Tabularize /:\zs<CR>
    nmap <Leader>a,     :Tabularize /,<CR>
    vmap <Leader>a,     :Tabularize /,<CR>
    nmap <Leader>a,,    :Tabularize /,\zs<CR>
    vmap <Leader>a,,    :Tabularize /,\zs<CR>
    nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - dag/vim2hs                                                               │ 
" │ git@github.com:dag/vim2hs                                                         │ 
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('vim2hs') 
    let g:haskell_conceal_enumerations = 1
    let g:haskell_quasi                = 1
    let g:haskell_interpolation        = 1
    let g:haskell_regex                = 1
    let g:haskell_jmacro               = 1
    let g:haskell_shqq                 = 1
    let g:haskell_sql                  = 1
    let g:haskell_json                 = 1
    let g:haskell_xml                  = 1
    let g:haskell_hsp                  = 1
    let g:haskell_multiline_strings    = 1
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - vim-ruby                                                                 │ 
" │ https://github.com/kana/vim-ruby/vim-ruby.git                                     │ 
" └───────────────────────────────────────────────────────────────────────────────────┘
if !has("nvim")
    if dein#tap('vim-ruby')
        autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
        autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
        autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
        autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
    endif
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - skalnik/vim-vroom                                                        │ 
" │ https://github.com/skalnik/vim-vroom                                              │ 
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('vim-vroom')
    let g:vroom_map_keys = 0     " to not use default keymaps
    let g:vroom_use_dispatch = 1 " use dispatch by default
    let g:vroom_use_zeus = 1     " run tests with zeus || bundle exec
    nnoremap \c :call vroom#RunTestFile()<CR>
    nnoremap \s :call vroom#RunNearestTest()<CR>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - luochen1990/rainbow                                                      │
" │ https://github.com/luochen1990/rainbow.git                                        │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('rainbow')
    "0 if you want to enable it later via :RainbowToggle
    let g:rainbow_active = 1 
    let g:rainbow_conf = {
        \   'guifgs': ['#005F87', '#005F5F', '#2B768D', '#395573'],
        \   'ctermfgs': ['cyan', 'darkcyan', 'blue', 'darkblue'],
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
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - rstacruz/sparkup                                                         │
" │ https://github.com/rstacruz/sparkup                                               │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('rainbow')
    let g:sparkupMapsNormal = 0 "default = 0
    let g:sparkupMaps = 1 "default = 1
    let g:sparkupExecuteMapping = "<m-i>" "default = <C-e>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - Shougo/denite.nvim                                                       │
" │ https://github.com/Shougo/denite.nvim                                             │
" └───────────────────────────────────────────────────────────────────────────────────┘
if dein#tap('denite.nvim')
    " Change file_rec command.
    call denite#custom#var('file_rec', 'command',
                \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
    " For ripgrep
    " Note: It is slower than ag
    call denite#custom#var('file_rec', 'command',
                \ ['rg', '--files'])

    " Change mappings.
    call denite#custom#map('insert', '<C-n>', 'move_to_next_line')
    call denite#custom#map('insert', '<C-p>', 'move_to_prev_line')

    " Change matchers.
    call denite#custom#source('file_mru', 'matchers', ['matcher_fuzzy'])
    call denite#custom#source('file_mru', 'filters', 'sorter_ftime')
    call denite#custom#source(
                \ 'file_rec', 'matchers', ['matcher_cpsm'])

    " Add custom menus
    let s:menus = {}

    let s:menus.zsh = {
                \ 'description': 'Edit your import zsh configuration'
                \ }
    let s:menus.zsh.file_candidates = [
                \ ['zshrc', '~/.config/zsh/.zshrc'],
                \ ['zshenv', '~/.zshenv'],
                \ ]

    let s:menus.my_commands = {
                \ 'description': 'Example commands'
                \ }
    let s:menus.my_commands.command_candidates = [
                \ ['Split the window', 'vnew'],
                \ ['Open zsh menu', 'Denite menu:zsh'],
                \ ]

    call denite#custom#var('menu', 'menus', s:menus)

    " Ripgrep command on grep source
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'final_opts', [])
    call denite#custom#var('grep', 'separator', ['--'])

    " Define alias
    call denite#custom#alias('source', 'file_rec/git', 'file_rec')
    call denite#custom#var('file_rec/git', 'command',
                \ ['git', 'ls-files', '-co', '--exclude-standard'])

    " Change default prompt
    call denite#custom#option('default', 'prompt', '>>')

    nnoremap <silent><Leader>. :Denite file_mru<CR>
endif

let g:projectionist_heuristics = {
      \   '*': {
      \     '*.c': {
      \       'alternate': '{}.h',
      \       'type': 'source'
      \     },
      \     '*.h': {
      \       'alternate': '{}.c',
      \       'type': 'header'
      \     },
      \
      \     '*.js': {
      \       'alternate': '{dirname}/__tests__/{basename}-test.js',
      \       'type': 'source'
      \     },
      \     '**/__tests__/*-test.js': {
      \       'alternate': '{dirname}/{basename}.js',
      \       'type': 'test'
      \     }
      \   }
      \ }
