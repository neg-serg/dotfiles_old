" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ misc plugins settings                                                             │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:gitgutter_realtime = 0             " github.com/airblade/vim-gitgutter/issues/106
let g:ConqueGdb_Leader          = '\\'   "<leader>, by default is painful
let g:EclimCompletionMethod     = 'omnifunc' "To provide ycm autocompletion
let g:livepreview_previewer = 'zathura'
let g:eregex_default_enable = 0
let g:mta_use_matchparen_group = 0
let g:lua_complete_omni = 1
let g:gasynctags_autostart = 0
" let g:powerline_pycmd="py3"
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - sjl/gundo.vim.git                                                        │ 
" │ https://github.com/sjl/gundo.vim.git                                              │ 
" └───────────────────────────────────────────────────────────────────────────────────┘
if neobundle#tap('gundo.vim')
    let g:gundo_playback_delay = 240

    nnoremap <Leader>u :GundoToggle<CR>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - nathanaelkane/vim-indent-guides.git                                      │
" │ https://github.com/nathanaelkane/vim-indent-guides.git                            │
" └───────────────────────────────────────────────────────────────────────────────────┘
if neobundle#tap('vim-indent-guides')
    let g:indent_guides_auto_colors = 1
    let g:indent_guides_start_level           = 2
    let g:indent_guides_guide_size            = 1
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_color_change_percent  = 7
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - Yggdroot/indentLine.git                                                  │
" │ https://github.com/Yggdroot/indentLine.git                                        │
" └───────────────────────────────────────────────────────────────────────────────────┘
if neobundle#tap('indentLine')
    let g:indentLine_enabled = 0
    let g:indentLine_char = '│'
    let g:indentLine_faster = 1
    let g:indentLine_color_term = 238
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - SirVer/ultisnips.git                                                     │
" │ https://github.com/SirVer/ultisnips.git                                           │
" └───────────────────────────────────────────────────────────────────────────────────┘
if neobundle#tap('ultisnips')
    let g:UltiSnipsSnippetsDir         = $HOME . './vim/UltiSnips'
    if has("gui_macvim")
        " Ctrl conflicts with Dvorak-Qwerty Command
        let g:UltiSnipsExpandTrigger       = "<m-s>"
    else
        let g:UltiSnipsExpandTrigger="<m-s>"
        let g:UltiSnipsJumpForwardTrigger="<m-s>"
        let g:UltiSnipsJumpBackwardTrigger="<m-f>"
        let g:UltiSnipsListSnippets        = "<c-m-s>"
    endif
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - sjbach/lusty.git                                                         │
" │ https://github.com/sjbach/lusty.git                                               │
" └───────────────────────────────────────────────────────────────────────────────────┘
if neobundle#tap('lusty')
    let g:LustyJugglerDefaultMappings = 0
    let LustyExplorerDefaultMappings  = 0
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - lyokha/vim-xkbswitch.git                                                 │
" │ https://github.com/lyokha/vim-xkbswitch.git                                       │
" └───────────────────────────────────────────────────────────────────────────────────┘
if neobundle#tap('vim-xkbswitch')
    let g:XkbSwitchEnabled = 1
    let g:XkbSwitchIMappings = ['ru']
    let g:XkbSwitchLib = '/usr/local/lib/libxkbswitch.so'
    let g:XkbSwitchSkipFt = [ 'nerdtree', 'tex' ]
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - bling/vim-airline.git                                                    │
" │ https://github.com/bling/vim-airline.git                                          │
" └───────────────────────────────────────────────────────────────────────────────────┘
if neobundle#tap('vim-airline')
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#tab_nr_type = 1
    let g:airline#extensions#tabline#buffer_min_count = 1
    let g:airline#extensions#tabline#show_buffers = 0
    let g:airline_powerline_fonts = 1 " Use airline fonts
    let g:airline#extensions#hunks#enabled = 1
    let g:airline#extensions#branch#enabled = 1
    let g:airline#extensions#whitespace#checks = []

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
if neobundle#tap('syntastic')
    let g:syntastic_error_symbol='✗'
    let g:syntastic_warning_symbol='⚠'
    let g:syntastic_style_error_symbol  = '⚡'
    let g:syntastic_style_warning_symbol  = '⚡'
    let g:syntastic_python_pylint_exe = "pylint2"
    let g:syntastic_mode_map = { 'mode': 'active',
        \ 'active_filetypes': [],
        \ 'passive_filetypes': ['python'] }

    let g:syntastic_cpp_compiler_options = ' -std=c++11'

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
if neobundle#tap('YouCompleteMe')
    let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
    let g:ycm_filepath_completion_use_working_dir = 1
    let g:ycm_confirm_extra_conf = 0
    let g:ycm_cache_omnifunc = 1
    " let g:ycm_collect_identifiers_from_tags_files = 1
    "--[ syntastic enabling ]-----------------
    let g:ycm_show_diagnostics_ui          = 1 
    let g:ycm_seed_identifiers_with_syntax = 0
    let g:ycm_use_ultisnips_completer      = 1

    let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
    let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']
    let g:ycm_key_invoke_completion = '<A-x>'
    let g:ycm_autoclose_preview_window_after_insertion = 1
    nnoremap <leader>y :YcmForceCompileAndDiagnostics<cr>

    " let g:ycm_add_preview_to_completeopt = 1
    " let g:ycm_autoclose_preview_window_after_completion = 0
    " let g:ycm_autoclose_preview_window_after_insertion = 0 

    let g:ycm_semantic_triggers =  {
        \   'c' : ['->', '.'],
        \   'objc' : ['->', '.'],
        \   'cpp,objcpp' : ['->', '.', '::'],
        \   'perl' : ['->'],
        \   'php' : ['->', '::'],
        \   'cs,java,javascript,d,vim,ruby,perl6,scala,vb,elixir,go' : ['.'],
        \   'lua' : ['.', ':'],
        \   'erlang' : [':'],
        \   'ocaml' : ['.', '#'],
        \   'ruby' : ['.', '::'],
        \ }

    let g:ycm_collect_identifiers_from_tags_files = 0

    let g:ycm_filetype_blacklist = {
        \ 'notes'      : 1,
        \ 'markdown'   : 1,
        \ 'text'       : 1,
        \ 'unite'      : 1,
        \ 'conqueterm' : 1,
        \ 'asm'        : 1,
        \ 'tagbar'     : 1,
        \ 'qf'         : 1,
        \ 'vimwiki'    : 1,
        \ 'pandoc'     : 1,
        \ 'infolog'    : 1,
        \ 'mail'       : 1,
        \ 'python'     : 1
        \}

    let g:ycm_min_num_identifier_candidate_chars = 4
    let g:ycm_filetype_specific_completion_to_disable = {'javascript': 1, 'python': 1}
    let g:ycm_goto_buffer_command = 'vertical-split'

    nnoremap <silent> <F3> :call youcompleteme#DisableCursorMovedAutocommands()<CR>
    nnoremap <silent> <F4> call youcompleteme#EnableCursorMovedAutocommands()<CR>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - majutsushi/tagbar.git                                                    │
