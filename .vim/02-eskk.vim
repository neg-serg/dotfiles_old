if !exists('g:eskk#disable') || !g:eskk#disable
  let g:eskk#directory = "~/.vim/.eskk"
let g:eskk#dictionary = { 'path': "~/.vim/dict/skk.dict", 'sorted': 0, 'encoding': 'utf-8', }
  " let g:eskk#large_dictionary = { 'path': "~/SKK-JISYO.L", 'sorted': 1, 'encoding': 'euc-jp', }
  let g:eskk#enable_completion = 1
  let g:eskk#start_completion_length = 2
  let g:eskk_map_normal_keys = 1
  let g:eskk#use_cursor_color = 1
  let g:eskk#show_annotation = 1
  let g:eskk#keep_state = 0
endif
" overwrite other plugin setting (e.g.) smartinput)
imap <C-j> <Plug>(eskk:toggle)
