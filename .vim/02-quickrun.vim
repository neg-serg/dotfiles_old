let g:quickrun_config = {}
let g:quickrun_config._ = {'runner': "vimproc"}
let g:quickrun_config["watchdogs_checker/_"] = {
    \ "runner" : "vimproc",
    \ "outputter" : "quickfix",
    \ "hook/quickfix_status_enable/enable_exit" : 1,
    \ "hook/quickfixsigns_enable/enable_exit" : 1,
    \ "hook/qfixgrep_enable/enable_exit" : 1,
    \ 'runmode' : "async:remote:vimproc",
    \ }
" TODO: should consider class_path, and library on scala application
let g:quickrun_config['scala/watchdogs_checker'] = {"type" : "watchdogs_checker/nop"}
let g:quickrun_config['watchdogs_checker/nop'] = {
    \ "command" : "echo",
    \ "exec" : "%c nop",
    \}