" │ https://github.com/majutsushi/tagbar.git                                          │
" └───────────────────────────────────────────────────────────────────────────────────┘
if neobundle#tap('tagbar')
    nnoremap <silent> <leader>tt :TagbarToggle<CR>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - derekwyatt/vim-fswitch.git                                               │
" │ https://github.com/derekwyatt/vim-fswitch.git                                     │
" └───────────────────────────────────────────────────────────────────────────────────┘
if neobundle#tap('vim-fswitch')
    " A "companion" file is a .cpp file to an .h file and vice versa
    " Opens the companion file in the current window
    nnoremap <Space>sh :FSHere<cr>
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
if neobundle#tap('Join')
    nmap J :Join<CR>
    vmap J :Join<CR>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - utl.vim                                                                  │
" │ https://github.com/vim-scripts/utl.vim.git                                        │
" └───────────────────────────────────────────────────────────────────────────────────┘
if neobundle#tap('utl')
    let g:utl_cfg_hdl_scm_http_system = "silent !firefox %u &"
    let g:utl_cfg_hdl_mt_application_pdf = 'silent :!zathura %p &'
    let g:utl_cfg_hdl_mt_image_jpeg = 'silent :!sxiv %p &'
    let g:utl_cfg_hdl_mt_image_gif = 'silent :!sxiv %p &'
    let g:utl_cfg_hdl_mt_image_png = 'silent :!sxiv %p &'
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - klen/python-mode.git                                                     │
" │ https://github.com/klen/python-mode.git                                           │
" └───────────────────────────────────────────────────────────────────────────────────┘
if neobundle#tap('python-mode')
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
if neobundle#tap('gitv')
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
if neobundle#tap('ListToggle')
    let g:lt_height = 10
    
    let g:lt_location_list_toggle_map = '[Quickfix]<Space>'
    let g:lt_quickfix_list_toggle_map = '[Quickfix]q'
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - mattn/zencoding-vim.git                                                  │
" │ https://github.com/mattn/zencoding-vim.git                                        │
" └───────────────────────────────────────────────────────────────────────────────────┘
if neobundle#tap('zencoding-vim')
    let g:user_zen_leader_key = '<c-b>'
    let g:user_zen_settings = {
        \  'indentation' : '  '
        \}
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - Raimondi/delimitMate.git                                                 │
" │ https://github.com/Raimondi/delimitMate.git                                       │
" └───────────────────────────────────────────────────────────────────────────────────┘
if neobundle#tap('delimitMate')
    let g:delimitMate_expand_space = 1
    let g:delimitMate_expand_cr    = 0
    let g:delimitMate_smart_quotes = 1
    let g:delimitMate_balance_matchpairs = 1

    imap <Esc>OH <Plug>delimitMateHome
    imap <Esc>OF <Plug>delimitMateEnd
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - xolox/vim-easytags.git                                                   │
" │ https://github.com/xolox/vim-easytags.git                                         │
" └───────────────────────────────────────────────────────────────────────────────────┘
if neobundle#tap('vim-easytags')
    let g:easytags_updatetime_min = 9000
    let g:easytags_dynamic_files  = 1
    let g:easytags_events         = ['BufWritePost']
    let g:easytags_python_enabled = 1
    let g:easytags_auto_update    = 1
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - benmills/vimux                                                           │
" │ https://github.com/benmills/vimux.git                                             │
" └───────────────────────────────────────────────────────────────────────────────────┘
if neobundle#tap('vimux')
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
if neobundle#tap('vim-fugitive')
    nnoremap <Leader>gs :Gstatus<CR>
    nnoremap <Leader>gw :Gwrite<CR>
    nnoremap <Leader>go :Gread<CR>
    nnoremap <Leader>gR :Gremove<CR>
    nnoremap <Leader>gm :Gmove<Space>
    nnoremap <Leader>gc :Gcommit<CR>
    nnoremap <Leader>gd :Gdiff<CR>
    nnoremap <Leader>gb :Gblame<CR>
    nnoremap <Leader>gB :Gbrowse<CR>
    nnoremap <Leader>gp :Git! push<CR>
    nnoremap <Leader>gP :Git! pull<CR>
    nnoremap <Leader>gi :Git!<Space>
    nnoremap <Leader>ge :Gedit<CR>
    nnoremap <Leader>gE :Gedit<Space>
    nnoremap <Leader>gt :!tig<CR>:redraw!<CR>
    nnoremap <Leader>gS :exe "silent !shipit"<CR>:redraw!<CR>
    nnoremap <Leader>ggc :silent! Ggrep -i<Space>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - YankRing.vim                                                             │
