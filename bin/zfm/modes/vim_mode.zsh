#!/usr/bin/env zsh
# ----------------------------------------------------------------------------- #
#         File: vim_mode.zsh
#  Description: 
#       Author: rkumar http://github.com/rkumar/rbcurse/
#         Date:zfm_goto_dir 2013-02-02 - 00:48
#      License: Same as Ruby's License (http://www.ruby-lang.org/LICENSE.txt)
#  Last update: 2013-03-03 15:19
# ----------------------------------------------------------------------------- #
    typeset -Ag keymap_VIM
    typeset -Ag vim_selector
function vimmode_init() {
    #M_MESSAGE="VIM Mode: q/C-q to Quit, i: insert mode, ': HINTS mode, o: open, x: select"
    MULTIPLIER=
    PENDING=()
    PENDING_KEY=

    [[ -n $M_VIMMODE_LOADED ]] && return 1
    export M_VIMMODE_LOADED=1
    #typeset -Ag keymap_VIM
    #typeset -Ag vim_selector
    local aa
    aa=(i INS $ZFM_HINT_KEY HINT o Open)
    M_HELP_VIM=$( print_hash $aa )

    ## can use x for selecting as gmail and o for open
    ## can use ' or whatever for hints as in vimperator, it uses 'f' but f has naother meaning here
    # jump to hints for one selection
    #vim_bind_key "m" "zfm_mark"
    vim_bind_key "j" "vim_cursor_down"
    vim_bind_key "k" "vim_cursor_up"
    vim_bind_key "l" "cursor_right"
    vim_bind_key "h" "cursor_left"
    # i could have put the name of the fucntion to call here itself but the caller
    # does not do an eval, it executes the method and i don't want an eval happening
    vim_bind_key "g" "vim_set_pending vim_goto_line"
    ## actually G defaults to EOF otherwise it goes to line of MULTI
    vim_bind_key "G" "vim_goto_end"
    vim_bind_key "g d" "vim_goto_next_dir"
    vim_bind_key "g b" "zfm_popd"
    #vim_bind_key "s" "vim_set_selector selected"
    #vim_bind_key "S" "vim_set_selector unselected"
    #vim_bind_key "a" "vim_set_selector all"
    vim_bind_key "H" "vim_motion PAGE_TOP"
    vim_bind_key "L" "vim_motion PAGE_END"
    # temp using y to select, coud make it t meaning tag
    #vim_bind_key "y" "vim_set_pending zfm_add_to_selection"
    #vim_bind_key "Y" "vim_exec zfm_add_to_selection"
    vim_bind_pair "y" "zfm_add_to_selection"
    # temporarily using C to clear selection as opposite of y
    #vim_bind_key "c" "vim_set_pending zfm_remove_from_selection"
    vim_bind_pair "c" "zfm_remove_from_selection"
    #vim_bind_key "d" "vim_set_pending $ZFM_RM_COMMAND"
    vim_bind_pair "d" "$ZFM_RM_COMMAND"
    vim_bind_pair "o" "$EDITOR"
    # directly open the file, no count etc
    vim_bind_key "e" "select_current_line"
    vim_bind_key "x" "zfm_toggle_file"
    #vim_bind_key "y y" "zfm_add_to_selection"
    #vim_bind_key "y G" "zfm_add_to_selection $CURSOR $VPACOUNT"
    # actually we woul rather G and $ etc be defined as motion so they can call others
    # if operator pending
    # "G" "vim_motion $END"
    #
    # all motions commands should calculate position to go to and then call vim_motion with lineno.
    # vim_motion:
    #   checks if operator pending then calls "y" with range, or just sets range and returns
    #   else it moves to that position.
    #   "y" "vim_resolve zfm_add_to_selection"
    #vim_bind_key "'" "vim_resolve"

    vim_bind_key "ESCAPE" "vim_escape"
    vim_bind_key "C-c" "vim_escape"
    vim_bind_key "C-g" "vim_escape"
    vim_bind_key "Q" "exit_vim"
    vim_bind_key "g h" "zfm_goto_parent_dir"
    vim_bind_key "t" "zfm_goto_dir"
    # optional for those who like pentadactyl vimperator
    vim_bind_key "f" "vim_jump_to_hint"
    vim_bind_key "ENTER" "zfm_open_file"
    vim_bind_key "g l" "select_current_line"
    vim_bind_key "i" "zfm_set_mode INS"

    vim_def_selector "s" "selected"
    vim_def_selector "S" "unselected"
    vim_def_selector "a" "all"

    # ' will curently look in zfm bindings since it doesn not know where to look
    #  We could first look in mode and then global.
    zfm_bind_key "' '" "vim_goto_last_position"
}
## these are selectors that can be placed after a pending command such as g or y or d
#  They need not correspond to another command, thus you can have a selector "s" and no command
#  "s" or an unrelated command "s". We could further specify motion selectors and filelist selectors
#  so we can be more precise and keep programming simpler. motions selectros will return a location
#  (file location or curpos, wherease the other will return a filelist to operate on.
#
function vim_def_selector () {
    vim_selector[$1]=$2
}
function vim_key_handler() {
    local key=$1
        if [[ "$key" == <0-9> ]]; then
            vim_int_handler $key
        elif [[ $key =~ ^[a-zA-Z]$ ]]; then
            ## should only be one character otherwise C- and M- etc will all come
            vim_char_handler $key
        elif [[ $#key -eq 1 ]]; then
            # poach on global
            vim_other_handler $key
        else
            ## control and meta up down etc
            binding=$keymap_VIM[$key]
            if [[ -n $binding ]]; then
                zfm_exec_binding $binding
            else
                ## TODO poach on global functions
                zfm_get_key_binding $ZFM_KEY
                [[ -n $binding ]] && zfm_exec_binding $binding
            fi
        return
    fi
}
function exit_vim() {
   if [[ $ZFM_DEFAULT_MODE == "VIM" ]]; then
       QUITTING=true
   else
       zfm_set_mode $ZFM_DEFAULT_MODE
   fi
}
function vim_bind_key() {
    # should we check for existing and refuse ?
    keymap_VIM[$1]=$2
    if (( ${+keymap_VIM[$1]} )); then
    else
        perror "Unable to bind $1 to vim keymap "
        pause
    fi
}
## 
# Bind both lowercase and uppercase character such as dd and D or yy and Y to related commands.
#
function vim_bind_pair() {
    local ch=$1
    local fn=$2
    chu=${ch:u}
    vim_bind_key $ch "vim_set_pending $fn"
    vim_bind_key $chu "vim_exec $fn"
}
## some operations like y and d cannot work without a second character which could be 
# a motion command or the same char. So we set the command as pending a motion command.
# If a yy or dd happends then call that same command. Else push that command onto pending stack.
function vim_set_pending() {
    ZFM_NUMBERING="ABSOLUTE"
    local f=$1
    local k=$ZFM_KEY
    ## selector comes at end only must clear off earlier
    #M_SELECTOR=
    if [[ -n $PENDING ]]; then
        if [[ $PENDING[-1] == $f ]]; then
            PENDING[-1]=()
            PENDING_KEY=
            M_MESSAGE="$M_HELP"
            #zfm_exec_binding $f
            vim_exec $f
            return
        fi
    fi
    M_MESSAGE="$M_HELP [$ans PENDING either $ans or motion $MULTIPLIER, $M_SELECTOR]"
    PENDING+=( $f )
    PENDING_KEY=$k
}
function vim_exec() {
    # first check mult
    # then check range
    # else current cursor
    local f=$1
    ## goto line requires only multiplier not file names
    # This was preventing gg from working
    # But this means this can't work with selectors
    [[ $f == "vim_goto_line" ]] && { $f ; return 0 }

    local n=$MULTIPLIER
    if [[ -n $MULTIPLIER ]]; then
        calc_range
        ## cannot do this for vim_goto_line uses MULTIPLIER
        MULTIPLIER=
    fi
    # what if I want to send file names together
    # such as to vim, so they open in one process 
    if [[ -n $RANGE_START ]]; then
        ## Some commands expect file names one by one such as zfm_add_to_selection
        # at least at present, but for some such as vim it can be a pain to open 
        # vim multiple times, maybe we can ensure that all commands can handle multiple
        # files
        ## this will not work in the case of vim_goto_line which expect number not filename
        # actually we need to send this to zfm_exec_binding and not just execit straight
        #if [[ $f =~ ^vi ]]; then
            #slice=($vpa[$RANGE_START,$RANGE_END])
            #slice=( $PWD/$^slice )
            #$f $slice
        #else

        ## !!! XXX vim_goto_line wants the MULTIPLER not something else
        #
        if [[ -n "$M_FILES_1b1" ]]; then
            for (( i = $RANGE_START; i <= $RANGE_END; i++ )); do
                ## can only go till end of viewport not complete list XXX
                #$f $PWD/$vpa[$i] 
                $f $PWD/$viewport[$i] 
            done
        else
            ## best to pass files together so commands like vim can open in one process
            #slice=($vpa[$RANGE_START,$RANGE_END])
            slice=($viewport[$RANGE_START,$RANGE_END])
            slice=( $PWD/$^slice )
            pinfo "CALLING $f with $#slice ($RANGE_START , $RANGE_END : $slice[1]"
            $f $slice
        fi

    elif [[ -n $M_SELECTOR ]]; then
        case $M_SELECTOR in
            selected)
                if [[ $#selectedfiles -gt 0 ]]; then
                    $f $selectedfiles
                else
                    perror "$0: No selected files."
                fi
                ;;
            unselected)
                if [[ $#selectedfiles -gt 0 ]]; then
                    local vp
                    vp=($PWD/${^viewport}) # prepend PWD to each element 2013-01-10 - 00:17
                    unselectedfiles=( ${vp:|selectedfiles} )
                    $f $unselectedfiles
                else
                    perror "$0: No selected files."
                fi
                ;;
            all)
                vp=($PWD/${^viewport}) # prepend PWD to each element 2013-01-10 - 00:17
                $f $vp
                ;;
        esac
        [[ "$f" == $ZFM_RM_COMMAND ]] && zfm_refresh
        M_SELECTOR=
        ## s S a
        #
    else
        # take cursor pos
        # actually we need to send this to zfm_exec_binding and not just execit straight
        #
        pinfo "$0 calling $f with $PWD/$vpa[$CURSOR]"
        $f $PWD/$vpa[$CURSOR]
    fi
        RANGE_START=
        RANGE_END=
}
##  returns next selected element.
#   
function vim_ix_first_selection() {
    [[ $#selectedfiles -eq 0 ]] && { print $CURSOR; return 1}

    local vp c ix first
    let c=1
    let ix=0
    vp=($PWD/${^viewport}) # prepend PWD to each element 2013-01-10 - 00:17
    for ff in $vp ; do
        if [[ $selectedfiles[(i)$ff] -le $#selectedfiles ]]; then
            first=${first:-$c}
            abs_cursor
            [[ $c -gt $ABS_CURSOR ]] && { ix=$c ; break }
        fi
        (( c++ ))
    done
    if [[ $ix -eq 0 ]]; then
        print $first
    else
        print $ix
    fi
}
function vim_goto_next_dir() {
    offset=$(return_next_match is_dir)
    vim_motion $offset
}
function is_dir() {
    local file=$1
    [[ -d $1 ]] && return 0
    return 1
}
## 
# call this method giving it the name of another which it will call with a filename
# NOTE: the fullpath is sent not just basename
# If the method is not in this file (and not sourced), it may not be found. No error will be reported.
#
function return_next_match() {
    #[[ $#selectedfiles -eq 0 ]] && { print $CURSOR; return 1}

    local vp c ix first binding args
    binding=$1
    shift
    args=$*
    let c=1
    let ix=0
    vp=($PWD/${^viewport}) # prepend PWD to each element 2013-01-10 - 00:17
    for ff in $vp ; do
        #if [[ $selectedfiles[(i)$ff] -le $#selectedfiles ]]; then
        #if eval "$binding $ff $args"; then
        if $binding $ff $args; then
            first=${first:-$c}
            abs_cursor
            [[ $c -gt $ABS_CURSOR ]] && { ix=$c ; break }
        fi
        (( c++ ))
    done
    if [[ $ix -eq 0 ]]; then
        print $first
    else
        print $ix
    fi
}

## All motion command should call this command with the target
# rather than try to make the move themselves.
# This checks for a pending operation on which to act, if none then it makes the move
#
# Should we use some symbols like END START HOME MIDDLE etc so user can use these in definitions
# and have them computed somewhere like here, rather than try to put actual variable values in
#  when mapping. 
function vim_motion() {
    local _pos=$1
    ## if pos is a constant then we expect it to be defined as a variable and having that value
    if [[ $_pos =~ ^[A-Z] ]]; then
        # How are numbers coming in here ?
        pos=${(P)_pos}
        # in these cases MULT has no meaning and needs to be cleared
        # maybe in cases here
        MULTIPLIER=

        [[ -z $pos ]] && { 
            # UNTESTED UNUSED XXX
            #perror "$0 blank $_pos "
            #pause
            #if [[ -e $_pos ]]; then
                #ix=file_index($_pos)
                #pos=$ix
            #fi
        }
        [[ -z $pos ]] && { perror "$0:: Constant ($_pos) not defined"; pause; return 1 }
    else
        pos=$_pos
    fi

    ## check for pending method
    if [[ -n $PENDING ]]; then
        f=$PENDING[-1]
        PENDING[-1]=()
        ## the command called will check for CURSOR being current spot
        #  and CURSOR_TARGET as other spot
        #  or should we put START and END to make backward commands easy
        CURSOR_TARGET=$pos
        #RANGE_START=$CURSOR
        (( RANGE_START = CURSOR + sta - 1 ))
        RANGE_END=$CURSOR_TARGET
        (( CURSOR_TARGET < RANGE_START )) && { 
            RANGE_END=$RANGE_START
            RANGE_START=$CURSOR_TARGET
        }
        #pinfo "$0: $RANGE_START to $RANGE_END : $f"
        #pause
        ## 2013-02-09 - 18:37 seems in cases like y8gg 8gg correclt calculates 
        # backward range, but y recalculates 8 as multiplier, so we need to unset it
        MULTIPLIER=

        ## what if there's a multiplier thre, should we not unset it ? XXX 5yG
        # vim exec takes care of mult and range etc
        #if [[ $f == "vim_goto_line" ]]; then
            ## other commands need filenames but this needs only multiplier
            #$f
        #else
        vim_exec $f
        #fi
        RANGE_START=
        RANGE_END=
        return
    else
        ## make the move
        #PREV_CURSOR=$CURSOR
        #save_cursor
        pos=${pos:-1}
        zfm_goto_line $pos
    fi
}
function file_index() {
    local files file
    files=($@)
    file=$files[1]
    file=${file:t}
    ix=$vpa[(i)$file]
    print $ix
}

## now only calling if this if pending operator
# so we free the key from having to be defined
function vim_set_selector() {
    local sel=$1
    M_SELECTOR=$sel
    ## check for pending method
    if [[ -n $PENDING ]]; then
        f=$PENDING[-1]
        PENDING[-1]=()
        PENDING_KEY=
        ## the command called will check for CURSOR being current spot
        #  and CURSOR_TARGET as other spot
        #  or should we put START and END to make backward commands easy
        ## what if there's a multiplier thre, should we not unset it ? XXX 5yG
        # vim exec takes care of mult and range etc

        ## set some flag for command to use selected files
        # or put them in a array
        M_SELECTOR=$sel
        vim_exec $f
        M_SELECTOR=
        RANGE_START=
        RANGE_END=
        return
    else
        ## no command, go to first selected file using vim motion
        ## make the move
        case $M_SELECTOR in
            selected)
                # goto first selected file
                # TODO if its on a selected file, then go ot next
                if [[ $#selectedfiles -gt 0 ]]; then
                    offset=$(vim_ix_first_selection)
                    vim_motion $offset
                else
                    perror "$0: No selected files"
                fi
                ;;
            unselected)
                # keep going til file unders cursor is not selected
                # TODO
                ;;
        esac
    fi
    M_SELECTOR=
}
function DEPRECATED_vim_resolve () {
    local key=$ZFM_KEY
    local binding _key ret=0

    read -k _key
    ckey="${key} $_key"
    binding=$keymap_VIM[$ckey]
    if [[ -n $binding ]]; then
        zfm_exec_binding $binding
    else
        perror "[$ckey]: $_key not bound to anything with $key in $ZFM_MODE:: ${(k)ZFM_MODE_MAP}"
        #for f ( ${(k)ZFM_MODE_MAP}) print "[$f] $ZFM_MODE_MAP[$f] ..."
    fi
    MULTIPLIER=""
    return $ret
}
function vim_int_handler() {
    local key=$1
        MULTIPLIER+=$1
        sms "multiplier is : $MULTIPLIER"
}
function vim_char_handler() {
    local key=$1
    ## check if pending and whether there's a key combo for that
    # That allows us to overload acommand as a selector like g d for goto next dir
    [[ -n $PENDING_KEY ]] && {
        ckey="$PENDING_KEY $key"
        binding=$keymap_VIM[$ckey]
        if [[ -n $binding ]]; then
            key=$ckey

            ## XXX This clearing means something like ygd will not work
            # since we have removed y and g. and do only "g d". 
            # If i comment this then it becomes just like 1yy.

            PENDING=()
            PENDING_KEY=
        else
            ## check for a selector and call it else let this continue
            # if not a selector either most likely an error - unless its a motion command

            _x=$vim_selector[$key]
            if [[ -n "$_x" ]]; then
                mess "found a selector $_x : $#PENDING :: $PENDING"
                vim_set_selector $_x
                return
            fi
        fi
    }

    binding=$keymap_VIM[$key]
    if [[ -n $binding ]]; then
        # we could be in pending mode at this point going into some command
        # that does not know that and should not work XXX
        zfm_exec_binding $binding
        # trying clearing 2013-02-05 - 20:15 so gxg goes not work
        #vim_clear_pending
    else 
        vim_clear_pending
    fi
}
function vim_other_handler() {
    ## this gives us unhandled punctuation and other chars which can be routed back to the main map

    vim_clear_pending
    zfm_get_key_binding $ZFM_KEY
    if [[ -n $binding ]]; then
        zfm_exec_binding $binding
    else
        M_MESSAGE=" No binding for $ZFM_KEY in global map"
    fi
}
## escape pressed clear stuff or pending commands if possible
function vim_escape() {
    # now that HINT is a separate mode next line won't work
    #[[ -n "$M_FULL_INDEXING" ]] && full_indexing_toggle
    clear_mess
    vim_clear_pending
}
vim_clear_pending() {

    MULTIPLIER=
    PENDING=()
    PENDING_KEY=
    RANGE_START=
    RANGE_END=
    M_SELECTOR=
}
function vim_cursor_down() {
    ZFM_NUMBERING="RELATIVE"
    #PREV_CURSOR=$CURSOR
    local n=$1
    n=${n:-$MULTIPLIER}
    n=${n:-1}
    local newpos
    (( newpos = ( sta + CURSOR - 1) + n ))
    MULTIPLIER=
    vim_motion $newpos
    #(( CURSOR += n ))
    #(( CURSOR > $#vpa )) && { zfm_next_page  }
}
function vim_cursor_up() {
    ZFM_NUMBERING="RELATIVE"
    PREV_CURSOR=$CURSOR
    local n=$1
    n=${n:-$MULTIPLIER}
    n=${n:-1}
    local newpos
    ## the next calc is fine when we are on a single page, and CURSO is absolute position
    #  but in multiple page listings sta also gets moved since we have begun calling zfm_goto_line
    #   This change may affect the set_pending code which uses CURSOR, it should use ABSO position.
    #(( newpos = CURSOR - n ))
    (( newpos = ( sta + CURSOR - 1 ) - n ))
    MULTIPLIER=
    vim_motion $newpos
    #(( CURSOR -= n ))
    #(( CURSOR < 1 )) && zfm_prev_page
    #(( CURSOR < 1 )) && CURSOR=1
    #MULTIPLIER=""
}

## Goes to specified line, else start.  
# see :help gg
function vim_goto_line() {
    PREV_CURSOR=$CURSOR
    # what if it is sent a file name by mistake and not a number
    local n=$1
    if [[ $n =~ [a-zA-Z] ]]; then
        ## XXX if file list then go to filest file that is in this dir (vpa)
        perror "$0 sent wrong argument $1"
        n=
    fi
    if [[ -n "$M_SELECTOR" ]]; then
        case $M_SELECTOR in
            selected)
                n=$(vim_ix_first_selection)
                ;;
            unselected)
                ## TODO take current position and go to first unselected item after this one
                ;;
            all)
                ;;
        esac
        M_SELECTOR=
    fi
    n=${n:-$MULTIPLIER}
    n=${n:-1}
    #let CURSOR=$n
    vim_motion $n
    # if exceeding page, try a page down
    #(( CURSOR > $#vpa )) && { zfm_next_page  }
    #(( CURSOR < 1 )) && CURSOR=1
    MULTIPLIER=
    #[[ $PREV_CURSOR -ne $CURSOR ]] && on_enter_row
}
## goes to line of MULT otherwise defaults to END 
# see :help G
function vim_goto_end() {
    PREV_CURSOR=$CURSOR
    local n
    n=$MULTIPLIER
    n=${n:-$END}
    MULTIPLIER=
    M_SELECTOR=
    vim_motion $n
}
## 
# revert to last position of cursor
#  VIM's '' (single quote two times)
#
function vim_goto_last_position(){
    # save old values in temp vars before saving new values in old
    # This way we can jump back
    local x y
    x=${PREV_CURSOR:-CURSOR}
    y=${OLD_STA:-1}

    save_cursor
    CURSOR=$x
    sta=$y
}
function vim_yank() {
    perror "$0 : is this called ?"
    pause
    # first check mult
    # then check range
    # else current cursor
    local n=$MULTIPLIER
    if [[ -n $MULTIPLIER ]]; then
        #RANGE_START=$CURSOR
        calc_range
        #(( RANGE_START = CURSOR + sta - 1 ))
        #(( RANGE_END = RANGE_START + MULTIPLIER ))
        MULTIPLIER=
    fi
    if [[ -n $RANGE_START ]]; then
        for (( i = $RANGE_START; i <= $RANGE_END; i++ )); do
            #zfm_add_to_selection $PWD/$vpa[$i] 
            zfm_add_to_selection $PWD/$viewport[$i] 
        done
    else
        # take cursor pos
        zfm_add_to_selection $PWD/$vpa[$CURSOR]
    fi
}
## this is identical to vim_yank except for the command called
function vim_delete() {
    perror "$0 : is this called ?"
    pause
    # first check mult
    # then check range
    # else current cursor
    local n=$MULTIPLIER
    if [[ -n $MULTIPLIER ]]; then
        calc_range
        MULTIPLIER=
    fi
    if [[ -n $RANGE_START ]]; then
        for (( i = $RANGE_START; i <= $RANGE_END; i++ )); do
            #$ZFM_RM_COMMAND $vpa[$i] 
            $ZFM_RM_COMMAND $viewport[$i] 
        done
    else
        # take cursor pos
        $ZFM_RM_COMMAND $vpa[$CURSOR]
    fi
}
function vim_help() {
    local str key
    str=" VIM MODE Help"
    str+=" \n"
    str+=" set_pending implies that a motion or selector key is pending, e.g. dG d2k gs ds\n"
    str+=" vim_exec implies that the key takes a count, but no key after. e.g. G 2Y 10D C O \n"
    local keys
    keys=(${(k)keymap_VIM})
    keys=(${(o)keys})
    for key in ${keys} ; do
        str+=$(print "    $key  : $keymap_VIM[$key]")"\n"
    done
    print -l -- $str
    
}
function vim_jump_to_hint() {
    M_HINT_EXIT_IMMED=1
    M_HINT_POSITION_CURSOR_ONLY=1
    zfm_set_mode HINT

}
function calc_range() {
    (( RANGE_START = CURSOR + sta - 1 ))
    (( RANGE_END = RANGE_START + MULTIPLIER - 1 ))
}
## I just made something called curpos in zfm.zsh which does same thing 
#  calculate absolute cursor and put in ABS_CURSOR
function abs_cursor() {
    (( ABS_CURSOR = CURSOR + sta - 1 ))
}



#[[ -z $M_VIMMODE_LOADED ]] && vimmode_init
