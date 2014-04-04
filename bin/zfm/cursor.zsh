#!/usr/bin/env zsh
# ----------------------------------------------------------------------------- #
#         File: cursor.zsh
#  Description: cursor movement (arrow key) for file lists
#       Author: rkumar http://github.com/rkumar/rbcurse/
#         Date: 2013-01-21 - 13:22
#      License: Same as Ruby's License (http://www.ruby-lang.org/LICENSE.txt)
#  Last update: 2013-02-23 20:23
# ----------------------------------------------------------------------------- #
# ## maybe we should have an initi method to be called by zfm
# and we shd put a check that this file is not sourced more than once
# -- trying out on 2013-01-20 - 22:15 
## we simulate a cursor or current line with arrow keys
##  so that user can press ENTER and get the fileopt menu for that file
function cursor_init() {
    export M_CURSOR_MOVEMENT_LOADED=1
    export CURSOR_MARK='>'
    CURSOR=1
    zfm_bind_key "DOWN" "cursor_down"
    zfm_bind_key "UP" "cursor_up"
    zfm_bind_key "RIGHT" "cursor_right"
    zfm_bind_key "LEFT" "cursor_left"
    zfm_bind_key "PgDn" "cursor_bottom"
    zfm_bind_key "PgUp" "cursor_top"
    zfm_bind_key "ENTER" "zfm_open_file"
    zfm_bind_key "ML g" "edit_cursor"
    # goto parent can be confusing and sudden, altho nice to have when you want it
    #   but i happens when you don't expect it too.
    #cursor_up_action=_my_goto_parent
    cursor_left_action=_my_popd
    cursor_right_action=_my_cd
    cursor_down_action=
    add_hook "on_enter_row" display_file_details
}

[[ -z $M_CURSOR_MOVEMENT_LOADED ]] && cursor_init

