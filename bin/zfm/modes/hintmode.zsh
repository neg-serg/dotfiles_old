#!/usr/bin/env zsh
# ----------------------------------------------------------------------------- #
#         File: hintmode.zsh
#  Description: hint mode, like vimperator, each file has a shortcut
#       Author: rkumar http://github.com/rkumar/zfm/
#         Date: 2013-02-06 - 22:31
#      License: GPL
#  Last update: 2013-03-03 15:18
# ----------------------------------------------------------------------------- #
#  Copyright (C) 2012-2013 rahul kumar

function hintmode_init() {
    #mess "HINT Mode: C-c: Exit mode"
    clear_mess
    M_FULL_INDEXING=1
    #[[ $ZFM_PREV_MODE == "HINT" ]] || ZFM_PREV_MODE=$ZFM_MODE


    # do once 
    local aa
    aa=(C-c Cancel C-g "Clear Pattern" Esc "Vim Mode")
    M_HELP_HINT=$( print_hash $aa )
}
function hint_key_handler() {
    local ans=$1
    # is ix even used ?? XX
    local ix
    case $ans in
        Q)
            QUITTING=true
            ;; 
        [1-9a-zA-Z])
            zfm_get_full_indexing_filename $ans
            ## in case caller wishes to use once and exit
            [[ -n $M_HINT_EXIT_IMMED ]] && hint_exit_mode
            ;;
        $ZFM_REFRESH_KEY)
            zfm_refresh
            ;;
        "$ZFM_RESET_PATTERN_KEY")
            PATT=""
            ;;
        #"ZFM_OPEN_FILES_KEY")
            ## I think this overrides what cursor.zsh defines
            ### Open either selected files or what's under cursor
            #if [[ -n $selectedfiles ]];then 
                #call_fileoptions $selectedfiles
            #else
                #selection=$vpa[$CURSOR]
            #fi
            #[[ -n "$selection" ]] && break
            #;; 
        "C-g" )
            PATT=
            ;;
        "C-c")
            hint_exit_mode
            ;;

        *)
            zfm_exec_key_binding $ans
            ans=
            ;; 
    esac

    ## above this line is insert mode
}
function hint_exit_mode() {
    M_FULL_INDEXING=
    M_HINT_EXIT_IMMED=
    M_HINT_POSITION_CURSOR_ONLY=
    local mo=$ZFM_PREV_MODE
    if [[ $ZFM_PREV_MODE == "HINT" ]]; then
        mo=$ZFM_DEFAULT_MODE
    fi
    zfm_set_mode $mo

}