" │ https://github.com/vim-scripts/YankRing.vim.git                                   │
" └───────────────────────────────────────────────────────────────────────────────────┘
if neobundle#tap('YankRing.vim')
    let g:yankring_history_dir = '/tmp'
    let g:yankring_history_file = 'yankring_hist'
    " this is so that single char deletes don't end up in the yankring
    let g:yankring_min_element_length = 2
    let g:yankring_window_height = 14

    nnoremap <leader>r :YRShow<CR>
    " this makes Y yank from the cursor to the end of the line, which makes more
    " sense than the default of yanking the whole current line (we can use yy for
    " that)
    function! YRRunAfterMaps()
        nnoremap Y   :<C-U>YRYankCount 'y$'<CR>
    endfunction
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - Shougo/unite.vim                                                         │
" │ https://github.com/Shougo/unite.vim.git                                           │
" └───────────────────────────────────────────────────────────────────────────────────┘
if neobundle#tap('unite.vim')
    function! s:unite_my_settings()
    nnoremap <silent><buffer> <C-o> :call unite#mappings#do_action('tabopen')<CR>
    nnoremap <silent><buffer> <C-v> :call unite#mappings#do_action('vsplit')<CR>
    nnoremap <silent><buffer> <C-s> :call unite#mappings#do_action('split')<CR>
    nnoremap <silent><buffer> <C-r> :call unite#mappings#do_action('rec')<CR>
    nnoremap <silent><buffer> <C-f> :call unite#mappings#do_action('preview')<CR>
    inoremap <silent><buffer> <C-o> <Esc>:call unite#mappings#do_action('tabopen')<CR>
    inoremap <silent><buffer> <C-v> <Esc>:call unite#mappings#do_action('vsplit')<CR>
    inoremap <silent><buffer> <C-s> <Esc>:call unite#mappings#do_action('split')<CR>
    inoremap <silent><buffer> <C-r> <Esc>:call unite#mappings#do_action('rec')<CR>
    inoremap <silent><buffer> <C-e> <Esc>:call unite#mappings#do_action('edit')<CR>
    inoremap <silent><buffer> <C-f> <C-o>:call unite#mappings#do_action('preview')<CR>
    " I hope to use <C-o> and return to the selected item after action...
    nmap <silent><buffer> jl <Plug>(unite_exit)
    imap <silent><buffer> jl <Plug>(unite_exit)
    imap <silent><buffer> <C-c> <Plug>(unite_exit)
    imap <silent><buffer> <C-j> <Plug>(unite_exit)
    imap <silent><buffer> <ESC> <NOP>
    nmap <silent><buffer> <C-j> <Plug>(unite_all_exit)
    inoremap <silent><buffer> <SPACE> _
    inoremap <silent><buffer> _ <SPACE>
    endfunction
    autocmd FileType unite call s:unite_my_settings()

    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    call unite#filters#sorter_default#use(['sorter_rank'])
    call unite#custom#source('file_mru,file_rec,file_rec/async,grep,locate',
                \ 'ignore_pattern', join(['\.git/', 'tmp/', 'bundle/'], '\|'))
    " call unite#custom#source( 'neomru/file', 'matchers', ['matcher_project_files', 'matcher_fuzzy'])
    call unite#custom#profile('neomru/file', 'filters', 'sorter_ftime')

    let g:unite_enable_ignore_case               = 1
    let g:unite_enable_smart_case                = 1
    let g:unite_enable_start_insert              = 1
    let g:unite_enable_split_vertically          = 0
    let g:unite_source_file_mru_limit            = 300
    let g:unite_source_file_mru_time_format      = '(%d-%m-%Y %H:%M:%S) '
    let g:unite_source_directory_mru_time_format = '(%d-%m-%Y %H:%M:%S) '
    let g:unite_source_mru_update_interval       = 300
    let g:unite_source_file_rec_min_cache_files  = 300
    let g:unite_source_file_rec_max_depth        = 10
    let g:unite_source_history_yank_enable       = 0
    let g:unite_source_bookmark_directory        = $HOME . "/.config/unite/bookmark"
    let g:unite_data_directory                   = $HOME.'/.config/unite'
    let g:junkfile#directory                     = expand($HOME."/.config/unite/junk")
    let g:unite_source_gtags_treelize            = 1
    let g:unite_enable_short_source_mes          = 0
    let g:unite_force_overwrite_statusline       = 0
    let g:unite_prompt                           = '>> '
    let g:unite_marked_icon                      = '✓'
    let g:unite_update_time                      = 200
    let g:unite_split_rule                       = 'botright'
    let g:unite_source_buffer_time_format        = '(%d-%m-%Y %H:%M:%S) '
    let g:unite_winheight                        = 10
    let g:unite_candidate_icon                   = "▷"

    if executable('ag')
        let g:unite_source_grep_command               = 'ag'
        let g:unite_source_grep_default_opts =
            \ '--smart-case --line-numbers --nocolor --nogroup'
        let g:unite_source_grep_recursive_opt         = ''
        let g:unite_source_grep_search_word_highlight = 1
    elseif executable('ack')
        let g:unite_source_grep_command               = 'ack'
        let g:unite_source_grep_default_opts          = '--no-group --no-color'
        let g:unite_source_grep_recursive_opt         = ''
        let g:unite_source_grep_search_word_highlight = 1
    endif

    function! s:vimfiler_toggle()
        if &filetype == 'vimfiler'
            execute 'silent! buffer #'
            if &filetype == 'vimfiler'
                execute 'enew'
            endif
        elseif exists('t:vimfiler_buffer') && bufexists(t:vimfiler_buffer)
            execute 'buffer ' . t:vimfiler_buffer
        else
            execute 'VimFilerCreate'
            let t:vimfiler_buffer = @%
        endif
    endfunction
    function! s:vimfiler_settings()
        setlocal nobuflisted
        setlocal colorcolumn=
        nmap <buffer> q :call <SID>vimfiler_toggle()<CR>
        nmap <buffer> <ENTER> o
        nmap <buffer> <expr> o vimfiler#smart_cursor_map("\<Plug>(vimfiler_expand_tree)", "\<Plug>(vimfiler_edit_file)")
        nmap <buffer> <expr> C vimfiler#smart_cursor_map("\<Plug>(vimfiler_cd_file)", "")
        nmap <buffer> j <Plug>(vimfiler_loop_cursor_down)
        nmap <buffer> k <Plug>(vimfiler_loop_cursor_up)
        nmap <buffer> gg <Plug>(vimfiler_cursor_top)
        nmap <buffer> R <Plug>(vimfiler_redraw_screen)
        nmap <buffer> <SPACE> <Plug>(vimfiler_toggle_mark_current_line)
        nmap <buffer> U <Plug>(vimfiler_clear_mark_all_lines)
        nmap <buffer> cp <Plug>(vimfiler_copy_file)
        nmap <buffer> mv <Plug>(vimfiler_move_file)
        nmap <buffer> rm <Plug>(vimfiler_delete_file)
        nmap <buffer> mk <Plug>(vimfiler_make_directory)
        nmap <buffer> e <Plug>(vimfiler_new_file)
        nmap <buffer> u <Plug>(vimfiler_switch_to_parent_directory)
        nmap <buffer> . <Plug>(vimfiler_toggle_visible_ignore_files)
        nmap <buffer> I <Plug>(vimfiler_toggle_visible_ignore_files)
        nmap <buffer> yy <Plug>(vimfiler_yank_full_path)
        nmap <buffer> cd <Plug>(vimfiler_cd_vim_current_dir)
        vmap <buffer> <Space> <Plug>(vimfiler_toggle_mark_selected_lines)
    endfunction
    autocmd FileType vimfiler call s:vimfiler_settings()
    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_safe_mode_by_default = 0
    let g:vimfiler_tree_leaf_icon = ' '
    let g:vimfiler_tree_opened_icon = '▾'
    let g:vimfiler_tree_closed_icon = '▸'
    let g:vimfiler_enable_auto_cd = 1
    let g:vimfiler_no_default_key_mappings = 1

    nmap e [unite]
    xmap e [unite]
    nnoremap [unite] <Nop>
    xnoremap [unite] <Nop>
    " mapping for Unite functions
    nnoremap <silent> [unite]r :UniteResume<CR>
    nnoremap [unite]R :Unite ref/
    nnoremap <silent> [unite]t :Unite tab<CR>
    nnoremap <silent> [unite]y :Unite register<CR>
    nnoremap <silent> [unite]H :<C-u>Unite history/yank<CR>
    nnoremap <silent> [unite]j :Unite buffer_tab <CR>
    nnoremap <silent> [unite]o :Unite -vertical -winwidth=40 -direction=topleft -toggle outline<CR>
    nnoremap <silent> [unite]q :Unite quickfix -no-start-insert<CR>
    nnoremap <expr> [unite]g ':Unite grep:'. expand("%:h") . ':-r'
    nnoremap <space>/ :Unite grep:.<cr>
    nnoremap <silent> [unite]d :Unite -silent buffer<CR>
    nnoremap <silent><Leader>. :Unite -silent -start-insert neomru/file<CR>
    nnoremap <silent><Leader>D :Unite -silent junkfile/new junkfile<CR>
    nnoremap <Leader>gl :exe "silent Glog <Bar> Unite -no-quit
                \ quickfix"<CR>:redraw!<CR>
    nnoremap <Leader>gL :exe "silent Glog -- <Bar> Unite -no-quit
                \ quickfix"<CR>:redraw!<CR>
    nnoremap <Leader>gg :exe 'silent Gvimrcgrep -i '.input("Pattern: ")<Bar>Unite
                \ quickfix -no-quit<CR>
    nnoremap <Leader>ggm :exe 'silent Glog --grep='.input("Pattern: ").' <Bar>
                \Unite -no-quit quickfix'<CR>
    nnoremap <Leader>ggt :exe 'silent Glog -S='.input("Pattern: ").' <Bar>
                \Unite -no-quit quickfix'<CR>
    nnoremap <Leader>gn :Unite output:echo\ system("git\ init")<CR>
    " ┌───────────────────────────────────────────────────────────────────────────────┐
    " │ plugin - hewes/unite-gtags.git                                                │
    " │ https://github.com/hewes/unite-gtags.git                                      │
    " └───────────────────────────────────────────────────────────────────────────────┘
    if neobundle#tap('unite-gtags')
        nnoremap [unite]D :execute 'Unite gtags/def:'.expand('<cword>')<CR>
        nnoremap [unite]C :execute 'Unite gtags/context'<CR>
        nnoremap [unite]R :execute 'Unite gtags/ref'<CR>
        nnoremap [unite]G :execute 'Unite gtags/grep'<CR>
        vnoremap <leader>gg <ESC>:execute 'Unite gtags/def:'.GetVisualSelection()<CR>
    endif
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - drmikehenry/vim-fontsize.git                                             │
" │ https://github.com/drmikehenry/vim-fontsize.git                                   │
" └───────────────────────────────────────────────────────────────────────────────────┘
if neobundle#tap('vim-fontsize')
    nmap <silent> <F11>                       <Plug>FontsizeBegin
    nmap <silent> <SID>DisableFontsizeInc     <Plug>FontsizeInc
    nmap <silent> <SID>DisableFontsizeDec     <Plug>FontsizeDec
    nmap <silent> <SID>DisableFontsizeDefault <Plug>FontsizeDefault
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - dbakker/vim-projectroot.git                                              │
" │ https://github.com/dbakker/vim-projectroot.git                                    │
" └───────────────────────────────────────────────────────────────────────────────────┘
if neobundle#tap('vim-projectroot')
    nnoremap <silent> <leader>cd :ProjectRootCD<cr>
    nnoremap <silent> cd :ProjectRootCD<cr>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - bbchung/gasynctags.git                                                   │
