" unite.vim "{{{
" map ff as default f
  nnoremap ff f
" map f as unite prefix key
  nmap f [unite]
  xmap f [unite]
  nnoremap [unite] <Nop>
  xnoremap [unite] <Nop>
" mapping for Unite functions
  nnoremap <silent> [unite]u :Unite -buffer-name=files file<CR>
  nnoremap <silent> [unite]m :Unite -buffer-name=file file_mru<CR>
  nnoremap <silent> [unite]r :UniteResume<CR>
  nnoremap [unite]R :Unite ref/
  nnoremap <silent> [unite]b :UniteWithBufferDir file file/new<CR>
  nnoremap <silent> [unite]c :Unite -buffer-name=files file file/new<CR>
  nnoremap <silent> [unite]t :Unite tab<CR>
  nnoremap <silent> [unite]y :Unite register<CR>
  nnoremap <silent> [unite]a :UniteBookmarkAdd<CR>
  nnoremap <silent> [unite]p :Unite bookmark -default-action=cd -no-start-insert<CR>
" Explore home dir
  nnoremap <silent> <expr> [unite]h ':UniteWithInput -buffer-name=files file file/new -input='. substitute($HOME, '\' ,'/', 'g') .'/<CR>'
  nnoremap <silent> [unite]H :<C-u>Unite history/yank<CR>
  nnoremap <silent> [unite]j :Unite buffer_tab -no-start-insert<CR>
  nnoremap <silent> [unite]l :Unite -auto-preview line<CR>
  nnoremap <expr> [unite]g ':Unite grep:'. expand("%:h") . ':-r'
  nnoremap <silent> [unite]* :UniteWithCursorWord line<CR>
  nnoremap <silent> [unite]o :Unite -buffer-name=outline outline<CR>
  nnoremap <silent> [unite]q :Unite quickfix -no-start-insert<CR>
  nnoremap [unite]s<SPACE> :Unite svn/
  nnoremap <silent> [unite]sd :Unite svn/diff<CR>
  nnoremap <silent> [unite]sb :Unite svn/blame<CR>
  nnoremap <silent> [unite]ss :Unite svn/status<CR>
  nnoremap <C-j> :Unite gtags/context<CR>
  function! UniteCurrentProjectShortcut(key)
    if exists("t:local_unite") && has_key(t:local_unite, a:key)
      execute t:local_unite[a:key]
    else
      echo "ERROR: t:local_unite is not defined or not has key: ". a:key
    endif
  endfunction
  let s:local_unite_source = {
        \ "name" : "local",
        \ "description" : 'Unite commands defined at t:local_unite',
        \ }
  function! s:local_unite_source.gather_candidates(args, context)
    let l:candidates = []
    if exists("t:local_unite")
      for key in sort(keys(t:local_unite))
        let l:candidate = {
              \ 'word' : key . ': ' . t:local_unite[key],
              \ 'kind' : 'command',
              \ 'action__command' : t:local_unite[key] . ' ',
              \ 'source__command' : ':'. t:local_unite[key],
              \ }
        call add(l:candidates, l:candidate)
      endfor
    else
      call unite#print_message("[unite-local] Warning: t:local_unite is not defined")
    endif
    return l:candidates
  endfunction
  call unite#define_source(s:local_unite_source)
  for key_number in [1, 2, 3, 4, 5, 6, 7, 8, 9]
    execute printf('nnoremap <silent> [unite]%d :<C-u> call UniteCurrentProjectShortcut(%d)<CR>', key_number, key_number)
  endfor

  nnoremap [unite]<SPACE> :Unite local<CR>

  let g:unite_enable_ignore_case = 1
  let g:unite_enable_smart_case = 1
  let g:unite_enable_start_insert = 1
  let g:unite_enable_split_vertically = 0
  let g:unite_source_file_mru_limit = 300
  let g:unite_source_file_rec_min_cache_files = 300
  let g:unite_source_file_rec_max_depth = 10
  let g:unite_kind_openable_cd_command = 'TabpageCD'
  let g:unite_kind_openable_lcd_command = 'TabpageCD'
  let g:unite_winheight = 20
  let g:unite_source_history_yank_enable = 1
  let g:unite_source_bookmark_directory = $HOME . "/.unite/bookmark"

  let g:unite_source_gtags_treelize = 1
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
    imap <silent><buffer> <C-j> <Plug>(unite_exit)
    nmap <silent><buffer> <C-j> <Plug>(unite_all_exit)
    inoremap <silent><buffer> <SPACE> _
    inoremap <silent><buffer> _ <SPACE>
  endfunction "}}}
  autocmd FileType unite call s:unite_my_settings()