function cursor_down () {
    #PREV_CURSOR=$CURSOR
    save_cursor
    $cursor_down_action
    [[ $? -eq 1 ]] && return
    #let CURSOR++
    local pos
    curpos pos 
    (( pos += 1 ))

    zfm_goto_line $pos
    # if exceeding page, try a page down
    #(( CURSOR > $#vpa )) && { zfm_next_page  }
    [[ $PREV_CURSOR -ne $CURSOR ]] && on_enter_row
}
function cursor_up () {
    #PREV_CURSOR=$CURSOR
    save_cursor
    ## -le required for empty dirs
    $cursor_up_action
    #[[ $? -eq 1 ]] && return
    #let CURSOR--
    local pos
    curpos pos 
    (( pos -= 1 ))
    zfm_goto_line $pos
    M_MESSAGE=
    #(( CURSOR < 1 )) && zfm_prev_page
    #(( CURSOR < 1 )) && CURSOR=1
    [[ $PREV_CURSOR -ne $CURSOR ]] && on_enter_row
}
function _my_goto_parent() {
    [[ $CURSOR -le 1 ]] && { zfm_goto_parent_dir ; return 1 }
    return 0
}
## goes to files in next column
# if no files on right, and on a dir, then goes into dir
# XXX if we are not displayig entire list shouldnot right pan to other rows basically paging
function cursor_right () {
    #PREV_CURSOR=$CURSOR
    save_cursor
    $cursor_right_action
    [[ $? -eq 1 ]] && return

    local old=$CURSOR

    _rows=$(ceiling_divide $#vpa $LIST_COLS)
    (( CURSOR += _rows ))
    (( CURSOR < 1 )) && CURSOR=1
    (( CURSOR > $#vpa )) && { 
        CURSOR=$PREV_CURSOR
        (( rem = CURSOR / _rows ))
        (( CURSOR = ( CURSOR - ( _rows * rem )) + 1 ))

    }
    [[ $PREV_CURSOR -ne $CURSOR ]] && on_enter_row
}
function _my_cd() {
    ## slightly dicey or clever if right pressed on a dir
    # and you can't go anymore right then traverse into the dir.
    # Should we do this always on a dir, or only if there's one row ?
    #
    #(( CURSOR >= $#vpa )) && { 
        #CURSOR=$#vpa
        if [[ $LIST_COLS -eq 1 ]]; then
            selected=$vpa[$PREV_CURSOR]
            if [[ -d "$selected" ]]; then
                selection=$selected
                return 1
            fi
        fi
    #}
    return 0
}
## moves to files in left column
# if pressed on first file, pops dir stack
function cursor_left () {
    #PREV_CURSOR=$CURSOR
    save_cursor
    ## -le required for empty dirs
    $cursor_left_action
    [[ $? -eq 1 ]] && return
    _rows=$(ceiling_divide $#vpa $LIST_COLS)
    (( CURSOR -= _rows ))
    #(( CURSOR < 1 )) && CURSOR=1
    (( CURSOR < 1 )) && { 
        CURSOR=$PREV_CURSOR
        (( i = _rows * ( LIST_COLS - 1) ))
        (( CURSOR = ( i + CURSOR - 1 ) ))

    }
    (( CURSOR > $#vpa )) && CURSOR=$#vpa

    [[ $PREV_CURSOR -ne $CURSOR ]] && on_enter_row
}
function _my_popd() {
    [[ $CURSOR -le 1 ]] && { zfm_popd ; return 1 }
    return 0
}
# http://stackoverflow.com/questions/2394988/get-ceiling-integer-from-number-in-linux-bash
ceiling_divide() {
  ceiling_result=$((($1+$2-1)/$2))
  print $ceiling_result
}
#
# typically mapped to PgUp
function cursor_top () {
    #PREV_CURSOR=$CURSOR
    #if [[ $CURSOR -eq 1 ]]; then
        #(( CURSOR = 0 ))
    #else
        #CURSOR=1
    #fi
    #if [[ $CURSOR -gt 1 ]]; then
        #(( CURSOR = 1 ))
    #else
    #fi
    zfm_prev_page
    [[ $PREV_CURSOR -ne $CURSOR ]] && on_enter_row
}
#
# typically mapped to PgDn
function cursor_bottom () {
    #PREV_CURSOR=$CURSOR
    #if [[ $CURSOR -eq $VPACOUNT ]]; then
        #(( CURSOR = VPACOUNT + 1 ))
    #else
        #CURSOR=$#vpa
    #fi
    zfm_next_page
    [[ $PREV_CURSOR -ne $CURSOR ]] && on_enter_row
}
function select_current_line () {
    [[ -z "$CURSOR" ]] && { perror "Cursor not on a row." ; return 1; }
    local selected
    M_NO_AUTO=1
    selected=$vpa[$CURSOR]
    if [[ -d "$selected" ]]; then
        ## or should we have some options for directories ? we should
        #FT_DIRS
        # this falls through into caller of list_printer which changes
        # dirctory.
        #selection=$selected
        fileopt $selected
    else
        fileopt $selected
    fi
}
## what to do when user enters a row, such as display some text or 
# help or pop or enter dir
function on_enter_row() {
    local selected sd
    selected=$vpa[$CURSOR]
    execute_hooks "on_enter_row" $selected
}
function display_file_details() {
    local selected=$1
    if [[ -d "$selected" ]]; then
        M_MESSAGE=
        #
    else
        #M_MESSAGE="=> Press Enter to run command on file"
        #
        ## only display details in multicol listing when file details are not shown
        if [[ $LIST_COLS -gt 1 ]]; then
            get_file_details $selected
            sd=${(S)_detail//$TAB/ }
            M_MESSAGE="$M_HELP $sd"
        fi
    fi

}
## 
# goto specified line
# Note: in hint mode user will not see line number, so he will use a hint.
#       In INS mode its even worse, we could have displayed line numbers at this point
#       like we do when "g" is pressed in VIM mode.
#
function edit_cursor() {
    local pos
    print -n "Goto Line: "
    read pos
    # Assume if user pressed alpha he's in HINT mode and wants to jump to that hint.
    if [[ $ZFM_MODE == "HINT" ]]; then
        if [[ $pos =~ ^[a-zA-Z]$ ]]; then
            iix=$MFM_NLIDX[(i)$pos]
            pos=$iix
        fi
    fi
    [[ -n $pos ]] && zfm_goto_line $pos
}
