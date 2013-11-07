" Eclim settings
" ,i imports whatever is needed for current line
nnoremap <silent> <LocalLeader>i :JavaImport<cr>
" ,d opens javadoc for statement in browser
nnoremap <silent> <LocalLeader>d :JavaDocSearch -x declarations<cr>
" ,<enter> searches context for statement
nnoremap <silent> <LocalLeader><cr> :JavaSearchContext<cr>
" ,jv validates current java file
nnoremap <silent> <LocalLeader>jv :Validate<cr>
" ,jc shows corrections for the current line of java
nnoremap <silent> <LocalLeader>jc :JavaCorrect<cr>
" 'open' on OSX will open the url in the default browser without issue
let g:EclimBrowser='open'
" Disable Eclim's taglisttoo because I use the regular taglist plugin
"let g:taglisttoo_disabled = 1
" Disable HTML & PHP validation
let g:EclimHtmlValidate = 0
let g:EclimPhpValidate = 0
