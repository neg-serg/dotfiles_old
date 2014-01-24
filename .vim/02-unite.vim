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
" unite.vim "{{{

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
"----------------------[  Unite  ]-------------------------------------

let g:unite_source_menu_menus = {}

let g:unite_source_menu_menus.files = {
    \ 'description' : '          files & dirs
        \                                          ⌘ [space]o',
    \}
let g:unite_source_menu_menus.files.command_candidates = [
    \['▷ open file                                                  ⌘ ,o',
        \'Unite -start-insert file'],
    \['▷ open more recently used files                              ⌘ ,m',
        \'Unite file_mru'],
    \['▷ open file with recursive search                            ⌘ ,O',
        \'Unite -start-insert file_rec/async'],
    \['▷ edit new file',
        \'Unite file/new'],
    \['▷ search directory',
        \'Unite directory'],
    \['▷ search recently used directories',
        \'Unite directory_mru'],
    \['▷ search directory with recursive search',
        \'Unite directory_rec/async'],
    \['▷ make new directory',
        \'Unite directory/new'],
    \['▷ change working directory',
        \'Unite -default-action=lcd directory'],
    \['▷ know current working directory',
        \'Unite output:pwd'],
    \['▷ junk files                                                 ⌘ ,d',
        \'Unite junkfile/new junkfile'],
    \['▷ save as root                                               ⌘ :w!!',
        \'exe "write !sudo tee % >/dev/null"'],
    \['▷ quick save                                                 ⌘ ,w',
        \'normal ,w'],
    \['▷ open ranger                                                ⌘ ,x',
        \'call RangerChooser()'],
    \['▷ open vimfiler                                              ⌘ ,X',
        \'VimFiler'],
    \]

" file searching menu
let g:unite_source_menu_menus.grep = {
    \ 'description' : '           search files
        \                                          ⌘ [space]a',
    \}
let g:unite_source_menu_menus.grep.command_candidates = [
    \['▷ grep (ag → ack → grep)                                     ⌘ ,a',
        \'Unite -no-quit grep'],
    \['▷ find',
        \'Unite find'],
    \['▷ locate',
        \'Unite -start-insert locate'],
    \['▷ vimgrep (very slow)',
        \'Unite vimgrep'],
    \]

" buffers, tabs & windows menu
let g:unite_source_menu_menus.navigation = {
    \ 'description' : '     navigate by buffers, tabs & windows
        \                   ⌘ [space]b',
    \}
let g:unite_source_menu_menus.navigation.command_candidates = [
    \['▷ buffers                                                    ⌘ ,b',
        \'Unite buffer'],
    \['▷ tabs                                                       ⌘ ,B',
        \'Unite tab'],
    \['▷ windows',
        \'Unite window'],
    \['▷ location list',
        \'Unite location_list'],
    \['▷ quickfix',
        \'Unite quickfix'],
    \['▷ resize windows                                             ⌘ C-C C-W',
        \'WinResizerStartResize'],
    \['▷ new vertical window                                        ⌘ ,v',
        \'vsplit'],
    \['▷ new horizontal window                                      ⌘ ,h',
        \'split'],
    \['▷ close current window                                       ⌘ ,k',
        \'close'],
    \['▷ toggle quickfix window                                     ⌘ ,q',
        \'normal ,q'],
    \['▷ zoom                                                       ⌘ ,z',
        \'ZoomWinTabToggle'],
    \['▷ delete buffer                                              ⌘ ,K',
        \'bd'],
    \]
" }}}

" buffer internal searching menu
let g:unite_source_menu_menus.searching = {
    \ 'description' : '      searchs inside the current buffer
        \                     ⌘ [space]f',
    \}
let g:unite_source_menu_menus.searching.command_candidates = [
    \['▷ search line                                                ⌘ ,f',
        \'Unite -auto-preview -start-insert line'],
    \['▷ search word under the cursor                               ⌘ [space]8',
        \'UniteWithCursorWord -no-split -auto-preview line'],
    \['▷ search outlines & tags (ctags)                             ⌘ ,t',
        \'Unite -vertical -winwidth=40 -direction=topleft -toggle outline'],
    \['▷ search marks',
        \'Unite -auto-preview mark'],
    \['▷ search folds',
        \'Unite -vertical -winwidth=30 -auto-highlight fold'],
    \['▷ search changes',
        \'Unite change'],
    \['▷ search jumps',
        \'Unite jump'],
    \['▷ search undos',
        \'Unite undo'],
    \['▷ search tasks                                               ⌘ ,;',
        \'Unite -toggle grep:%::FIXME|TODO|NOTE|XXX|COMBAK|@todo'],
    \]
" }}}

" yanks, registers & history menu
let g:unite_source_menu_menus.registers = {
    \ 'description' : '      yanks, registers & history
        \                            ⌘ [space]i',
    \}
let g:unite_source_menu_menus.registers.command_candidates = [
    \['▷ yanks                                                      ⌘ ,i',
        \'Unite history/yank'],
    \['▷ commands       (history)                                   ⌘ q:',
        \'Unite history/command'],
    \['▷ searches       (history)                                   ⌘ q/',
        \'Unite history/search'],
    \['▷ registers',
        \'Unite register'],
    \['▷ messages',
        \'Unite output:messages'],
    \['▷ undo tree      (gundo)                                     ⌘ ,u',
        \'GundoToggle'],
    \]
" }}}

" spelling menu
let g:unite_source_menu_menus.spelling = {
    \ 'description' : '       spell checking
        \                                        ⌘ [space]s',
    \}
let g:unite_source_menu_menus.spelling.command_candidates = [
    \['▷ spell checking in Spanish                                  ⌘ ,ss',
        \'setlocal spell spelllang=es'],
    \['▷ spell checking in English                                  ⌘ ,se',
        \'setlocal spell spelllang=en'],
    \['▷ turn off spell checking                                    ⌘ ,so',
        \'setlocal nospell'],
    \['▷ jumps to next bad spell word and show suggestions          ⌘ ,sc',
        \'normal ,sc'],
    \['▷ jumps to next bad spell word                               ⌘ ,sn',
        \'normal ,sn'],
    \['▷ suggestions                                                ⌘ ,sp',
        \'normal ,sp'],
    \['▷ add word to dictionary                                     ⌘ ,sa',
        \'normal ,sa'],
    \]

" text edition menu
let g:unite_source_menu_menus.text = {
    \ 'description' : '           text edition
        \                                          ⌘ [space]e',
    \}
let g:unite_source_menu_menus.text.command_candidates = [
    \['▷ toggle wrapping                                            ⌘ ,ew',
        \'call ToggleWrap()'],
    \['▷ show hidden chars                                          ⌘ ,eh',
        \'set list!'],
    \['▷ toggle fold                                                ⌘ /',
        \'normal za'],
    \['▷ open all folds                                             ⌘ zR',
        \'normal zR'],
    \['▷ close all folds                                            ⌘ zM',
        \'normal zM'],
    \['▷ copy to the clipboard                                      ⌘ ,y',
        \'normal ,y'],
    \['▷ paste from the clipboard                                   ⌘ ,p',
        \'normal ,p'],
    \['▷ toggle paste mode                                          ⌘ ,P',
        \'normal ,P'],
    \['▷ remove trailing whitespaces                                ⌘ ,et',
        \'normal ,et'],
    \['▷ text statistics                                            ⌘ ,es',
        \'Unite output:normal\ ,es -no-cursor-line'],
    \['▷ show word frequency                                        ⌘ ,ef',
        \'Unite output:WordFrequency'],
    \['▷ show available digraphs',
        \'digraphs'],
    \['▷ insert lorem ipsum text',
        \'exe "Loremipsum" input("numero de palabras: ")'],
    \['▷ show current char info                                     ⌘ ga',
        \'normal ga'],
    \]

" neobundle menu
let g:unite_source_menu_menus.neobundle = {
    \ 'description' : '      plugins administration with neobundle
        \                 ⌘ [space]n',
    \}
let g:unite_source_menu_menus.neobundle.command_candidates = [
    \['▷ neobundle',
        \'Unite neobundle'],
    \['▷ neobundle log',
        \'Unite neobundle/log'],
    \['▷ neobundle lazy',
        \'Unite neobundle/lazy'],
    \['▷ neobundle update',
        \'Unite neobundle/update'],
    \['▷ neobundle search',
        \'Unite neobundle/search'],
    \['▷ neobundle install',
        \'Unite neobundle/install'],
    \['▷ neobundle check',
        \'Unite -no-empty output:NeoBundleCheck'],
    \['▷ neobundle docs',
        \'Unite output:NeoBundleDocs'],
    \['▷ neobundle clean',
        \'NeoBundleClean'],
    \['▷ neobundle list',
        \'Unite output:NeoBundleList'],
    \['▷ neobundle direct edit',
        \'NeoBundleExtraEdit'],
    \]

" git menu
let g:unite_source_menu_menus.git = {
    \ 'description' : '            admin git repositories
        \                                ⌘ [space]g',
    \}
let g:unite_source_menu_menus.git.command_candidates = [
    \['▷ tig                                                        ⌘ ,gt',
        \'normal ,gt'],
    \['▷ git viewer             (gitv)                              ⌘ ,gv',
        \'normal ,gv'],
    \['▷ git viewer - buffer    (gitv)                              ⌘ ,gV',
        \'normal ,gV'],
    \['▷ git status             (fugitive)                          ⌘ ,gs',
        \'Gstatus'],
    \['▷ git diff               (fugitive)                          ⌘ ,gd',
        \'Gdiff'],
    \['▷ git commit             (fugitive)                          ⌘ ,gc',
        \'Gcommit'],
    \['▷ git log                (fugitive)                          ⌘ ,gl',
        \'exe "silent Glog | Unite -no-quit quickfix"'],
    \['▷ git log - all          (fugitive)                          ⌘ ,gL',
        \'exe "silent Glog -all | Unite -no-quit quickfix"'],
    \['▷ git blame              (fugitive)                          ⌘ ,gb',
        \'Gblame'],
    \['▷ git add/stage          (fugitive)                          ⌘ ,gw',
        \'Gwrite'],
    \['▷ git checkout           (fugitive)                          ⌘ ,go',
        \'Gread'],
    \['▷ git rm                 (fugitive)                          ⌘ ,gR',
        \'Gremove'],
    \['▷ git mv                 (fugitive)                          ⌘ ,gm',
        \'exe "Gmove " input("destino: ")'],
    \['▷ git push               (fugitive, buffer output)           ⌘ ,gp',
        \'Git! push'],
    \['▷ git pull               (fugitive, buffer output)           ⌘ ,gP',
        \'Git! pull'],
    \['▷ git command            (fugitive, buffer output)           ⌘ ,gi',
        \'exe "Git! " input("comando git: ")'],
    \['▷ git edit               (fugitive)                          ⌘ ,gE',
        \'exe "command Gedit " input(":Gedit ")'],
    \['▷ git grep               (fugitive)                          ⌘ ,gg',
        \'exe "silent Ggrep -i ".input("Pattern: ") | Unite -no-quit quickfix'],
    \['▷ git grep - messages    (fugitive)                          ⌘ ,ggm',
        \'exe "silent Glog --grep=".input("Pattern: ")." | Unite -no-quit quickfix"'],
    \['▷ git grep - text        (fugitive)                          ⌘ ,ggt',
        \'exe "silent Glog -S".input("Pattern: ")." | Unite -no-quit quickfix"'],
    \['▷ git init                                                   ⌘ ,gn',
        \'Unite output:echo\ system("git\ init")'],
    \['▷ git cd                 (fugitive)',
        \'Gcd'],
    \['▷ git lcd                (fugitive)',
        \'Glcd'],
    \['▷ git browse             (fugitive)                          ⌘ ,gB',
        \'Gbrowse'],
    \['▷ github dashboard       (github-dashboard)                  ⌘ ,gD',
        \'exe "GHD! " input("Username: ")'],
    \['▷ github activity        (github-dashboard)                  ⌘ ,gA',
        \'exe "GHA! " input("Username or repository: ")'],
    \['▷ github issues & PR                                         ⌘ ,gS',
        \'normal ,gS'],
    \]

" code menu
let g:unite_source_menu_menus.code = {
    \ 'description' : '           code tools
        \                                            ⌘ [space]p',
    \}
let g:unite_source_menu_menus.code.command_candidates = [
    \['▷ run with python2 in tmux panel             (vimux)         ⌘ ,rr',
        \'normal ,rr'],
    \['▷ run with python3 in tmux panel             (vimux)         ⌘ ,r3',
        \'normal ,r3'],
    \['▷ run with python2 & time in tmux panel      (vimux)         ⌘ ,rt',
        \'normal ,rt'],
    \['▷ run with pypy & time in tmux panel         (vimux)         ⌘ ,rp',
        \'normal ,rp'],
    \['▷ command prompt to run in a tmux panel      (vimux)         ⌘ ,rc',
        \'VimuxPromptCommand'],
    \['▷ repeat last command                        (vimux)         ⌘ ,rl',
        \'VimuxRunLastCommand'],
    \['▷ stop command execution in tmux panel       (vimux)         ⌘ ,rs',
        \'VimuxInterruptRunner'],
    \['▷ inspect tmux panel                         (vimux)         ⌘ ,ri',
        \'VimuxInspectRunner'],
    \['▷ close tmux panel                           (vimux)         ⌘ ,rq',
        \'VimuxCloseRunner'],
    \['▷ count lines of code',
        \'Unite -default-action= output:call\\ LinesOfCode()'],
    \]

" markdown menu
let g:unite_source_menu_menus.markdown = {
    \ 'description' : '       preview markdown extra docs
        \                           ⌘ [space]k',
    \}
let g:unite_source_menu_menus.markdown.command_candidates = [
    \['▷ preview',
        \'Me'],
    \['▷ refresh',
        \'Mer'],
    \]

" bookmarks menu
let g:unite_source_menu_menus.bookmarks = {
    \ 'description' : '      bookmarks
        \                                             ⌘ [space]m',
    \}
let g:unite_source_menu_menus.bookmarks.command_candidates = [
    \['▷ open bookmarks',
        \'Unite bookmark:*'],
    \['▷ add bookmark',
        \'UniteBookmarkAdd'],
    \]

" vim menu {{{
let g:unite_source_menu_menus.vim = {
    \ 'description' : '            vim
        \                                                   ⌘ [space]v',
    \}
let g:unite_source_menu_menus.vim.command_candidates = [
    \['▷ choose colorscheme',
        \'Unite colorscheme -auto-preview'],
    \['▷ mappings',
        \'Unite mapping -start-insert'],
    \['▷ edit configuration file (vimrc)',
        \'edit $MYVIMRC'],
    \['▷ choose filetype',
        \'Unite -start-insert filetype'],
    \['▷ vim help',
        \'Unite -start-insert help'],
    \['▷ vim commands',
        \'Unite -start-insert command'],
    \['▷ vim functions',
        \'Unite -start-insert function'],
    \['▷ vim runtimepath',
        \'Unite -start-insert runtimepath'],
    \['▷ vim command output',
        \'Unite output'],
    \['▷ unite sources',
        \'Unite source'],
    \]

call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file_mru,file_rec,file_rec/async,grep,locate',
            \ 'ignore_pattern', join(['\.git/', 'tmp/', 'bundle/'], '\|'))

let g:unite_enable_ignore_case               = 1
let g:unite_enable_smart_case                = 1
let g:unite_enable_start_insert              = 1
let g:unite_enable_split_vertically          = 0
let g:unite_source_file_mru_limit            = 300
let g:unite_source_file_rec_min_cache_files  = 300
let g:unite_source_file_rec_max_depth        = 10
let g:unite_kind_openable_cd_command         = 'TabpageCD'
let g:unite_kind_openable_lcd_command        = 'TabpageCD'
let g:unite_source_history_yank_enable       = 1
let g:unite_source_bookmark_directory        = $HOME . "/.unite/bookmark"
let g:unite_source_gtags_treelize            = 1
let g:unite_source_history_yank_enable       = 1
let g:unite_enable_short_source_mes          = 0
let g:unite_force_overwrite_statusline       = 0
let g:unite_prompt                           = '>> '
let g:unite_marked_icon                      = '✓'
let g:unite_winheight                        = 15
let g:unite_update_time                      = 200
let g:unite_split_rule                       = 'botright'
let g:unite_data_directory                   = $HOME.'/.vim/tmp/unite'
let g:unite_source_buffer_time_format        = '(%d-%m-%Y %H:%M:%S) '
let g:unite_source_file_mru_time_format      = '(%d-%m-%Y %H:%M:%S) '
let g:unite_source_directory_mru_time_format = '(%d-%m-%Y %H:%M:%S) '

if executable('ag')
    let g:unite_source_grep_command               = 'ag'
    let g:unite_source_grep_default_opts          = '--nocolor --nogroup -a -S'
    let g:unite_source_grep_recursive_opt         = ''
    let g:unite_source_grep_search_word_highlight = 1
elseif executable('ack')
    let g:unite_source_grep_command               = 'ack'
    let g:unite_source_grep_default_opts          = '--no-group --no-color'
    let g:unite_source_grep_recursive_opt         = ''
    let g:unite_source_grep_search_word_highlight = 1
endif