" │ https://github.com/bbchung/gasynctags.git                                         │
" └───────────────────────────────────────────────────────────────────────────────────┘
if neobundle#tap('gasynctags')
    nmap <silent><space>d :GasyncTagsEnable<CR>:GtagsCscope<CR>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - sjbach/lusty.git                                                         │
" │ https://github.com/sjbach/lusty.git                                               │
" └───────────────────────────────────────────────────────────────────────────────────┘
if neobundle#tap('lusty')
    nmap <silent> <leader>l :LustyFilesystemExplorerFromHere<CR>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - othree/eregex.vim.git                                                    │
" │ https://github.com/othree/eregex.vim.git                                          │
" └───────────────────────────────────────────────────────────────────────────────────┘
if neobundle#tap('eregex.vim')
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
if neobundle#tap('vim-dispatch')
    nmap <F9> :Make<cr>
    nmap MK :Make 
    nmap MC :Make clean<cr>
endif
" ┌───────────────────────────────────────────────────────────────────────────────────┐
" │ plugin - luochen1990/rainbow                                                      │
" │ https://github.com/luochen1990/rainbow.git                                        │
" └───────────────────────────────────────────────────────────────────────────────────┘
if neobundle#tap('rainbow')
    let g:rainbow_active = 1 "0 if you want to enable it later via :RainbowToggle
    let g:rainbow_conf = {
        \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
        \   'ctermfgs': ['darkgray', 'darkblue', 'darkmagenta', 'darkcyan'],
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
" │ plugin - davidhalter/jedi-vim.git                                                 │
" │ https://github.com/davidhalter/jedi-vim.git                                       │
" └───────────────────────────────────────────────────────────────────────────────────┘
if neobundle#tap('jedi-vim')
    let g:jedi#popup_on_dot = 1
    let g:jedi#popup_select_first = 0
    let g:jedi#completions_enabled = 1
    let g:jedi#usages_command = "<leader>z"
endif

if neobundle#tap('lightline.vim')
    " lightline setting {{{
    let g:lightline = {
                \ 'colorscheme': 'wombat',
                \ 'mode_map': {
                \ 'n' : 'N',
                \ 'i' : 'I',
                \ 'R' : 'R',
                \ 'v' : 'V',
                \ 'V' : 'V-L',
                \ 'c' : 'COMMAND',
                \ "\<C-v>": 'V-B',
                \ 's' : 'SELECT',
                \ 'S' : 'S-L',
                \ "\<C-s>": 'S-B',
                \ '?': ' '
                \ },
                \ 'active': {
                \ 'left': [
                \ [ 'mode', 'paste' ],
                \ [ 'filename','fugitive','anzu'],
                \ ],
                \ 'right': [
                \ [ 'lineinfo', 'syntastic' ],
                \ [ 'percent' ],
                \ [ 'filetype'],
                \ ]
                \ },
                \ 'component_function': {
                \ 'modified': 'MyModified',
                \ 'readonly': 'MyReadonly',
                \ 'fugitive': 'MyFugitive',
                \ 'filename': 'MyFilename',
                \ 'fileformat': 'MyFileformat',
                \ 'filetype': 'MyFiletype',
                \ 'fileencoding': 'MyFileencoding',
                \ 'mode': 'MyMode',
                \ 'syntastic': 'SyntasticStatuslineFlag',
                \ 'anzu': 'anzu#search_status',
                \ }
                \ }
    
    function! neobundle#tapped.hooks.on_source(bundle)
        let g:unite_force_overwrite_statusline=0
        let g:vimfiler_force_overwrite_statusline=0
        let g:vimshell_force_overwrite_statusline=0
    endfunction 
    function! MyModified() 
        return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
    endfunction 
    function! MyReadonly() 
        return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
    endfunction 
    function! MyFilename() 
        return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                    \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
                    \ &ft == 'unite' ? unite#get_status_string() :
                    \ &ft == 'vimshell' ? vimshell#get_status_string() :
                    \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                    \ ('' != MyModified() ? ' ' . MyModified() : '')
    endfunction 
    function! MyFugitive() 
        try
            if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
                return fugitive#head()
            endif
        catch
        endtry
        return ''
    endfunction 
    function! MyFileformat() 
        return winwidth('.') > 70 ? &fileformat : ''
    endfunction 
    function! MyFiletype() 
        return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
    endfunction 
    function! MyFileencoding() 
        return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
    endfunction 
    function! MyMode()
        return winwidth('.') > 60 ? lightline#mode() : ''
    endfunction 
    call neobundle#untap()
endif

if neobundle#tap('vital.vim') 
    function! neobundle#tapped.hooks.on_source(bundle)
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
" │ plugin - farseer90718/unite-workflow                                              │
" │ https://github.com/farseer90718/unite-workflow.git                                │
" └───────────────────────────────────────────────────────────────────────────────────┘
let g:unite#workflow#reddit#front = 'http://www.reddit.com/.json?feed=foo&user=bar'
call unite#custom#profile(
            \ 'source/github/search, source/github/event, '.
            \ 'source/github/feed, source/gist/search, '.
            \ 'source/gist/user, source/v2ex, '.
            \ 'source/reddit, source/wikipedia',
            \ 'context', {
            \   'keep_focus' : 1,
            \   'no_quit' : 1
            \ })
call unite#custom#profile(
            \ 'source/youdao, source/toilet',
            \ 'context', {
            \   'max_multi_lines' : 20,
            \   'winheight' : 20
            \ })
nnoremap <leader>t  :Unite youdao:<C-R><C-W><CR>
